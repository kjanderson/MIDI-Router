/**********************************************************************
 * tb_fifo
 *
 * This module implements the test bench for the fifo module.
 *
 * The application provides a 32.5 KHz sample clock to the module.
 *
 * Tests:
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg        clk;
reg        rst;
reg  [3:0] addr;
reg  [7:0] data_i;
reg  [3:0] irq;
wire [7:0] data_o;
reg        wr;
reg  [3:0] bus_rd;
integer i;
integer j;

always #4 clk <= ~clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    addr = 4'h0;
    data_i = 8'h00;
    wr = 0;
    bus_rd = 4'h0;
    
    /* generate reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* verify initial conditions are met */
    
    $finish;
end

busmaster bm_0(
    .reset(rst),
    .clk(clk),
    .addr(addr),
    .data(data_i),
    .irq(irq),
    .fifo_data(data_o),
    .fifo_wr(wr),
    .bus_rd(bus_rd)
);

endmodule
