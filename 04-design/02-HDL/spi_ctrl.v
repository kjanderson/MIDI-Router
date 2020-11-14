module spi_ctrl
(
    clk,
    spi_miso,
    spi_mosi,
    spi_sck,
    spi_ss
);

parameter ST_IDLE = 2'h0;
parameter ST_CMD  = 2'h1;
parameter ST_DATA = 2'h2;
parameter ST_EXE  = 2'h3;

`define MASK_WE 8'h80

input  wire clk;
output wire spi_miso;
input  wire spi_mosi;
input  wire spi_sck;
input  wire spi_ss;

reg [1:0] int_spi_curr_state;
reg [1:0] int_spi_next_state;
reg [7:0] int_cmd;
reg [7:0] int_addr;
reg [7:0] int_data;
reg [2:0] int_bit_cnt;
wire int_spi_fifo_rd;

/* need to add an enable signal that gets cleared on change
 * so this is only asserted for one clk */
assign int_bit_cnt_ld = (int_bit_cnt == 7) ? 1 : 0;

always @(int_bit_cnt_ld)
begin: sm_cl
    case(int_spi_curr_state)
    ST_IDLE: begin
        if (int_bit_cnt_ld == 1) begin
            int_spi_next_state = ST_CMD;
        end
        else begin
            int_spi_next_state = ST_IDLE;
        end
    end
    ST_CMD: begin
        if (int_bit_cnt_ld == 1) begin
            if (int_cmd & `MASK_WE) begin
                int_spi_next_state = ST_DATA;
            end
            else begin
                int_spi_next_state = ST_EXE;
            end
        end
        else begin
            int_spi_next_state = ST_CMD;
        end
    end
    ST_DATA: begin
        if (int_bit_cnt_ld == 1) begin
            if (int_cmd & `MASK_WE) begin
                int_spi_next_state = ST_EXE;
            end
            else begin
                int_spi_next_state = ST_IDLE;
            end
        end
        else begin
            int_spi_next_state = ST_DATA;
        end
    end
    ST_EXE: begin
        if (int_wb_ack_i == 1) begin
            if (int_cmd & `MASK_WE) begin
                int_spi_next_state = ST_IDLE;
            end
            else begin
                int_spi_next_state = ST_DATA;
            end
        end
        else begin
            int_spi_next_state = ST_EXE;
        end
    end
    default: begin
        int_spi_next_state = ST_IDLE;
    end
end

always @(posedge clk)
begin: bhv_sm_sl
    int_spi_curr_state <= int_spi_next_state;
end

always @(posedge clk)
begin: bhv_sm_op
    case(int_curr_state)
    ST_IDLE: begin
    end
    ST_CMD: begin
    end
    ST_DATA: begin
    end
    ST_EXE: begin
    end
    default: begin
    end
    endcase
end

always @(posedge spi_sck)
begin: bhv_bit_cnt
    int_bit_cnt <= int_bit_cnt + 1;
end

shiftreg sr0(
    .reset(1'b1),
    .clk(clk),
    .data_i(spi_mosi),
    .ser_o(spi_miso),
    .fifo_rd(int_spi_fifo_rd),
    .fifo_empty_n(1'b0)
);

endmodule
