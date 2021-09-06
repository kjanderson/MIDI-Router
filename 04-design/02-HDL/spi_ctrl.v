/**********************************************************************
 * spi_ctrl
 *
 * Description
 * This module implements the controller for the SPI shift register.
 *
 * Notes
 * The state machine may cycle through several cmd/exe/ld/read sequences,
 * depending on how long spi_ss is deasserted, but it should work.
 *
 * The spi_ss needs to be deasserted for at least one sck bit time
 * between frames, to allow a read/execute operation to occur.
 *
 * Known Issues
 * The state machine cycles too many times. This causes write operations to fail,
 * because the write command gets latched the first cycle, but turned into a read
 * operation in the other cycles. It seems I still need some way to arm the mechanism.
 *
 * It looks like the bus strobe (wb_stb_o) doesn't assert during the read cycle,
 * and it asserts in the wrong part of the write cycle.
 * I think the strobe needs to be active during the entire bus cycle, read or write.
 *
 * TODO:
 * convert state machine into a Moore style state machine.
 * for some reason, the synthesis tool removes items that are in the output block,
 * and doesn't see the FSM.
 *********************************************************************/
module spi_ctrl
(
    reset,
    clk,
    spi_miso,
    spi_mosi,
    spi_sck,
    spi_ss,
    wb_addr_o,
    wb_dat_i,
    wb_dat_o,
    wb_stb_o,
    wb_ack_i,
    wb_we_o
);

parameter ST_IDLE    = 4'h0;
parameter ST_LAT_CMD = 4'h1;
parameter ST_CMD     = 4'h2;
parameter ST_WR_DATA = 4'h3;
parameter ST_WR_PREP = 4'h4;
parameter ST_WR_EXE  = 4'h5;
parameter ST_RD_PREP = 4'h6;
parameter ST_RD_EXE  = 4'h7;
parameter ST_RD_LOAD = 4'h8;
parameter ST_RD_DATA = 4'h9;
parameter ST_CLR     = 4'hA;

//`define BIT_WE 8'h80
//`define MASK_WE 8'h80
//`define MASK_ADDR 8'h7F

input  wire reset;
input  wire clk;
output wire spi_miso;
input  wire spi_mosi;
input  wire spi_sck;
input  wire spi_ss;
/* wishbone interface */
output wire [7:0] wb_addr_o;
input  wire [7:0] wb_dat_i;
output wire [7:0] wb_dat_o;
output wire wb_stb_o;
input  wire wb_ack_i;
output wire wb_we_o;

/* internal signals */
reg  [3:0] int_spi_curr_state;
reg  [3:0] int_spi_next_state;
reg        int_cmd;
reg  [6:0] int_addr;
reg  [7:0] int_data;

reg [7:0] int_spi_data_i;
wire [7:0] int_spi_data_o;
reg  spi_ld;
reg  int_wb_stb_o;
reg  int_wb_we_o;
wire int_spi_rdy;
wire int_timeout;
wire [7:0] int_cnt;

assign wb_addr_o = int_addr;
assign wb_dat_o = int_data;
assign wb_stb_o = int_wb_stb_o;
assign wb_we_o = int_wb_we_o;
assign int_timeout = &(int_cnt);

