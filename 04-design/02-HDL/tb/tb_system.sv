/**********************************************************************
 * tb_system.sv
 *
 * This module implements the test bench for the top-level system.
 *
 * Status
 * in development
 *
 * Notes
 *********************************************************************/
`timescale 1ns/1ps

`include "verilog_assert.vh"

module tb(
);

reg clk;
reg [2:0] sck_in;
reg spi_enable;
reg spi_mosi;
wire spi_miso;
reg rst;
wire spi_sck;
integer ii;
wire [7:0] wb_addr;
reg  [7:0] wb_dat_i;
wire [7:0] wb_dat_o;
wire wb_stb;
wire wb_ack;
wire wb_we;
reg spi_ss;
reg [7:0] spi_data_o;
reg midi_rx_0;
reg midi_in;

always #4 clk <= ~clk;

assign wb_ack = wb_stb;

assign spi_sck = (spi_enable == 1) ? sck_in[2] : 0;

always @(posedge clk)
begin: bhv_sck
    sck_in <= sck_in + 1;
end

task spi_xchg;
    input [7:0] datai;
    output [7:0] datao;

    /* setup frame: initialize clock input for clock driver and assert ss */
    /* SR samples on the falling edge and outputs on rising edge */
    begin
    @(posedge sck_in[2]);

    spi_ss = 0;
    spi_enable = 1;
    spi_mosi = datai[7];
    @(negedge spi_sck);
    datao[7] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[6];
    @(negedge spi_sck);
    datao[6] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[5];
    @(negedge spi_sck);
    datao[5] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[4];
    @(negedge spi_sck);
    datao[4] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[3];
    @(negedge spi_sck);
    datao[3] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[2];
    @(negedge spi_sck);
    datao[2] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[1];
    @(negedge spi_sck);
    datao[1] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[0];
    @(negedge spi_sck);
    datao[0] = spi_miso;

    spi_enable = 0;
    @(posedge sck_in[2]);
    spi_ss = 1;

    end
endtask

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
    $dumpfile("tb_system.vcd");
    $dumpvars(0, tb);

    rst = 0;
    clk = 0;
    spi_enable = 0;
    spi_mosi = 0;
    spi_ss = 1;
    sck_in = 0;
    midi_in = 1;
    
    /* initialize internal memory for sr0 instance */
    sc0.sr0.int_sr = 8'h00;
    sc0.sr0.int_sdo = 0;
    sc0.sr0.int_rdy = 0;
    sc0.sr0.int_rdy_arm = 0;
    
    sc0.int_spi_curr_state = 0;
    sc0.int_spi_next_state = 0;
    sc0.int_cmd = 0;
    sc0.int_addr = 0;
    sc0.int_data = 0;
    sc0.int_bit_cnt = 0;
    sc0.spi_data_i = 0;
    sc0.spi_ld = 0;
    sc0.int_wb_stb_o = 0;

    sc0.c0.int_cnt = 0;
    
    /* generate reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* send the following sequence: read address 0, provide clock for data */
    #2048 @(posedge clk);
    spi_xchg(8'h00, spi_data_o);
    @(posedge sck_in[2]);
    spi_xchg(8'h00, spi_data_o);
    @(posedge sck_in[2]);
    
    @(posedge clk);
    
    $finish;
end

spi_ctrl sc0(
    .clk(clk),
    .spi_miso(spi_miso),
    .spi_mosi(spi_mosi),
    .spi_sck(spi_sck),
    .spi_ss(spi_ss),
    .wb_clk_i(clk),
    .wb_rst_i(rst),
    .wb_addr_o(wb_addr),
    .wb_dat_i(wb_dat_i),
    .wb_dat_o(wb_dat_o),
    .wb_stb_o(wb_stb),
    .wb_ack_i(wb_ack),
    .wb_we_o(wb_we)
);

midi_rx mi0(
    .midi_in(midi_rx_0),
    .wb_clk_i(clk),
    .wb_rst_i(rst),
    .wb_addr_i(wb_addr),
    .wb_dat_i(wb_dat_o),
    .wb_dat_o(wb_dat_i),
    .wb_stb_i(wb_stb),
    .wb_ack_o(wb_ack),
    .wb_we_i(wb_we)
);

endmodule

