/**********************************************************************
 * tb_uart_tx.sv
 *
 * This module implements the test bench for the uart_tx module.
 *
 * The application provides a 250 KHz sample clock to the module.
 *
 * Notes
 * This module compiles and generates midi_out.
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg rst;
reg clk;
reg tx_strobe;
reg [7:0] midi_data;
wire midi_tx;
wire tx_busy;
integer ii;

always #4 clk <= ~clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    $dumpfile("tb_uart_tx.vcd");
    $dumpvars(0, tb);

    rst = 0;
    clk = 0;
    tx_strobe = 0;
    midi_data = 8'h00;
    
    /* reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* simulation */
    @(negedge clk);
    midi_data = 8'h80;
    tx_strobe = 1'b1;
    @(negedge clk);
    tx_strobe = 1'b0;
    @(negedge tx_busy);
    
    
    $finish;
end

uart_tx u0(
    .rst(rst),
    .clk(clk),
    .tx_strobe(tx_strobe),
    .data(midi_data),
    .tx(midi_tx),
    .busy(tx_busy)
);

endmodule
