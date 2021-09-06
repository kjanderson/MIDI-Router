/**********************************************************************
 * midi_tx.v
 *
 * Description
 * This module implements the controller for the output UART.
 *
 * When a wishbone write is received, it starts sending (if in idle). It is
 * the host's responsibility to check that the UART is available before sending
 * a write request.
 *
 * Notes
 * Need to complete implementation with hardware FIFO
 *********************************************************************/
module midi_tx(
    rst,
    clk,
    midi_tx,
    fifo_data,
    fifo_empty_n,
    fifo_rd
);

parameter ST_IDLE = 2'h0;
parameter ST_RD   = 2'h1;
parameter ST_STX  = 2'h2;
parameter ST_WTX  = 2'h3;

input  wire rst;
input  wire clk;
output wire midi_tx;
input  wire [7:0] fifo_data;
input  wire fifo_empty_n;
output wire fifo_rd;

/* internal signals */
wire int_uart_busy;
reg int_fifo_rd;
reg int_uart_stb;

reg [1:0] int_curr_state;
reg [1:0] int_next_state;

assign fifo_rd = int_fifo_rd;

always @(int_curr_state, fifo_empty_n, int_uart_busy)
begin
    case(int_curr_state)
    ST_IDLE: begin
        if (fifo_empty_n == 1'b1) begin
            int_next_state = ST_RD;
        end
        else begin
            int_next_state = ST_IDLE;
        end
    end
    ST_RD: begin
        int_next_state = ST_STX;
    end
    ST_STX: begin
        if (int_uart_busy == 1'b1) begin
            int_next_state = ST_WTX;
        end
        else begin
            int_next_state = ST_STX;
        end
    end
    ST_WTX: begin
        if (int_uart_busy == 1'b0) begin
            int_next_state = ST_IDLE;
        end
        else begin
            int_next_state = ST_WTX;
        end
    end
    default: begin
        int_next_state = ST_IDLE;
    end
    endcase
end

always @(posedge clk)
begin
    if (rst == 1'b1) begin
        int_curr_state <= ST_IDLE;
    end
    else begin
        int_curr_state <= int_next_state;
    end
end

always @(posedge clk)
begin
    case (int_curr_state)
    ST_IDLE: begin
        int_fifo_rd <= 1'b0;
        int_uart_stb <= 1'b0;
    end
    ST_RD: begin
        int_fifo_rd <= 1'b1;
        int_uart_stb <= 1'b0;
    end
    ST_STX: begin
        int_fifo_rd <= 1'b0;
        int_uart_stb <= 1'b1;
    end
    ST_WTX: begin
        int_fifo_rd <= 1'b0;
        int_uart_stb <= 1'b0;
    end
    default: begin
        int_fifo_rd <= 1'b0;
        int_uart_stb <= 1'b0;
    end
    endcase
end

uart_tx u0(
    .rst(rst),
    .clk(clk),
    .tx_strobe(int_uart_stb),
    .data(fifo_data),
    .tx(midi_tx),
    .busy(int_uart_busy)
);

endmodule
