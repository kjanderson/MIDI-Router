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
    wire reset;
    
    clocking cb @(posedge clk);
        output reset;
        output spi_clk;
        output spi_mosi;
        input spi_miso;
    endclocking
    
    modport tb (
        clocking cb,
        input clk
    );
endinterface

module test_sr;

initial
begin
    $dumpfile("test_sr.vcd");
    $dumpvars(0, test_sr);
    #1000 $finish;
end

/* clock */
reg spi_clk = 0;
always #5 spi_clk = !spi_clk;

wire reset;
reg [6:0] spi_cnt = 48;
wire spi_mosi;
wire spi_miso;
reg [47:0] spi_data = 47'h1FFFFFFFFFF;
wire [47:0] spi_regout;

assign spi_mosi = spi_data[spi_cnt];

mstreset rst0(
    reset,
    spi_clk
);

/* test the module */
shiftreg #(48) sr0(
    reset,
    spi_clk,
    spi_mosi,
    spi_miso,
    spi_regout
);

/* clock out the data to the SPI module on the clock rising edge */
always @ (posedge spi_clk)
begin
    if(reset == 0)
    begin
    end
    else
    begin
        //spi_clk <= ((spi_ss == 0) && (blank == 0)) ? !scaled_clock[2] : 0;
    end
end

/* setup the address during the clock falling edge */
always @ (negedge spi_clk)
begin
    if(reset == 0)
    begin
        spi_cnt <= 48;
    end
    else
    begin
        if (spi_cnt > 0)
        begin
            spi_cnt <= spi_cnt - 1;
        end
    end
end

endmodule
