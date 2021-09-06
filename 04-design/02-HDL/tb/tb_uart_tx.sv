/**********************************************************************
 * tb_uart_tx.sv
 *
 * This module implements the test bench for the uart_tx module.
 *
 * The application provides a 250 KHz sample clock to the module.
 *
 * Notes
 * This module compiles and generates midi_out.
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg rst;
reg clk;
reg tx_strobe;
reg [7:0] midi_data;
wire midi_tx;
wire tx_busy;
integer ii;
wire clk_en_2;
wire clk_en_4;
wire clk_en_8;
wire clk_en_16;
wire clk_en_32;
wire clk_en_64;

always #4 clk <= ~clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    $dumpfile("tb_uart_tx.vcd");
    $dumpvars(0, tb);

    rst = 0;
    clk = 0;
    tx_strobe = 0;
    midi_data = 8'h00;
    u0.int_cnt = 0;
    u0.int_bit_cnt = 0;
    
    /* reset pulse */
    @(negedge clk_en_8);
    rst = 1;
    @(negedge clk_en_8);
    rst = 0;
    
    /* simulation */
    @(negedge clk_en_8);
    midi_data = 8'h80;
    tx_strobe = 1'b1;
    @(negedge clk_en_8);
    tx_strobe = 1'b0;
    @(negedge tx_busy);

    for (ii=0; ii<90; ii++) begin
        @(posedge clk_en_8);
    end
    
    
    $finish;
end

clk_en_gen cg0(
    .clk(clk),
    .clk_en_2(clk_en_2),
    .clk_en_4(clk_en_4),
    .clk_en_8(clk_en_8),
    .clk_en_16(clk_en_16),
    .clk_en_32(clk_en_32),
    .clk_en_64(clk_en_64)
);

uart_tx u0(
    .rst(rst),
    .clk(clk),
    .clk_en(clk_en_8),
    .tx_strobe(tx_strobe),
    .data(midi_data),
    .tx(midi_tx),
    .busy(tx_busy)
);

endmodule
