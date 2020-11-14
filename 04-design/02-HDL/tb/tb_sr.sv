/**********************************************************************
 * tb_sr.sv
 *
 * This module implements the test bench for the shiftreg module.
 *
 * The intended application provides a 1 MHz SPI clock.
 * To simulate this, a counter is invoked in the test bench that acts
 * as a prescaler.
 * To simulate a break between bytes of data, the blank parameter is
 * directly controlled in the initial block.
 * The data sent to the device is controlled with the register data.
 *
 * Status
 * This testbench compiles now, but the timing isn't quite right.
 *********************************************************************/
interface if_spi(
    input wire clk
);
    logic reset;
    logic spi_sck;
    logic spi_so;
    logic spi_si;
    logic [7:0] spi_reg;
	logic ld;
    
    modport dut (
        input reset,
        input clk,
        input spi_sck,
        input spi_si,
        input ld,
        output spi_so,
        output spi_reg
    );
    
    clocking cb @(posedge clk);
        output reset;
        output spi_sck;
        output spi_si;
        input spi_so;
    endclocking
    
    modport tb (
        clocking cb,
        input clk
    );
endinterface

/* DUT */
module spi_dut(
    if_spi.dut dif
);
    shiftreg sr0(
        .clk(dif.spi_sck),
        .ser_i(dif.spi_si),
        .ser_o(dif.spi_so),
        .data_i(dif.spi_reg),
        .ld(dif.ld)
    );
endmodule

/* test program */
program spi_test(
    if_spi.tb tif,
    input wire spi_sck_in
);

reg spi_sck_enable = 0;
wire spi_sck;
reg [7:0] test_datai;
reg [7:0] test_datao;
assign spi_sck = (spi_sck_enable) ? spi_sck_in : 0;

    /* convenience task to perform a one-byte data exchange */
    task spi_xchg;
        input [7:0] datai;
        output [7:0] datao;
        
        for (int i=0; i<8; i++) begin
            @(posedge spi_sck);
            tif.cb.spi_sck <= spi_sck;
            tif.cb.spi_si <= datai[7-i];
            @(negedge spi_sck);
            tif.cb.spi_sck <= spi_sck;
            datao[7-i] = tif.cb.spi_so;
        end
    endtask
    
    initial begin
        tif.cb.reset <= 0;
        spi_sck_enable = 0;
        @(tif.cb);
        spi_sck_enable = 1;
        test_datai = 8'hDE;
        spi_xchg(test_datai, test_datao);
        spi_sck_enable = 0;
        repeat (2) begin
            @(tif.cb);
        end
        spi_sck_enable = 1;
        test_datai = 8'hAD;
        spi_xchg(test_datai, test_datao);
        spi_sck_enable = 0;
        @(tif.cb);
        $finish;
    end
endprogram


/* testbench */
module tb;
reg clk = 0;
reg sck_in = 0;
always #5 clk = ~clk;
always #10 sck_in = ~sck_in;

if_spi sif(
    clk
);
spi_test u_test(
    sif,
    sck_in
);
spi_dut u_dut(
    sif
);

endmodule
