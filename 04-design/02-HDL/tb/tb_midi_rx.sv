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
 *  7. add a feature to clear the bitmap when the appropriate data item is read.
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
reg [7:0] wb_addr;
reg [7:0] wb_dat_o;
wire [7:0] wb_dat_i;
reg wb_stb;
reg wb_we;
wire wb_ack;

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
    midi_tst_data = 8'h00;
    wb_addr = 8'h00;
    wb_dat_o = 8'h00;
    wb_stb = 1'b0;
    wb_we = 1'b0;
    
    /* reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* simulation */
    /* test case 1: send complete message on input 1 */
    midi_tst_data = 8'h80;
    uart_tx(midi_tst_data);
    // @(posedge m0.int_uart_data_rdy);

    midi_tst_data = 8'h3E;
    uart_tx(midi_tst_data);
    // @(posedge m0.int_uart_data_rdy);

    midi_tst_data = 8'h40;
    uart_tx(midi_tst_data);
    // @(posedge m0.int_uart_data_rdy);

    wb_addr = 8'h00;
    wb_dat_o = 8'h00;
    wb_stb = 1'b1;
    @(posedge clk);
    @(posedge clk);
    wb_stb = 1'b0;

    @(posedge clk);
    @(posedge clk);

    wb_addr = 8'h02;
    wb_dat_o = 8'h00;
    wb_stb = 1'b1;
    @(posedge clk);
    @(posedge clk);
    wb_stb = 1'b0;

    /* test case 2: send complete 2-byte message */
    midi_tst_data = 8'hC0;
    uart_tx(midi_tst_data);

    midi_tst_data = 8'h00;
    uart_tx(midi_tst_data);
    
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    
    $finish;
end

midi_rx m0(
    .midi_in(midi_in),
    .clk(clk),
    .rst(rst),
    .wb_addr_i(wb_addr),
    .wb_dat_i(wb_dat_o),
    .wb_dat_o(wb_dat_i),
    .wb_we_i(wb_we),
    .wb_stb_i(wb_stb),
    .wb_ack_o(wb_ack)
);

endmodule
