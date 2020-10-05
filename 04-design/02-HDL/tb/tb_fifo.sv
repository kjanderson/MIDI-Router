/**********************************************************************
 * tb_fifo
 *
 * This module implements the test bench for the fifo module.
 *
 * The application provides a 32.5 KHz sample clock to the module.
 *
 * Tests:
 *  01: test enough writes to fill the buffer.
 *      Verify the internal buffer matches the data that was written.
 *      Verify the buffer full status is true.
 *  02: read out the buffer.
 *      Verify the buffer empty status is true.
 *      Verify the buffer full status is false.
 *  03: test simultaneous read and write.
 *      Verify the FIFO empty status is true.
 *      Verify the FIFO full status is false.
 *  04: push an item, then simultaneously read and write.
 *      Verify the FIFO empty status is false.
 *      Verify the FIFO full status is false.
 *  05: pop the FIFO item.
 *      Verify the FIFO empty status is true.
 *      Verify the FIFO full status is false.
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg clk;
reg rst;
wire [7:0] fifo_data;
wire full_n;
wire empty_n;
reg [7:0] midi_data;
reg rd;
reg wr;
reg oe_n;
integer i;
integer j;

always #4 clk <= ~clk;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    oe_n = 1;
    rd = 0;
    wr = 0;
    midi_data = 8'h00;
    
    /* generate reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* verify initial conditions are met */
    assert(fifo_0.rd_pointer == 0);
    assert(fifo_0.wr_pointer == 0);
    assert(full_n == 1);
    assert(empty_n == 0);
    
    /* test enough writes to fill the FIFO buffer */
    @(negedge clk);
    
    for (i=0; i<511; i++) begin
        wr = 1'b1;
        midi_data = midi_data + 1;
        @(negedge clk);
        assert(fifo_0.rd_pointer[8:0] == 0);
        j = fifo_0.wr_pointer[8:0];
        assert(j == i+1);
        assert(fifo_0.ram0._mem_data[i] == midi_data);
    end
    
    midi_data = midi_data + 1;
    @(negedge clk);
    assert(fifo_0.rd_pointer[8:0] == 0);
    j = fifo_0.wr_pointer[8:0];
    assert(j == 0);
    assert(fifo_0.ram0._mem_data[511] == midi_data);
    
    assert(fifo_0.empty_n == 1);
    assert(fifo_0.full_n == 0);
    
    /* test enough reads to empty the FIFO buffer */
    wr = 0;
    rd = 1;
    for (i=0; i<511; i++) begin
        @(negedge clk);
        j = fifo_0.rd_pointer[8:0];
        assert(j == i+1);
        assert(empty_n == 1);
    end
    
    @(negedge clk);
    j = fifo_0.rd_pointer[8:0];
    assert(j == 0);
    
    assert(fifo_0.empty_n == 0);
    assert(fifo_0.full_n == 1);
    
    /* with the queue empty, test simultaneous read and write */
    wr = 1;
    rd = 1;
    @(negedge clk);
    j = fifo_0.rd_pointer[8:0];
    assert(j == 1);
    j = fifo_0.wr_pointer[8:0];
    assert(j == 1);
    assert(fifo_0.empty_n == 0);
    assert(fifo_0.full_n == 1);
    
    /* push an item to the queue, then do a simultaneous read and write */
    wr = 1;
    rd = 0;
    @(negedge clk);
    j = fifo_0.rd_pointer[8:0];
    assert(j == 1);
    j = fifo_0.wr_pointer[8:0];
    assert(j == 2);
    assert(fifo_0.empty_n == 1);
    assert(fifo_0.full_n == 1);
    
    wr = 1;
    rd = 1;
    @(negedge clk);
    j = fifo_0.rd_pointer[8:0];
    assert(j == 2);
    j = fifo_0.wr_pointer[8:0];
    assert(j == 3);
    assert(fifo_0.empty_n == 1);
    assert(fifo_0.full_n == 1);
    
    /* pop the item from the queue, and make sure the queue is empty */
    wr = 0;
    rd = 1;
    @(negedge clk);
    j = fifo_0.rd_pointer[8:0];
    assert(j == 3);
    j = fifo_0.wr_pointer[8:0];
    assert(j == 3);
    assert(fifo_0.empty_n == 0);
    assert(fifo_0.full_n == 1);
    
    $finish;
end

fifo fifo_0(
    .reset(rst),
    .clk(clk),
    .rd(rd),
    .wr(wr),
    .data_i(midi_data),
    .data_o(fifo_data),
    .empty_n(empty_n),
    .full_n(full_n)
);

endmodule
