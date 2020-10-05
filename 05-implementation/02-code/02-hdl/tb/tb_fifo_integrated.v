/**********************************************************************
 * tb_fifo
 *
 * This module implements the test bench for the fifo module.
 *
 * The application provides a 32.5 KHz sample clock to the module.
 *
 * Notes
 * 1. update the fifo design to increment the write pointer after performing the write.
 *    note that the SN74ALVC7804 requires 5ns setup time on the data input,
 *    and it is reasonable to require this module to do the same.
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg clk;
reg bus_clk;
wire [3:0] bus_rd;
reg bus_wr;
reg rst;
wire rst_n;
reg [3:0] irq;
reg [7:0] _midi_data_0_in;
reg [7:0] _midi_data_1_in;
reg [7:0] _midi_data_2_in;
reg [7:0] _midi_data_3_in;
wire [7:0] fifo_data;
wire full_n;
wire empty_n;
reg re;
wire [7:0] midi_data;
wire [7:0] addr;

always #4 clk <= ~clk;
assign rst_n = ~rst;
always #32 bus_clk <= ~bus_clk;

assign midi_data = ((bus_rd[0] == 1'b1) && (addr == 8'h00)) ? _midi_data_0_in : 
                   ((bus_rd[1] == 1'b1) && (addr == 8'h01)) ? _midi_data_1_in :
                   ((bus_rd[2] == 1'b1) && (addr == 8'h02)) ? _midi_data_2_in :
                   ((bus_rd[3] == 1'b1) && (addr == 8'h03)) ? _midi_data_3_in : 8'hzz;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    bus_clk = 0;
    bus_wr = 0;
    irq = 4'h0;
    re = 0;
    _midi_data_0_in = 8'h00;
    _midi_data_1_in = 8'h00;
    _midi_data_2_in = 8'h00;
    _midi_data_3_in = 8'h00;
    
    /* generate reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* synchronize inputs */
    @(negedge bus_clk);
    @(negedge bus_clk);
    @(negedge bus_clk);
    @(negedge bus_clk);
    
    /* simulate data generation on MIDI module 0 */
    @(negedge bus_clk);
    irq[0] = 1'b1;
    _midi_data_0_in = 8'h01;
    @(negedge bus_clk);
    @(posedge bus_clk);
    @(negedge bus_clk);
    assert(fifo_0.counter == 8'h01);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    irq[0] = 1'b0;
    @(posedge bus_clk);
    
    /* simulate data generation on MIDI module 1 */
    @(negedge bus_clk);
    irq[1] = 1'b1;
    _midi_data_1_in = 8'h02;
    @(negedge bus_clk);
    @(posedge bus_clk);
    @(negedge bus_clk);
    assert(fifo_0.counter == 8'h02);
    assert(fifo_0.ram0._mem_data[1] == 8'h02);
    irq[1] = 1'b0;
    @(posedge bus_clk);
    
    /* simulate data generation on MIDI module 2 */
    @(negedge bus_clk);
    irq[2] = 1'b1;
    _midi_data_2_in = 8'h03;
    @(negedge bus_clk);
    @(posedge bus_clk);
    @(negedge bus_clk);
    assert(fifo_0.counter == 8'h03);
    assert(fifo_0.ram0._mem_data[2] == 8'h03);
    irq[2] = 1'b0;
    @(posedge bus_clk);
    
    /* simulate data generation on MIDI module 3 */
    @(negedge bus_clk);
    irq[3] = 1'b1;
    _midi_data_3_in = 8'h04;
    @(negedge bus_clk);
    @(posedge bus_clk);
    @(negedge bus_clk);
    assert(fifo_0.counter == 8'h04);
    assert(fifo_0.ram0._mem_data[3] == 8'h04);
    irq[3] = 1'b0;
    @(posedge bus_clk);
    
    /* simulate reading the data out of the queue */
    @(negedge bus_clk);
    bus_wr = 1'b1;
    @(negedge bus_clk);
    assert(fifo_data == 8'h01);
    bus_wr = 1'b1;
    
    @(negedge bus_clk);
    bus_wr = 1'b1;
    @(negedge bus_clk);
    assert(fifo_data == 8'h02);
    bus_wr = 1'b1;
    
    @(negedge bus_clk);
    bus_wr = 1'b1;
    @(negedge bus_clk);
    assert(fifo_data == 8'h03);
    bus_wr = 1'b1;
    
    @(negedge bus_clk);
    bus_wr = 1'b1;
    @(negedge bus_clk);
    assert(fifo_data == 8'h04);
    bus_wr = 1'b1;
    @(posedge bus_clk);
    bus_wr = 1'b0;
    @(posedge bus_clk);
    
    /* data arriving at different times, but in the same bus cycle */
    /* simulate data generation on MIDI modules 0 and 1 */
    /* simulate data generation on MIDI modules 1 and 2 */
    /* simulate data generation on MIDI modules 2 and 3 */
    /* simulate data generation on MIDI modules 0, 1, and 2 */
    /* simulate data generation on MIDI modules 1, 2, and 3 */
    /* simulate data generation on MIDI modules 0, 1, 2, and 3 */
    
    /* data arriving simultaneously */
    /* simulate data generation on MIDI modules 0 and 1 */
    /* simulate data generation on MIDI modules 1 and 2 */
    /* simulate data generation on MIDI modules 2 and 3 */
    /* simulate data generation on MIDI modules 0, 1, and 2 */
    /* simulate data generation on MIDI modules 1, 2, and 3 */
    /* simulate data generation on MIDI modules 0, 1, 2, and 3 */
    
    /* output simulation */
    
    @(negedge clk);
    $finish;
end

fifo fifo_0(
    .reset_n(rst_n),
    .clk(bus_clk),
    .midi_int(irq),
    .midi_rd(bus_rd),
    .fifo_rd(bus_wr),
    .addr(addr),
    .data_i(midi_data),
    .data_o(fifo_data),
    .full_n(full_n),
    .empty_n(empty_n)
);

endmodule
