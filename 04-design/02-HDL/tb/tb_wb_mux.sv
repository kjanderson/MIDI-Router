/**********************************************************************
 * tb_wb_mux.sv
 *
 * This testbench verifies functionality of the wb_mux module.
 *
 * Status
 * in development
 *
 * Notes
 * Fix problem where simulation hangs (line 40)
 *********************************************************************/
`timescale 1ns/1ps

`include "verilog_assert.vh"

module tb(
);

reg clk;
reg [7:0] wb_addr;
reg  [11:0] wb_dat_i;
wire [7:0] wb_dat_o;
integer ii;

always #4 clk <= ~clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    $dumpfile("tb_wb_mux.vcd");
    $dumpvars(0, tb);

    wm0.int_dat_o = 8'h00;

    for (ii=0; ii<16; ii++) begin
        wb_dat_i[ii] = ii;
    end
    
    for (ii=0; ii<256; ii++) begin
        wb_addr = ii;
        @(posedge clk);
    end

//    @(posedge clk);
    
    $finish;
end

wb_mux wm0(
    .wb_addr_i(wb_addr),
    .wb_dat_i(wb_dat_i),
    .wb_dat_o(wb_dat_o)
);

endmodule

