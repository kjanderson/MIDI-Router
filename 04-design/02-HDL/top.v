module top(
    reset,
    clk,
    midi_in,
    midi_out
);

/* I/O ports */
input  wire reset;
input  wire clk;
input  wire [3:0] midi_in;
output wire [3:0] midi_out;

/* internal signals */
wire [3:0] midi_sync;
wire [3:0] bus_addr;
wire [7:0] bus_data;
wire [3:0] irq;
wire fifo_rd;
wire fifo_wr;
wire [7:0] fifo_data;
wire [7:0] sr_data;
wire fifo_empty_n;
wire _midi_out;
wire [3:0] bus_rd;

assign midi_out[0] = _midi_out;
assign midi_out[1] = _midi_out;
assign midi_out[2] = _midi_out;
assign midi_out[3] = _midi_out;

/* synchronize MIDI inputs */
synchronizer s0(
    .reset(reset),
    .clk(clk),
    .a(midi_in[0]),
    .y(midi_sync[0])
);

synchronizer s1(
    .reset(reset),
    .clk(clk),
    .a(midi_in[1]),
    .y(midi_sync[1])
);

synchronizer s2(
    .reset(reset),
    .clk(clk),
    .a(midi_in[2]),
    .y(midi_sync[2])
);

synchronizer s3(
    .reset(reset),
    .clk(clk),
    .a(midi_in[3]),
    .y(midi_sync[3])
);

/* UART 0 for MIDI input */
midi_rx #(4'h0) mr0(
    .reset(reset),
    .clk(clk),
    .midi_in(midi_sync[0]),
    .bus_addr(bus_addr),
    .bus_dat(bus_data),
    .irq(irq[0]),
    .bus_rd(bus_rd[0])
);

/* UART 1 for MIDI input */
midi_rx #(4'h1) mr1(
    .reset(reset),
    .clk(clk),
    .midi_in(midi_sync[1]),
    .bus_addr(bus_addr),
    .bus_dat(bus_data),
    .irq(irq[1]),
    .bus_rd(bus_rd[1])
);

/* UART 2 for MIDI input */
midi_rx #(4'h2) mr2(
    .reset(reset),
    .clk(clk),
    .midi_in(midi_sync[2]),
    .bus_addr(bus_addr),
    .bus_dat(bus_data),
    .irq(irq[2]),
    .bus_rd(bus_rd[2])
);

/* UART 3 for MIDI input */
midi_rx #(4'h3) mr3(
    .reset(reset),
    .clk(clk),
    .midi_in(midi_sync[3]),
    .bus_addr(bus_addr),
    .bus_dat(bus_data),
    .irq(irq[3]),
    .bus_rd(bus_rd[3])
);

/* MIDI data bus master */
bus_master bm0(
    .reset(reset),
    .clk(clk),
    .addr(bus_addr),
    .data(bus_data),
    .irq(irq),
    .fifo_data(fifo_data),
    .fifo_wr(fifo_wr),
    .bus_rd(bus_rd)
);

/* FIFO for merging MIDI data */
fifo f0(
    .reset(reset),
    .clk(clk),
    .rd(fifo_rd),
    .wr(fifo_wr),
    .data_i(fifo_data),
    .data_o(sr_data),
    .empty_n(fifo_empty_n)
);

/* output shift register for MIDI output data */
shiftreg sr0(
    .reset(reset),
    .clk(clk),
    .data_i(sr_data),
    .ser_o(_midi_out),
    .fifo_rd(fifo_rd),
    .fifo_empty_n(fifo_empty_n)
);

endmodule
