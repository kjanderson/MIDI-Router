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
    midi_out,
    midi_sel
);

input  wire clk;
input  wire [3:0] midi_in;
output wire [3:0] midi_out;
input  wire [3:0] midi_sel;

/* continuous assignments */
assign midi_out[0] = midi_sel[0] ? midi_in[0] & midi_in[1] & midi_in[2] & midi_in[3]
                                 : 1'b1;
assign midi_out[1] = midi_sel[1] ? midi_in[0] & midi_in[1] & midi_in[2] & midi_in[3]
                                 : 1'b1;
assign midi_out[2] = midi_sel[2] ? midi_in[0] & midi_in[1] & midi_in[2] & midi_in[3]
                                 : 1'b1;
assign midi_out[3] = midi_sel[3] ? midi_in[0] & midi_in[1] & midi_in[2] & midi_in[3]
                                 : 1'b1;

always @(posedge clk)
begin : bhv_sel
    if (midi_sel[0]) begin
        _midi_sel[0] <= midi_sel[0];
    else
        _midi_sel[0] <= _midi_sel[0];
    end
    
    if (midi_sel[1]) begin
        _midi_sel[1] <= midi_sel[1];
    else
        _midi_sel[1] <= _midi_sel[1];
    end
    
    if (midi_sel[2]) begin
        _midi_sel[2] <= midi_sel[2];
    else
        _midi_sel[2] <= _midi_sel[2];
    end
    
    if (midi_sel[2]) begin
        _midi_sel[2] <= midi_sel[2];
    else
        _midi_sel[2] <= _midi_sel[2];
    end
end

endmodule
