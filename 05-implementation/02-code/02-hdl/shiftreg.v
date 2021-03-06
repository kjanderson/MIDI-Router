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
    spi_clk,
    din,
    dout
);

parameter n = 8;

input wire spi_clk;
input wire din;
output wire dout;

reg [n-1:0] regdata;
reg int_dout;
// reg z_spi_clk;

assign dout = int_dout;

/* to mimic the SPI port, read data in on the falling edge of spi_clk */
/*
always @ (posedge clk)
begin
    if (nreset == 0)
    begin
        regdata <= 0;
        z_spi_clk <= spi_clk;
    end
    else begin
        z_spi_clk <= spi_clk;
        // shift data out on falling edge of sck
        if ((spi_clk == 0) && (z_spi_clk == 1)) begin
            _dout <= regdata[n-1];
        end
        
        // shift data in on rising edge of sck
        if ((spi_clk == 1) && (z_spi_clk == 0)) begin
            regdata <= {regdata[n-2:0], din};
        end
    end
end
*/

always @(posedge spi_clk)
begin: bhv_regout
    regdata <= {regdata[n-2:0], din};
end

always @(negedge spi_clk)
begin: bhv_dout
    int_dout <= regdata[n-1];
end

endmodule
