/**********************************************************************
 * tb_spi
 *
 * This module implements the test bench for the shiftreg module.
 *
 * The intended application provides a 500 kHz SPI clock.
 * To simulate this, a counter is invoked in the test bench that acts
 * as a prescaler.
 * To simulate a break between bytes of data, the blank parameter is
 * directly controlled in the initial block.
 * The data sent to the device is controlled with the register data.
 *********************************************************************/

module tb(
);

reg clk;
reg  [3:0] midi_in;
wire [3:0] midi_out;
reg  [3:0] midi_sel;

always #5 clk <= ~clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    clk = 0;
    midi_in = 4'h0;
    midi_sel = 4'h0;
    @(posedge clk);
    assert(midi_out == (midi_in & midi_sel));
    midi_in = 4'h1;
    @(posedge clk);
    assert(midi_out == (midi_in & midi_sel));
    midi_in = 4'h2;
    @(posedge clk);
    assert(midi_out == (midi_in & midi_sel));

    $finish;
end

shiftreg sr0(
    .clk(clk),
    .midi_in(midi_in),
    .midi_out(midi_out),
    .midi_sel(midi_sel)
);

endmodule
