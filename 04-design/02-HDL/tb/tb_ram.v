/**********************************************************************
 * tb_ram
 *
 * This module implements the test bench for the ram module.
 *
 * The application provides a 32.5 KHz sample clock to the module.
 *
 * Notes
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg clk;
reg rst;
wire rst_n;
wire [7:0] rdata;
reg [7:0] wdata;
reg we;
reg re;
reg [8:0] rd_pointer;
reg [8:0] wr_pointer;
integer i;

always #4 clk <= ~clk;
assign rst_n = ~rst;

task ram_test_address;
    input [8:0] address;
    input [7:0] data_i;
    
    begin
        @(negedge clk);
        we = 1;
        re = 0;
        rd_pointer = 9'h000;
        wr_pointer = address;
        wdata = data_i;
        @(negedge clk);
        we = 0;
        re = 1;
        rd_pointer = address;
        wr_pointer = 9'h000;
        wdata = 8'h00;
        @(negedge clk);
        we = 0;
        re = 0;
        rd_pointer = 9'h000;
        wr_pointer = 9'h000;
        wdata = 8'h00;
    end
endtask

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    /* initial values */
    rst = 0;
    clk = 0;
    rd_pointer = 8'h00;
    wr_pointer = 8'h00;
    we = 0;
    re = 0;
    wdata = 8'h00;
    for (integer i=0; i<512; i++) begin
        ram_0._mem_data[i] = 8'h00;
    end
    ram_0._data_out = 8'h00;
    
    /* generate synchronous reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* write data */
    for (i=0; i<512; i++) begin
        ram_test_address(i, i+1);
        assert(rdata == i+1);
    end
    $finish;
end

ram ram_0(
    .wdata(wdata),
    .waddr(wr_pointer),
    .we(we),
    .wclk(clk),
    .rdata(rdata),
    .raddr(rd_pointer),
    .re(re),
    .rclk(clk)
);

endmodule
