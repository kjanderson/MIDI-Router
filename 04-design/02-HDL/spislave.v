/**********************************************************************
 * shiftreg.v
 *
 * Description
 * This module implements a shift register to be compatible with a SPI
 * module operating in mode (CKP=0, CKE=0).
 * Data is output on SCK rising edge and sampled on the SCK falling edge.
 *********************************************************************/
module spislave(
    clk,
    sck,
    sdi,
    sdo,
    ss,
    data_i,
    data_o,
    ld,
    rdy
);

input  wire       clk;
input  wire       sck;
input  wire       sdi;
output wire       sdo;
input  wire       ss;
input  wire [7:0] data_i;
output wire [7:0] data_o;
input  wire       ld;
output wire       rdy;

reg int_sck;
reg int_ss;
reg [7:0] int_sr;
reg int_sdo;
wire sck_rising;
wire ss_rising;
reg int_rdy;
reg int_rdy_arm;

assign sdo = int_sdo;
assign data_o = int_sr;
assign sck_rising = (sck == 1) && (int_sck == 0);
assign ss_rising = (ss == 1) && (int_ss == 0);
assign rdy = int_rdy;

always @(posedge clk)
begin: bhv_sck
    int_sck <= sck;
end

always @(posedge clk)
begin: bhv_ss
    int_ss <= ss;
end

/* data output during clk rising edge */
always @(posedge sck)
begin: bhv_sdo
    int_sdo <= int_sr[7];
end

/* data sampled during clk falling edge */
/*
always @(negedge sck, posedge ld)
begin: bhv_sr
    if ((ld == 1) && (ss == 1)) begin
        int_sr <= data_i;
    end
    else begin
        int_sr <= {int_sr[6:0], sdi};
    end
end
*/
always @(negedge sck)
begin: bhv_sr
    int_sr <= {int_sr[6:0], sdi};
end

always @(posedge clk, posedge ss)
begin: bhv_arm
    if (ss == 1) begin
        int_rdy_arm <= 0;
    end
    else begin
        int_rdy_arm <= 1;
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

