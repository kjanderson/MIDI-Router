/**********************************************************************
 * fifo.v
 *
 * Description
 * This module implements a FIFO queue. This is intended to be used to
 * buffer output so that notes that occur at the same time don't clobber
 * each other.
 *
 * Since there are 4 inputs, the queue depth only needs to be 4.
 *
 * History
 * Revision Date       Notes
 * 0.0      2020-03-28 Initial version
 *********************************************************************/
module fifo(
    reset_n,
    clk,
    stb_rd,
    stb_wr,
    data_i,
    data_o
);

input  wire reset_n;
input  wire clk;
input  wire stb_rd;
input  wire stb_wr;
input  wire [7:0] data_i;
output wire [7:0] data_o;

/* internal signals */
reg [7:0] _queue_buffer[3:0];
reg [3:0] _head;
reg [3:0] _tail;

endmodule
