/**********************************************************************
 * tb_sr.sv
 *
 * This module implements the test bench for the shiftreg module.
 *
 * The intended application provides a 1 MHz SPI clock.
 * To simulate this, a counter is invoked in the test bench that acts
 * as a prescaler.
 * To simulate a break between bytes of data, the blank parameter is
 * directly controlled in the initial block.
 * The data sent to the device is controlled with the register data.
 *
 * Status
 * Basic design elements are verified.
 *********************************************************************/
module tb(
);

reg clk;
reg sck_in;
reg spi_enable;
reg mosi;
reg rst;
wire sck;
reg spi_ld;
reg [7:0] ld_data;
wire [7:0] data_out;
reg [7:0] test_data;
integer ii;

always #4 clk <= ~clk;

assign sck = (spi_enable == 1) ? sck_in : 1;

always @(posedge clk)
begin: bhv_sck_in
    sck_in <= sck_in + 1;
end

task spi_xchg;
    input [7:0] datai;
    output [7:0] datao;
    
    for (ii=0; ii<8; ii++) begin
        mosi <= datai[7-ii];
        //@(negedge sck);
        @(posedge sck);
        datao[7-ii] = miso;
    end
endtask

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    sck_in = 0;
    spi_enable = 0;
    spi_ld = 0;
    mosi = 0;
    
    /* initialize internal memory for sr0 instance */
    sr0.int_sr = 8'h00;
    sr0.int_ser_o = 0;
    
    /* generate reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    @(posedge clk);
    ld_data = 8'hDE;
    spi_ld = 1;
    @(posedge clk);
    spi_ld = 0;
    assert (sr0.int_sr == ld_data);
    @(posedge sck_in);
    spi_enable = 1;
    spi_xchg(ld_data, test_data);
    assert(test_data == ld_data);
    spi_enable = 0;
    @(posedge clk);
    
    @(posedge clk);
    
    $finish;
end

shiftreg sr0(
    .sck(sck),
    .ser_i(mosi),
    .ser_o(miso),
    .data_i(ld_data),
    .data_o(data_out),
    .ld(spi_ld)
);

endmodule
