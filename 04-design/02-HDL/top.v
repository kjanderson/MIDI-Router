module top(
    clk,
    midi_in,
    midi_out,
    gpio_fbin,
    spi_clk,
    spi_miso,
    spi_mosi,
    spi_ss
);

/* I/O ports */
input  wire clk;
input  wire [3:0] midi_in;
output wire [3:0] midi_out;
output wire [3:0] gpio_fbin;
input  wire spi_clk;
output wire spi_miso;
input  wire spi_mosi;
input  wire spi_ss;

/* internal signals */
wire int_reset;
wire [3:0] midi_sync;
wire [7:0] sr_data;
wire _midi_out;
wire int_spi_rdy;
wire int_uart_tx;
wire int_uart_busy;

/* route UART output to all MIDI outputs */
assign midi_out[0] = int_uart_tx;
assign midi_out[1] = int_uart_tx;
assign midi_out[2] = int_uart_tx;
assign midi_out[3] = int_uart_tx;

/* route MIDI inputs to the MCU */
assign gpio_fbin[0] = midi_in[0];
assign gpio_fbin[1] = midi_in[1];
assign gpio_fbin[2] = midi_in[2];
assign gpio_fbin[3] = midi_in[3];

/* synchronize MIDI inputs */
synchronizer s0(
    .clk(clk),
    .a(midi_in[0]),
    .y(midi_sync[0])
);

synchronizer s1(
    .clk(clk),
    .a(midi_in[1]),
    .y(midi_sync[1])
);

synchronizer s2(
    .clk(clk),
    .a(midi_in[2]),
    .y(midi_sync[2])
);

synchronizer s3(
    .clk(clk),
    .a(midi_in[3]),
    .y(midi_sync[3])
);

mstreset r0(
    .reset(int_reset),
    .clk(clk)
);

/* SPI interface */
spislave sr0(
    .clk(clk),
    .sck(spi_clk),
    .sdi(spi_mosi),
    .sdo(spi_miso),
    .ss(spi_ss),
    .data_i(8'h00),
    .data_o(sr_data),
    .ld(1'b0),
    .rdy(int_spi_rdy)
);

/* TX UART for output */
uart_tx u0(
    .rst(int_reset),
    .clk(clk),
    .tx_strobe(int_spi_rdy),
    .data(sr_data),
    .tx(int_uart_tx),
    .busy(int_uart_busy)
);

endmodule
