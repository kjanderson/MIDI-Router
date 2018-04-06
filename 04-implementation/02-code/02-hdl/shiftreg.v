/**********************************************************************
 * shiftreg
 *
 * Author: Korwin Anderson
 * Date: February 3, 2018
 * Version: 1.0
 *
 * Description
 * This module implements a shift register for use in testing the
 * MIDI switcher application.
 *
 * Details
 * In order to avoid registering spi_clk as the main clock source,
 * clk was added to serve as the primary clock.
 *********************************************************************/
module shiftreg(
    nreset,
    clk,
    spi_clk,
    din,
    dout,
    regout
);

parameter n = 8;

input nreset;
input clk;
input spi_clk;
input din;
output dout;
output [n-1:0] regout;

wire nreset;
wire clk;
wire spi_clk;
wire din;
wire dout;
wire regout;

reg [n-1:0] regdata;
reg z_spi_clk;

assign dout = regdata[n-1];
assign regout = regdata;

/* to mimic the SPI port, read data in on the falling edge of spi_clk */
always @ (posedge clk)
begin
    if (nreset == 0)
    begin
        regdata <= 0;
        z_spi_clk <= spi_clk;
    end
    else
    begin
        z_spi_clk <= spi_clk;
        if ((z_spi_clk == 0) && (spi_clk == 1))
        begin
            regdata <= {regdata[n-2:0], din};
        end
    end
end

endmodule
