/**********************************************************************
 * tb_fifo
 *
 * This module implements the test bench for the fifo module.
 *
 * The application provides a 32.5 KHz sample clock to the module.
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg clk;
reg bus_clk;
reg rst;
wire [7:0] fifo_data;
wire full_n;
wire empty_n;
reg [7:0] midi_data;
reg rd;
reg wr;
reg oe_n;

always #4 clk <= ~clk;
always #32 bus_clk <= ~bus_clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    bus_clk = 0;
    oe_n = 1;
    rd = 0;
    wr = 0;
    midi_data = 8'h00;
    
    /* generate reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* verify initial conditions are met */
    assert(fifo_0.rd_pointer == 0);
    assert(fifo_0.wr_pointer == 0);
    assert(full_n == 1);
    assert(empty_n == 0);
    
    /* simulate data generation on MIDI module 0 */
    oe_n = 1'b0;
    @(negedge bus_clk);
    wr = 1'b1;
    midi_data = 8'h01;
    @(negedge bus_clk);
    wr = 1'b0;
    assert(fifo_0.rd_pointer == 8'h00);
    assert(fifo_0.wr_pointer == 8'h01);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    @(posedge bus_clk);
    
    /* simulate data generation on MIDI module 1 */
    @(negedge bus_clk);
    wr = 1'b1;
    midi_data = 8'h02;
    @(negedge bus_clk);
    wr = 1'b0;
    assert(fifo_0.rd_pointer == 8'h00);
    assert(fifo_0.wr_pointer == 8'h02);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    assert(fifo_0.ram0._mem_data[1] == 8'h02);
    @(posedge bus_clk);
    
    /* simulate data generation on MIDI module 2 */
    @(negedge bus_clk);
    wr = 1'b1;
    midi_data = 8'h03;
    @(negedge bus_clk);
    wr = 1'b0;
    assert(fifo_0.rd_pointer == 8'h00);
    assert(fifo_0.wr_pointer == 8'h03);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    assert(fifo_0.ram0._mem_data[1] == 8'h02);
    assert(fifo_0.ram0._mem_data[2] == 8'h03);
    @(posedge bus_clk);
    
    /* simulate data generation on MIDI module 3 */
    @(negedge bus_clk);
    wr = 1'b1;
    midi_data = 8'h04;
    @(negedge bus_clk);
    wr = 1'b0;
    assert(fifo_0.rd_pointer == 8'h00);
    assert(fifo_0.wr_pointer == 8'h04);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    assert(fifo_0.ram0._mem_data[1] == 8'h02);
    assert(fifo_0.ram0._mem_data[2] == 8'h03);
    assert(fifo_0.ram0._mem_data[3] == 8'h04);
    @(posedge bus_clk);
    
    /* simulate reading the data out of the queue */
    @(negedge bus_clk);
    rd = 1'b1;
    @(negedge bus_clk);
    rd = 1'b0;
    assert(fifo_0.rd_pointer == 8'h01);
    assert(fifo_0.wr_pointer == 8'h04);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    assert(fifo_0.ram0._mem_data[1] == 8'h02);
    assert(fifo_0.ram0._mem_data[2] == 8'h03);
    assert(fifo_0.ram0._mem_data[3] == 8'h04);
    assert(full_n == 1'b1);
    assert(empty_n == 1'b1);
    assert(fifo_data == 8'h01);
    
    @(negedge bus_clk);
    rd = 1'b1;
    @(negedge bus_clk);
    rd = 1'b0;
    assert(fifo_0.rd_pointer == 8'h02);
    assert(fifo_0.wr_pointer == 8'h04);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    assert(fifo_0.ram0._mem_data[1] == 8'h02);
    assert(fifo_0.ram0._mem_data[2] == 8'h03);
    assert(fifo_0.ram0._mem_data[3] == 8'h04);
    assert(full_n == 1'b1);
    assert(empty_n == 1'b1);
    assert(fifo_data == 8'h02);
    
    @(negedge bus_clk);
    rd = 1'b1;
    @(negedge bus_clk);
    rd = 1'b0;
    assert(fifo_0.rd_pointer == 8'h03);
    assert(fifo_0.wr_pointer == 8'h04);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    assert(fifo_0.ram0._mem_data[1] == 8'h02);
    assert(fifo_0.ram0._mem_data[2] == 8'h03);
    assert(fifo_0.ram0._mem_data[3] == 8'h04);
    assert(full_n == 1'b1);
    assert(empty_n == 1'b1);
    assert(fifo_data == 8'h03);
    
    @(negedge bus_clk);
    rd = 1'b1;
    @(negedge bus_clk);
    rd = 1'b0;
    assert(fifo_0.rd_pointer == 8'h04);
    assert(fifo_0.wr_pointer == 8'h04);
    assert(fifo_0.ram0._mem_data[0] == 8'h01);
    assert(fifo_0.ram0._mem_data[1] == 8'h02);
    assert(fifo_0.ram0._mem_data[2] == 8'h03);
    assert(fifo_0.ram0._mem_data[3] == 8'h04);
    assert(full_n == 1'b1);
    assert(empty_n == 1'b0);
    assert(fifo_data == 8'h04);
    @(posedge bus_clk);
    
    $finish;
end

fifo fifo_0(
    .reset(rst),
    .clk(bus_clk),
    .rd(rd),
    .wr(wr),
    .oe_n(oe_n),
    .data_i(midi_data),
    .data_o(fifo_data),
    .full_n(full_n),
    .empty_n(empty_n)
);

endmodule
