/**********************************************************************
 * tb_midi_rx
 *
 * This module implements the test bench for the midi_rx module.
 *
 * The application provides a 125 KHz sample clock to the module.
 *
 * Notes
 * This module compiles and generates midi_in.
 * Still need to verify the bus and irq interface.
 * May need to come back to irq and bus_rd interface, depending on details
 * of the FIFO implementation.
 *
 * TODO
 *
 * Tests
 * 01: verify the midi_rx module receives a signal and asserts its data on the bus.
 * 02: verify the midi_rx module sends queued data when a status byte is received.
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg rst;
reg clk;
reg midi_in;
reg [7:0] midi_tst_data;
reg [7:0] midi_vfc_data;
reg [7:0] addr;
reg stb;
reg we;
wire ack;

always #4 clk <= ~clk;

/* send data on falling clock edge */
task uart_tx;
    input [7:0] datai;
    integer ii;
    integer jj;
    
    begin
    /* start bit */
    @(negedge clk);
    midi_in = 1'b0;
    for (ii=0; ii<8; ii++) begin
        @(negedge clk);
    end
    
    /* data bits */
    for (jj=0; jj<8; jj=jj+1) begin
        midi_in = datai[jj];
        for (ii=0; ii<8; ii=ii+1) begin
            @(negedge clk);
        end
    end
    
    /* stop bit */
    midi_in = 1'b1;
    for (ii=0; ii<8; ii++) begin
        @(negedge clk);
    end
    end
endtask

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    midi_in = 1'b1;
    addr = 8'h00;
    midi_tst_data = 8'h00;
    stb = 1'b0;
    we = 1'b0;
    
    /* reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* simulation */
    @(negedge clk);
    midi_tst_data = 8'hDE;
    uart_tx(midi_tst_data);
    
    /* wait for data ready in this test case */
    // @(posedge m0.int_uart_data_rdy);
    
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    addr = 8'h00;
    stb = 1'b1;
    @(negedge clk);
    stb = 1'b0;
    assert(midi_vfc_data == 8'h01);
    
    @(negedge clk);
    addr = 8'h01;
    stb = 1'b1;
    @(negedge clk);
    stb = 1'b0;
    assert(midi_vfc_data == midi_tst_data);
    
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    
    $finish;
end

midi_rx m0(
    .midi_in(midi_in),
    .wb_clk_i(clk),
    .wb_rst_i(rst),
    .wb_addr_i(addr),
    .wb_dat_i(midi_tst_data),
    .wb_dat_o(midi_vfc_data),
    .wb_stb_i(stb),
    .wb_ack_o(ack),
    .wb_we_i(we)
);

endmodule
