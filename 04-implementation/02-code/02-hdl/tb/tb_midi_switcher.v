/**********************************************************************
 * tb_midi_switcher
 *
 * This module implements the test bench for the midi_switcher module.
 *
 * The intended application provides an 8 MHz clock and 1 MHz SPI clock.
 * The SPI clock provides 8 clocks separated by a 1 usec pause.
 * The SS line remains active (low) from reset to simulation finish.
 *
 * The objective of this simulation is to determine if the outputs
 * match the values shifted in through the shift-register interface.
 *
 * status:
 *  - timescale verified
 *  - clk timing verified
 *  - spi_clk timing verified
 *  - end value of shift register verified
 *  - TODO: add blanking to spi_clk to simulate one bit time between frames
 *  - TODO: add $monitor statement to verify each data line at end of SPI transfer
 *********************************************************************/
`timescale 100 ps / 10 ps

module test_midi_sw;

initial
begin
    $dumpfile("test_midi_sw.vcd");
    $dumpvars(0, test_midi_sw);
    // start first data transfer at 1 us
    #10000 spi_blank = 0;
    // blank between first and second transfer at 8 us
    #80000 spi_blank = 1;
    #10000 spi_blank = 0;
    // second transfer
    #80000 spi_blank = 1;
    #10000 spi_blank = 0;
    // third transfer
    #80000 spi_blank = 1;
    #10000 spi_blank = 0;
    // fourth transfer
    #80000 spi_blank = 1;
    #10000 spi_blank = 0;
    // fifth transfer
    #80000 spi_blank = 1;
    #10000 spi_blank = 0;
    // sixth (final) transfer
    #80000 spi_blank = 1;
    
    // cleanup
    #10000 $display($time, " %x", spi_data);
    $display($time, " %x", tst_out);
    // finish simulation 
    $finish;
end

/* clock */
reg clk = 0;
always #625 clk = !clk;

/* SPI clock */
reg spi_clk_gen = 0;
always #5000 spi_clk_gen = !spi_clk_gen;
reg spi_blank = 1;
wire spi_clk;
reg spi_ss = 1;

wire reset;
reg [6:0] spi_cnt = 47;
reg spi_mosi = 0;
wire spi_miso;
//reg [48:0] spi_data = 49'h07FFFFFFFFF;
reg [47:0] spi_data = 49'h056DEADBEEF;
//reg [47:0] spi_data = 49'h00000000001;

wire [7:0] pmp_ad;
wire pmp_rd;
wire pmp_wr;
wire pmp_all;
wire pmp_alh;
wire pmp_ack;
wire pmp_be0;
wire pmp_be1;
wire pmp_cs1;
wire [19:0] gpio_bin;
wire [2:0] gpio_fbin;
wire [38:0] tst_out;

//assign spi_mosi = spi_data[spi_cnt];
assign spi_clk = (spi_blank == 1) ? 0 : spi_clk_gen;
assign tst_out = {pmp_cs1,
                  pmp_be1,
                  pmp_be0,
                  pmp_ack,
                  pmp_alh,
                  pmp_all,
                  pmp_wr,
                  pmp_rd,
                  gpio_fbin,
                  gpio_bin,
                  pmp_ad};

midi_switcher midi_switcher0(
    clk,
    pmp_ad,
    pmp_rd,
    pmp_wr,
    pmp_all,
    pmp_alh,
    pmp_ack,
    pmp_be0,
    pmp_be1,
    pmp_cs1,
    gpio_bin,
    gpio_fbin,
    spi_clk,
    spi_miso,
    spi_mosi,
    spi_ss
);

mstreset rst0(
    reset,
    clk
);

/* clock out the data to the SPI module on the clock rising edge */
always @ (posedge spi_clk)
begin
    if(reset == 0)
    begin
        spi_mosi <= 0;
    end
    else
    begin
        spi_mosi <= spi_data[spi_cnt];
    end
end

/* update the index on the falling edge of spi_clk */
always @ (negedge spi_clk)
begin
    if(reset == 0)
    begin
        spi_cnt <= 47;
    end
    else
    begin
        if (spi_cnt > 0)
        begin
            spi_cnt <= spi_cnt - 1;
        end
    end
end

endmodule
