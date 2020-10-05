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
 * elaboration of pins:
 *   Pin26: DO-3: BIN8: MIDI output 1
 *   Pin27: DO-4: BIN14: MIDI output 2
 *   Pin28: DO-1: BIN9: MIDI output 3
 *   Pin29: DO-2: BIN15: MIDI output 4
 *   Pin30: DI-3: BIN10: MIDI input 3
 *   Pin33: DI-4: BIN16: MIDI input 4
 *   Pin34: DI-1: BIN11: MIDI input 1
 *   Pin36: DI-2: BIN17: MIDI input 2
 *
 * History
 * Version    Revision    Notes
 * 0.0        0.0         Test version to facilitate board bring up
 *
 * Notes
 * A note regarding CDC issues.
 * Since clk is generated from the microcontroller clock, all the derived clocks
 * are synchronized to that, so in principle there is only one clock domain, even
 * though spi_sck is several times slower.
 *
 * Regarding synchronized inputs
 * Similar to CDC issues, all inputs are synchronized to the CPU clock
 * for the same reason. Normally, the FPGA clock would be generated from
 * an oscillator. But in this case, clk is generated from the microcontroller's
 * core clock.
 *
 * Regarding clock skew
 * The microcontroller clock was selected to be 8 MHz to limit clock skew.
 * The clock skew is much less than 1% of a clock period.
 *********************************************************************/
module top_midi_switcher(
    clk,
    midi_in,
    midi_out,
    gpio_fbin,
    spi_clk,
    spi_miso,
    spi_mosi,
    spi_ss,
);

/* 41 outputs */
input  wire clk;
input  wire [3:0] midi_in;
output wire [3:0] midi_out;
input  wire [3:0] gpio_fbin;
input  wire spi_clk;
output wire spi_miso;
input  wire spi_mosi;
input  wire spi_ss;

wire [3:0] midi_in_filt;

/* instantiate an 8-bit shift register to test connectivity */
shiftreg sr0(
    .spi_clk(spi_clk),
    .din(spi_mosi),
    .dout(spi_miso)
);

synchronizer syn0(
    .clk(clk),
    .a_in(midi_in[0]),
    .y_out(midi_in_filt[0])
);

synchronizer syn1(
    .clk(clk),
    .a_in(midi_in[1]),
    .y_out(midi_in_filt[1])
);

synchronizer syn2(
    .clk(clk),
    .a_in(midi_in[2]),
    .y_out(midi_in_filt[2])
);

synchronizer syn3(
    .clk(clk),
    .a_in(midi_in[3]),
    .y_out(midi_in_filt[3])
);

merge_midi_outputs merge0(
    .clk(clk),
    .midi_in(midi_in_filt),
    .midi_out(midi_out)
);

endmodule
