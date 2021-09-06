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
 * This maps the inputs to FBIN for processing by the MCU.
 *
 * Pin descriptions
 *   clk: main clock, derived from MCU oscillator
 *   gpio_bin: 16 GPIO pins, all set to inputs to keep in high impedance
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
input  wire [3:0] midi_out;
output wire gpio_fbin0;
output wire gpio_fbin1;
output wire gpio_fbin2;
input  wire gpio_fbin3;
input  wire spi_clk;
output wire spi_miso;
input  wire spi_mosi;
input  wire spi_ss;

wire [2:0] int_midi_in_syn;
reg [2:0] int_midi_in;

assign gpio_fbin[0] = midi_in[0];
assign gpio_fbin[1] = midi_in[1];
assign gpio_fbin[2] = midi_in[2];
assign  = midi_in[3];

assign spi_miso = spi_mosi;

synchronizer s0(
    .clk(clk),
    .a_in(midi_in[0]),
    .y_out(int_midi_in_syn[0])
);

synchronizer s1(
    .clk(clk),
    .a_in(midi_in[1]),
    .y_out(int_midi_in_syn[1])
);

synchronizer s2(
    .clk(clk),
    .a_in(midi_in[2]),
    .y_out(int_midi_in_syn[2])
);

always @(posedge clk)
begin: bhv_fbin
    int_midi_in <= int_midi_in_syn;
end

endmodule

