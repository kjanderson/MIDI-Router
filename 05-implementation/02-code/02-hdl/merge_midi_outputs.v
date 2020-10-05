/**********************************************************************
 * merge_midi_outputs.v
 *
 * Description
 * This verilog module merges the selected MIDI output channels with
 * all inputs for each channel.
 *
 * History
 * Revision Date       Notes
 * 0.0      2020-03-01 Initial version
 *
 * Module I/O
 * clk: the input clock
 * midi_in: the 4 MIDI inputs
 * midi_out: the 4 MIDI outputs
 * midi_sel: 4 select lines that activate the corresponding MIDI output
 *********************************************************************/
module merge_midi_outputs(
    clk,
    midi_in,
    midi_out
);

input  wire clk;
input  wire [3:0] midi_in;
output wire [3:0] midi_out;

/* continuous assignments */
assign midi_out[0] = midi_in[0] & midi_in[1] & midi_in[2] & midi_in[3];
assign midi_out[1] = midi_in[0] & midi_in[1] & midi_in[2] & midi_in[3];
assign midi_out[2] = midi_in[0] & midi_in[1] & midi_in[2] & midi_in[3];
assign midi_out[3] = midi_in[0] & midi_in[1] & midi_in[2] & midi_in[3];

endmodule
