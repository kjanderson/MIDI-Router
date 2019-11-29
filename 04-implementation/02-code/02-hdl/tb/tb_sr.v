/**********************************************************************
 * tb_spi
 *
 * This module implements the test bench for the shiftreg module.
 *
 * The intended application provides a 500 kHz SPI clock.
 * To simulate this, a counter is invoked in the test bench that acts
 * as a prescaler.
 * To simulate a break between bytes of data, the blank parameter is
 * directly controlled in the initial block.
 * The data sent to the device is controlled with the register data.
 *********************************************************************/

module tb(
);

reg clk;
reg spi_sck_in;
wire spi_sck;
reg spi_si;
wire spi_so;
reg spi_sck_enable;
reg rst;
reg [7:0] spi_read_data;
wire [7:0] spi_reg;

task spi_xchg;
    input [7:0] datai;
    output [7:0] datao;
    
    for (int i=0; i<8; i++) begin
        /* assert data for si to sample on the active sck edge */
        @(negedge spi_sck);
        spi_si <= datai[7-i];
        /* read sampled data on the inactive sck edge */
        @(posedge spi_sck);
        datao[7-i] <= spi_so;
    end
endtask

always #5 clk <= ~clk;

always #40 spi_sck_in <= ~spi_sck_in;

assign spi_sck = (spi_sck_enable) ? spi_sck_in : 1'b1;

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
	clk = 0;
	spi_sck_in = 1;
	spi_si = 0;
	spi_sck_enable = 0;
	spi_read_data = 8'h00;
    @(posedge clk);
    @(posedge clk);
    rst = 1;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h01, spi_read_data);
    spi_sck_enable = 0;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h00, spi_read_data);
	spi_sck_enable = 0;

    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h02, spi_read_data);
    spi_sck_enable = 0;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h00, spi_read_data);
	spi_sck_enable = 0;

    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h04, spi_read_data);
    spi_sck_enable = 0;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h00, spi_read_data);
	spi_sck_enable = 0;

    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h08, spi_read_data);
    spi_sck_enable = 0;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h00, spi_read_data);
	spi_sck_enable = 0;

    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h10, spi_read_data);
    spi_sck_enable = 0;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h00, spi_read_data);
	spi_sck_enable = 0;

    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h20, spi_read_data);
    spi_sck_enable = 0;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h00, spi_read_data);
	spi_sck_enable = 0;

    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h40, spi_read_data);
    spi_sck_enable = 0;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h00, spi_read_data);
	spi_sck_enable = 0;

    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h80, spi_read_data);
    spi_sck_enable = 0;
    @(posedge spi_sck_in);
    spi_sck_enable = 1;
    spi_xchg(8'h00, spi_read_data);
	spi_sck_enable = 0;
	$finish;
end

shiftreg sr0(
    .nreset(rst),
    .clk(clk),
    .spi_clk(spi_sck),
    .din(spi_si),
    .dout(spi_so),
    .regout(spi_reg)
);

endmodule
