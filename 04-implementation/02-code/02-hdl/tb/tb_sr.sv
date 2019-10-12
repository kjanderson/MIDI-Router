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
 *********************************************************************/
interface if_spi(
    input wire clk
);
    logic reset;
    logic spi_sck;
    logic spi_so;
    logic spi_si;
    logic [7:0] spi_reg;
    
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

module spi_test(if_spi spiif);
endmodule

/* convenience task to perform a one-byte data exchange */
task spi_xchg;
    input spi_sck;
    input [7:0] datai;
    output [7:0] datao;
    
    for (int i=0; i<8; i++) begin
        @(posedge spi_sck);
        datai[7-i] <= spi_si;
        @(negedge spi_sck);
        spi_so <= datao[7-i];
    end
endtask

module tb;

initial
begin
    $dumpfile("tb_sr.vcd");
    $dumpvars(0, tb);
    reset = 0;
    clk = 0;
    spi_sck = 0;
    spi_sck_enable = 0;
    #1000 $finish;
end

/* clock */
reg clk;
reg spi_clk;
reg spi_sck_enable;
always #5 clk = !clk;

assign spi_sck = (spi_sck_enable ? spi_sck_in : 0);

reg reset;
reg [6:0] spi_cnt = 48;
wire spi_mosi;
wire spi_miso;
reg [47:0] spi_data = 47'h1FFFFFFFFFF;
wire [47:0] spi_regout;

if_spi ifspi(
    clk
);
spi_test(ifspi);

mstreset rst0(
    reset,
    spi_clk
);

/* test the module */
shiftreg sr0(
    .nreset(ifspi.reset),
    .clk(ifspi.clk),
    .spi_clk(ifspi.spi_sck),
    .din(ifspi.spi_si),
    .dout(ifspi.spi_so),
    .regout(ifspi.regout)
);

endmodule
