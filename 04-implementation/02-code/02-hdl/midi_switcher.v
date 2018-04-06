/**********************************************************************
 * midi_switcher
 *
 * Author: Korwin Anderson
 * Date: 2018-02-03
 * Version: 0
 *
 * Description
 * This top-level Verilog module implements the MIDI switcher.
 * SPI configuration is assumed to be working, otherwise CDONE won't assert.
 * SPI output (spi_miso) is tested after configuration.
 * Test code uses the SPI block as a shift register.
 *
 * Pin descriptions
 *   clk: main clock, derived from MCU oscillator
 *   gpio_bin: 16 GPIO pins
 *   gpio_fbin: 4 GPIO pins
 *   spi_clk: SPI clock
 *   spi_miso: SPI slave output
 *   spi_mosi: SPI slave input
 *   spi_ss: SPI SS
 *
 * History
 * Version    Revision    Notes
 * 0.0        0.0         Test version to facilitate board bring up
 *********************************************************************/
module midi_switcher(
    clk,
    gpio_bin,
    gpio_fbin,
    spi_clk,
    spi_miso,
    spi_mosi,
    spi_ss
);

/* 41 outputs */
input clk;
output [11:0] gpio_bin;
output [3:0] gpio_fbin;
input spi_clk;
output spi_miso;
input spi_mosi;
input spi_ss;

wire clk;
wire [11:0] gpio_bin;
wire [3:0] gpio_fbin;
wire spi_clk;
wire spi_miso;
wire spi_mosi;
wire spi_ss;

/* make the register a multiple of 8 bits to fit the MCU SPI pattern */
wire [15:0] regout;

/* assign outputs */
assign gpio_bin = regout[11:0];
assign gpio_fbin = regout[15:12];

/* instantiate the reset module to get a reset pulse */
mstreset rst0(
    nreset,
    clk
);

/* instantiate a 16-bit shift register to test connectivity */
shiftreg #(16) sr0(
    nreset,
    clk,
    spi_clk,
    spi_mosi,
    spi_miso,
    regout
);

endmodule
