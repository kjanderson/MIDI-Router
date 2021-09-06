/**********************************************************************
 * shiftreg_wr.v
 *
 * Description
 * This module implements a shift register to be compatible with a SPI
 * module operating in mode (CKP=0, CKE=0).
 * Data is output on SCK rising edge and sampled on the SCK falling edge.
 *
 * Verification level
 * This was simulated using ModelSim
 *********************************************************************/
module spislave_wr(
    clk,
    sck,
    sdi,
    sdo,
    ss,
    data_o,
    rdy
);

parameter DATA_WIDTH = 8;

input  wire       clk;
input  wire       sck;
input  wire       sdi;
output wire       sdo;
input  wire       ss;
output wire [DATA_WIDTH-1:0] data_o;
output wire       rdy;

reg int_ss;
reg [DATA_WIDTH-1:0] int_sr;
reg int_sdo;
wire ss_rising;
reg int_rdy;

assign sdo = int_sdo;
assign data_o = int_sr;
assign ss_rising = (ss == 1) && (int_ss == 0);
assign rdy = int_rdy;

always @(posedge clk)
begin: bhv_ss
    int_ss <= ss;
end

/* data output during clk rising edge */
always @(posedge sck)
begin: bhv_sdo
    if (ss == 0) begin
        int_sdo <= int_sr[DATA_WIDTH-1];
    end
end

/* data sampled during clk falling edge */
always @(negedge sck)
begin: bhv_sr
    if (ss == 0) begin
        int_sr <= {int_sr[DATA_WIDTH-2:0], sdi};
    end
end

always @(posedge clk)
begin: bhv_rdy
    if (ss_rising) begin
        int_rdy <= 1;
    end
    else if (int_rdy == 1) begin
        int_rdy <= 0;
    end
end

endmodule
