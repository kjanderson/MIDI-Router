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
 * See the datasheet for the TI SN74ALVC7804 for the datasheet from which
 * this design was inspired.
 *
 * Notes
 * This seems to be working for a single data packet at one time.
 * I need to make sure all the functions work.
 *
 * Read from the FIFO doesn't work. Need to find out why.
 *
 * History
 * Revision Date       Notes
 * 0.0      2020-05-25 Initial version
 *
 * Signal description
 *   reset:   issue an active-high reset of this module
 *   clk:     32.5 KHz clock
 *   rd:      read enable
 *   wr:      write enable
 *   oe_n:    output enable
 *   data_i:  incoming data from MIDI UARTs
 *   data_o:  outgoing data to output shift register
 *   full_n:  active low signal indicating queue is full
 *   empty_n: active low signal indicating queue is empty
 *********************************************************************/
module fifo(
    reset,
    clk,
    rd,
    wr,
    oe_n,
    data_i,
    data_o,
    full_n,
    empty_n
);

parameter ADDR_SIZE = 9;
parameter RAM_DEPTH = (1 << ADDR_SIZE);
parameter WIDTH = 8;

input  wire             reset;
input  wire             clk;
input  wire             rd;
input  wire             wr;
input  wire             oe_n;
input  wire [WIDTH-1:0] data_i;
output wire [WIDTH-1:0] data_o;
output wire             full_n;
output wire             empty_n;

/* continuous assignments */

/* full_n: the read pointer's LSBs and writer pointer's LSBs match, and the MSBs don't */
assign full_n = !((rd_pointer[ADDR_SIZE] ^ wr_pointer[ADDR_SIZE]) && (rd_pointer[ADDR_SIZE-1:0] == wr_pointer[ADDR_SIZE-1:0]));

/* empty_n */
assign empty_n = !(rd_pointer == wr_pointer);

/* internal signals */
reg [ADDR_SIZE:0] rd_pointer;
reg [ADDR_SIZE:0] wr_pointer;
wire ram_we;
wire ram_re;

assign ram_re = ~oe_n;
assign ram_we = 1'b1;

/* MSb is inverted when the address wraps */
always @(posedge clk, posedge reset)
begin: bhv_wr_pointer
    if (reset == 1'b1) begin
        wr_pointer <= 0;
    end
    else begin
        if (wr == 1'b1) begin
            wr_pointer <= wr_pointer + 1;
        end
        else begin
            wr_pointer <= wr_pointer;
        end
    end
end

/* MSb is inverted when the address wraps */
always @(posedge clk, posedge reset)
begin: bhv_rd_pointer
    if (reset == 1'b1) begin
        rd_pointer <= 0;
    end
    else begin
        if (rd == 1'b1) begin
            rd_pointer <= rd_pointer + 1;
        end
        else begin
            rd_pointer <= rd_pointer;
        end
    end
end

/* infer block RAM */
ram ram0(
    .wdata(data_i),
    .waddr(wr_pointer[ADDR_SIZE-1:0]),
    .we(ram_we),
    .wclk(!clk),
    .rdata(data_o),
    .raddr(rd_pointer[ADDR_SIZE-1:0]),
    .re(ram_re),
    .rclk(clk)
);

/* synchronize the IRQ request to the bus clock */
/*
synchronizer syn0(
    .clk(clk),
    .a_in(midi_int[0]),
    .y_out(irq_sync[0])
);

synchronizer syn1(
    .clk(clk),
    .a_in(midi_int[1]),
    .y_out(irq_sync[1])
);

synchronizer syn2(
    .clk(clk),
    .a_in(midi_int[2]),
    .y_out(irq_sync[2])
);

synchronizer syn3(
    .clk(clk),
    .a_in(midi_int[3]),
    .y_out(irq_sync[3])
);
*/

endmodule
