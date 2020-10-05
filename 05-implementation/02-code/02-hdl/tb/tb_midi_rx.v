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
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

reg clk;
reg bus_clk;
reg bus_rd;
reg midi_in;
reg rst;
wire rst_n;
wire irq;
wire [7:0] bus_dat;
reg [7:0] gen_midi_dat;

always #4 clk <= ~clk;
assign rst_n = ~rst;
always #32 bus_clk <= ~bus_clk;

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
    for (jj=7; jj>=0; jj=jj-1) begin
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
    bus_clk = 0;
    bus_rd = 0;
    midi_in = 1'b1;
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    @(negedge clk);
    gen_midi_dat = 8'hDE;
    uart_tx(gen_midi_dat);
    @(negedge bus_clk);
    @(negedge bus_clk);
    @(negedge bus_clk);
    @(negedge bus_clk);
    $finish;
end

always @(posedge bus_clk)
begin: bhv_bus_clk
    if (irq == 1'b1) begin
        bus_rd = 1'b1;
    end
    /*
    if (bus_rd == 1'b1) begin
        bus_rd = 1'b0;
    end
    */
end

midi_rx midi_rx_0(
    .reset_n(rst_n),
    .clk(clk),
    .midi_in(midi_in),
    .irq(irq),
    .bus_clk(bus_clk),
    .bus_rd(bus_rd),
    .bus_dat(bus_dat)
);

endmodule
