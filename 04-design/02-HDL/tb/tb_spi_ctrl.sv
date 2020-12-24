/**********************************************************************
 * tb_spi_ctrl.sv
 *
 * This module implements the test bench for the spi_ctrl module.
 *
 * Status
 * in development
 *
 * Notes
 *   there's a problem on the int_bit_cnt counter. It stops counting, and probably isn't on the right value for sampling.
 *********************************************************************/
`timescale 1ns/1ps

module tb(
);

reg clk;
reg sck_in;
reg spi_enable;
reg spi_mosi;
wire spi_miso;
reg rst;
reg  spi_sck;
integer ii;
wire [7:0] wb_addr;
reg  [7:0] wb_dat_i;
wire [7:0] wb_dat_o;
wire wb_stb;
reg  wb_ack;
wire wb_we;
reg spi_ss;
reg [7:0] spi_data_o;

always #4 clk <= ~clk;

assign wb_ack = wb_stb;

always @(posedge clk)
begin: bhv_sck_in
    if (spi_enable == 1) begin
        spi_sck = spi_sck + 1;
    end
    else begin
        spi_sck = 1;
    end
end

task spi_xchg;
    input [7:0] datai;
    output [7:0] datao;
    
    for (ii=0; ii<8; ii++) begin
        spi_mosi <= datai[7-ii];
        @(posedge spi_sck);
        datao[7-ii] = spi_miso;
    end
endtask

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    spi_enable = 0;
    spi_mosi = 0;
    spi_ss = 1;
    
    /* initialize internal memory for sr0 instance */
    sc0.sr0.int_sr = 8'h00;
    sc0.sr0.int_ser_o = 0;
    
    sc0.int_spi_curr_state = 0;
    sc0.int_spi_next_state = 0;
    sc0.int_cmd = 0;
    sc0.int_addr = 0;
    sc0.int_data = 0;
    sc0.int_bit_cnt = 0;
    sc0.spi_data_i = 0;
    sc0.spi_ld = 0;
    sc0.int_wb_stb_o = 0;
    
    /* generate reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* send the following sequence: read address 0, provide clock for data */
    @(posedge clk);
    spi_ss = 0;
    spi_enable = 1;
    spi_xchg(8'h00, spi_data_o);
    spi_enable = 0;
    @(posedge clk);
    @(posedge clk);
    spi_enable = 1;
    spi_xchg(8'h00, spi_data_o);
    spi_enable = 0;
    spi_ss = 1;
    @(posedge clk);
    @(posedge clk);
    
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

endmodule