always @(int_spi_curr_state, int_spi_rdy, int_timeout, int_cmd, wb_ack_i)
begin: sm_cl
    case(int_spi_curr_state)
    ST_IDLE: begin
        if (int_spi_rdy == 1) begin
            int_spi_next_state = ST_LAT_CMD;
        end
        else begin
            int_spi_next_state = ST_IDLE;
        end
    end
    ST_LAT_CMD: begin
        int_spi_next_state = ST_CMD;
    end
    ST_CMD: begin
        if (int_timeout == 1) begin
            int_spi_next_state = ST_IDLE;
        end
        else begin
            if (int_cmd == 1) begin
                int_spi_next_state = ST_WR_DATA;
            end
            else begin
                int_spi_next_state = ST_RD_PREP;
            end
        end
    end
    ST_WR_DATA: begin
        if (int_timeout == 1) begin
            int_spi_next_state = ST_IDLE;
        end
        else begin
            if (int_spi_rdy == 1) begin
                int_spi_next_state = ST_WR_PREP;
            end
            else begin
                int_spi_next_state = ST_WR_DATA;
            end
        end
    end
    ST_WR_PREP: begin
        int_spi_next_state = ST_WR_EXE;
    end
    ST_WR_EXE: begin
        if (int_timeout == 1) begin
            int_spi_next_state = ST_IDLE;
        end
        else begin
            if (wb_ack_i == 1) begin
                int_spi_next_state = ST_CLR;
            end
            else begin
                int_spi_next_state = ST_WR_EXE;
            end
        end
    end
    ST_RD_PREP: begin
        int_spi_next_state = ST_RD_EXE;
    end
    ST_RD_EXE: begin
        if (int_timeout == 1) begin
            int_spi_next_state = ST_IDLE;
        end
        else begin
            if (wb_ack_i == 1) begin
                int_spi_next_state = ST_RD_LOAD;
            end
            else begin
                int_spi_next_state = ST_RD_EXE;
            end
        end
    end
    ST_RD_LOAD: begin
        int_spi_next_state = ST_RD_DATA;
    end
    ST_RD_DATA: begin
        if (int_timeout == 1) begin
            int_spi_next_state = ST_IDLE;
        end
        else begin
            if (int_spi_rdy == 1) begin
                int_spi_next_state = ST_CLR;
            end
            else begin
                int_spi_next_state = ST_RD_DATA;
            end
        end
    end
    ST_CLR: begin
        int_spi_next_state = ST_IDLE;
    end
    default: begin
        int_spi_next_state = ST_IDLE;
    end
    endcase
end

always @(posedge clk)
begin: bhv_sm_sl
    if (reset == 1'b1) begin
        int_spi_curr_state <= ST_IDLE;
    end
    else begin
        int_spi_curr_state <= int_spi_next_state;
    end
end

/* outputs controlled in this block:
 *   spi_ld
 *   int_addr
 *   int_cmd
 *   int_wb_we_o
 *   int_wb_stb_o
 *   int_spi_xchg_ack
 *   int_data
 */
always @(posedge clk)
begin: bhv_sm_op
    case(int_spi_curr_state)
    ST_IDLE: begin
        spi_ld <= 0;
        int_addr <= 7'h00;
        int_wb_we_o <= 0;
        int_cmd <= 0;
    end
    ST_LAT_CMD: begin
        int_cmd <= int_spi_data_o[7];
        int_addr <= int_spi_data_o[6:0];
    end
    ST_WR_PREP: begin
        int_wb_stb_o <= 1;
        int_wb_we_o <= 1;
        int_data <= int_spi_data_o;
    end
    ST_RD_PREP: begin
        int_wb_stb_o <= 1;
        int_wb_we_o <= 0;
    end
    ST_RD_LOAD: begin
        int_wb_stb_o <= 0;
        int_wb_we_o <= 0;
        spi_ld <= 1;
        int_spi_data_i <= wb_dat_i;
    end
    ST_RD_DATA: begin
        spi_ld <= 0;
    end
    ST_CLR: begin
        int_wb_stb_o <= 0;
        int_wb_we_o <= 0;
    end
    endcase
end

spislave sr0(
    .clk(clk),
    .sck(spi_sck),
    .sdi(spi_mosi),
    .sdo(spi_miso),
    .ss(spi_ss),
    .data_i(int_spi_data_i),
    .data_o(int_spi_data_o),
    .ld(spi_ld),
    .rdy(int_spi_rdy)
);

/* reset the counter if there are any sck edges */
up_counter c0(
    .clk(clk),
    .clr(spi_sck),
    .cnt(int_cnt)
);

endmodule
