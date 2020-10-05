/**********************************************************************
 * tb_midi_tx
 *
 * This module implements the test bench for the midi_tx module.
 *
 * The application provides a 125 KHz sample clock to the module.
 *
 * Notes
 *
 * TODO
 *
 * Tests
 * 01: ? 
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

parameter STATE_IDLE = 1'b0;
parameter STATE_READ = 1'b1;

reg clk;
reg rst;
reg [7:0] midi_dat [3:0];
reg [3:0] midi_dat_rdy;
wire midi_dat_rd;
wire midi_tx;
integer ii;

always #4 clk <= ~clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    for (ii=0; ii<4; ii++) begin
        midi_dat[ii] = 0;
    end
    midi_dat_rdy = 0;
    
    /* reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* simulation */
    @(negedge clk);
    midi_dat[0] = 8'h01;
    midi_dat[1] = 8'h00;
    midi_dat[2] = 8'h00;
    midi_dat[3] = 8'h00;
    midi_dat_rdy = 4'h1;
    for (ii=0; ii<256; ii++) begin
        @(negedge clk);
    end
    
    /*
    */
    
    @(negedge clk);
    /*
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    */
    
    $finish;
end

midi_tx midi_tx_0(
    .rst(rst),
    .clk(clk),
    .midi_data(midi_dat),
    .midi_data_rdy(),
    .midi_data_rd(),
    .midi_tx()
);

endmodule
