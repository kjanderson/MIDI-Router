/**********************************************************************
 * tb_uart_rx
 *
 * This module implements the test bench for the uart_rx module.
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
 *  1. define how long bus_rd will remain asserted and therefore how long
 *     the midi_rx module will assert bus_dat.
 *
 * Tests
 * 01: verify midi_rx module 0 receives a signal and asserts its data on the bus.
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg rst;
reg clk;
reg midi_in;
wire [7:0] uart_dat;
reg [7:0] gen_midi_dat;
wire uart_data_rdy;
wire uart_tx_busy;
integer ii;

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
    
    /* reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;

    /* TODO: add initialization of registers */
    u0._uart_state = 0;
    u0._uart_bit_cnt = 0;
    u0._uart_samp_cnt = 0;
    u0._uart_sr = 0;
    u0._uart_reg = 0;
    u0._uart_data_rdy = 0;
    u0._samp = 0;
    u0._z_uart_in = 0;

    u1.int_curr_state = 0;
    u1.int_cnt = 0;
    u1.int_cnt_en = 0;
    u1.int_bit_cnt = 0;
    u1.int_bit_cnt_en = 0;
    u1.int_uart_sr = 0;
    u1.int_tx = 0;


    
    /* simulation */
    @(negedge clk);
    gen_midi_dat = 8'hDE;
    uart_tx(gen_midi_dat);
    
    assert(uart_dat == 8'hDE);
    assert(uart_data_rdy == 1'b1);

    for (ii=0; ii<100; ii=ii+1) begin
        @(posedge clk);
    end
    
    $finish;
end

uart_rx u0(
    .reset(rst),
    .clk(clk),
    .uart_in(midi_in),
    .uart_data(uart_dat),
    .uart_data_rdy(uart_data_rdy)
);

uart_tx u1(
    .rst(rst),
    .clk(clk),
    .tx_strobe(uart_data_rdy),
    .data(uart_dat),
    .tx(midi_out),
    .busy(uart_tx_busy)
);

endmodule
