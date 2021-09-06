/**********************************************************************
 * tb_midi_tx
 *
 * This module implements the test bench for the midi_tx module.
 *
 * The application provides a 125 KHz sample clock to the module.
 *
 * Notes
 * 1. need to stimulate the UART with a strobe to start. Otherwise, it can't finish.
 *
 * TODO
 *
 * Tests
 * 01: ? 
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

integer ii;
reg clk;
reg rst;
wire midi_tx;
reg [7:0] wb_dat_i;
reg fifo_empty_n;
wire fifo_rd;

always #4 clk <= ~clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    clk = 0;
    wb_dat_i = 8'h00;
    fifo_empty_n = 1'b0;

    /* reset pulse */
    @(posedge clk);
    rst = 1;
    @(posedge clk);
    rst = 0;

    /* initialize internal register data */
    midi_tx_0.int_fifo_rd = 0;
    midi_tx_0.int_uart_stb = 0;
    midi_tx_0.u0.int_cnt = 0;
    midi_tx_0.u0.int_bit_cnt = 0;
    
    /* simulation */
    wb_dat_i = 8'h80;
    fifo_empty_n = 1'b1;
    @(posedge clk);
    fifo_empty_n = 1'b0;
    @(posedge clk);
    for (ii=0; ii<100; ii++) begin
        @(posedge clk);
    end
    fifo_empty_n = 1'b0;

    $finish;
end

midi_tx midi_tx_0(
    .rst(rst),
    .clk(clk),
    .midi_tx(midi_tx),
    .fifo_data(wb_dat_i),
    .fifo_empty_n(fifo_empty_n),
    .fifo_rd(fifo_rd)
);

endmodule
