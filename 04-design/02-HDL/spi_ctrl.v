// TODO: create signal active for one clock cycle to indicate a byte has transferred on the SPI bus.
module spi_ctrl
(
    clk,
    spi_miso,
    spi_mosi,
    spi_sck,
    spi_ss,
    wb_clk_i,
    wb_rst_i,
    wb_addr_o,
    wb_dat_i,
    wb_dat_o,
    wb_stb_o,
    wb_ack_i,
    wb_we_o
);

parameter ST_IDLE = 3'h0;
parameter ST_CMD  = 3'h1;
parameter ST_WR_DATA = 3'h2;
parameter ST_WR_EXE  = 3'h3;
parameter ST_RD_EXE = 3'h4;
parameter ST_RD_LOAD = 3'h5;
parameter ST_RD_DATA = 3'h6;
parameter ST_RSVD    = 3'h7;


`define BIT_WE 8'h80
`define MASK_WE 8'h80
`define MASK_ADDR 8'h7F

input  wire clk;
output wire spi_miso;
input  wire spi_mosi;
input  wire spi_sck;
input  wire spi_ss;
/* wishbone interface */
input  wire wb_clk_i;
input  wire wb_rst_i;
output wire [7:0] wb_addr_o;
input  wire [7:0] wb_dat_i;
output wire [7:0] wb_dat_o;
output wire wb_stb_o;
input  wire wb_ack_i;
output wire wb_we_o;

reg [2:0] int_spi_curr_state;
reg [2:0] int_spi_next_state;
reg       int_cmd;
reg [7:0] int_addr;
reg [7:0] int_data;
reg [2:0] int_bit_cnt;

reg [7:0] spi_data_i;
wire [7:0] spi_data_o;
reg spi_ld;
reg int_wb_stb_o;
reg int_wb_we_o;
reg int_spi_xchg_stb;

assign wb_addr_o = int_addr;
assign wb_dat_o = int_data;
assign wb_stb_o = int_wb_stb_o;
assign wb_we_o = int_wb_we_o;

always @(int_spi_curr_state, int_bit_cnt)
begin: sm_cl
    case(int_spi_curr_state)
    ST_IDLE: begin
        if (int_spi_xchg_stb == 1) begin
            int_spi_next_state = ST_CMD;
        end
        else begin
            int_spi_next_state = ST_IDLE;
        end
    end
    ST_CMD: begin
        if (int_cmd & `MASK_WE) begin
            int_spi_next_state = ST_WR_DATA;
        end
        else begin
            int_spi_next_state = ST_RD_EXE;
        end
    end
    ST_WR_DATA: begin
        if (int_spi_xchg_stb == 1) begin
            int_spi_next_state = ST_WR_EXE;
        end
        else begin
            int_spi_next_state = ST_WR_DATA;
        end
    end
    ST_WR_EXE: begin
        if (wb_ack_i == 1) begin
            int_spi_next_state = ST_IDLE;
        end
        else begin
            int_spi_next_state = ST_WR_EXE;
        end
    end
    ST_RD_EXE: begin
        if (wb_ack_i == 1) begin
            int_spi_next_state = ST_RD_LOAD;
        end
        else begin
            int_spi_next_state = ST_RD_EXE;
        end
    end
    ST_RD_LOAD: begin
        int_spi_next_state = ST_RD_DATA;
    end
    ST_RD_DATA: begin
        if (int_spi_xchg_stb == 1) begin
            int_spi_next_state = ST_IDLE;
        end
        else begin
            int_spi_next_state = ST_RD_DATA;
        end
    end
    default: begin
        int_spi_next_state = ST_IDLE;
    end
    endcase
end

always @(posedge clk)
begin: bhv_sm_sl
    int_spi_curr_state <= int_spi_next_state;
end

always @(posedge clk)
begin: bhv_sm_op
    case(int_spi_curr_state)
    ST_IDLE: begin
        spi_ld <= 0;
        int_addr <= 8'h00;
        int_wb_we_o <= 0;
        if (int_spi_xchg_stb == 1) begin
            int_cmd <= spi_data_o[7];
        end
        else begin
            int_cmd <= 0;
        end
    end
    ST_CMD: begin
        int_addr <= {1'b0, spi_data_o[6:0]};
        int_wb_stb_o <= 1;
        int_wb_we_o <= int_cmd;
    end
    ST_WR_DATA: begin
        int_wb_stb_o <= 0;
        int_data <= spi_data_o;
    end
    ST_WR_EXE: begin
    end
    ST_RD_EXE: begin
    end
    ST_RD_LOAD: begin
        spi_ld <= 1;
        spi_data_i <= wb_dat_o;
    end
    ST_RD_DATA: begin
        spi_ld <= 0;
    end
    default: begin
    end
    endcase
end

always @(posedge spi_sck)
begin: bhv_bit_cnt
    if (spi_ss == 0) begin
        int_bit_cnt <= int_bit_cnt + 1;
    end
    else begin
        int_bit_cnt <= 0;
    end
end

always @(posedge clk)
begin: bhv_spi_xchg_stb
    if ((int_bit_cnt == 7) && (spi_sck == 1) && (int_spi_xchg_stb == 0)) begin
        int_spi_xchg_stb <= 1;
    end
    else begin
        int_spi_xchg_stb <= 0;
    end
end

shiftreg sr0(
    .sck(spi_sck),
    .ser_i(spi_mosi),
    .ser_o(spi_miso),
    .data_i(spi_data_i),
    .data_o(spi_data_o),
    .ld(spi_ld)
);

endmodule
