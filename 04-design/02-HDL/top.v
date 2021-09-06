/**********************************************************************
 * top.v
 *
 * Description
 * This module implements the top-level module for the MIDI Router application.
 *
 * This application takes a byte from the SPI slave port and outputs it to the
 * MIDI outputs. A hardware FIFO is provided for buffering.
 *
 * Notes
 * The UART module needs to be refactored to make the rst input unecessary.
 *********************************************************************/
module top(
    clk,
    midi_in,
    midi_out,
    gpio_fbin_0,
    gpio_fbin_1,
    gpio_fbin_2,
    gpio_fbin_3,
    gpio_bin_14,
    gpio_bin_15,
    spi_clk,
    spi_miso,
    spi_mosi,
    spi_ss
);

/* I/O ports */
input  wire clk;
input  wire [3:0] midi_in;
output wire [3:0] midi_out;
output wire gpio_fbin_0;
output wire gpio_fbin_1;
output wire gpio_fbin_2;
output wire gpio_fbin_3;
output wire gpio_bin_14;
output wire gpio_bin_15;
input  wire spi_clk;
output wire spi_miso;
input  wire spi_mosi;
input  wire spi_ss;

/* internal signals */
wire [3:0] midi_in_sync;
wire int_midi_out_sync;

/* route UART output to all MIDI outputs */
assign midi_out[0] = int_midi_out_sync;
assign midi_out[1] = int_midi_out_sync;
assign midi_out[2] = int_midi_out_sync;
assign midi_out[3] = int_midi_out_sync;

/* route MIDI inputs to the MCU */
assign gpio_fbin_0 = midi_in_sync[0];
assign gpio_fbin_1 = midi_in_sync[1];
assign gpio_fbin_2 = midi_in_sync[2];
assign gpio_fbin_3 = midi_in_sync[3];

/* debug port */
assign gpio_bin_14 = 1'b0;
assign gpio_bin_15 = 1'b0;

/* synchronize MIDI inputs */
synchronizer s0(
    .clk(clk),
    .a(midi_in[0]),
    .y(midi_in_sync[0])
);

synchronizer s1(
    .clk(clk),
    .a(midi_in[1]),
    .y(midi_in_sync[1])
);

synchronizer s2(
    .clk(clk),
    .a(midi_in[2]),
    .y(midi_in_sync[2])
);

synchronizer s3(
    .clk(clk),
    .a(midi_in[3]),
    .y(midi_in_sync[3])
);

/* synchronize MIDI output */
synchronizer s4(
    .clk(clk),
    .a(spi_mosi),
    .y(int_midi_out_sync)
);

endmodule
