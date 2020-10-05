/**********************************************************************
 * tb_uart_rx
 *
 * This module implements the test bench for the uart_rx module.
 *
 * The application provides a 125 KHz sample clock to the module.
 *
 * Notes
 * This module compiles and generates midi_in.
 * Still need to verify the bus and irq interface.
 * May need to come back to irq and bus_rd interface, depending on details
 * of the FIFO implementation.
 *
 * TODO
 *  1. define how long bus_rd will remain asserted and therefore how long
 *     the midi_rx module will assert bus_dat.
 *
 * Tests
 * 01: verify midi_rx module 0 receives a signal and asserts its data on the bus.
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
    //@(negedge tx_busy);
    
    for (ii=0; ii<(10*8); ii++) begin
        @(negedge clk);
    end
    
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    
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
