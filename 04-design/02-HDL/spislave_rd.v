/**********************************************************************
 * spislave_rx
 *
 * Description
 * This module essentially implements a 74Xx165 (8-bit parallel-in serial-out)
 * device.
 *********************************************************************/
module spislave_rx
(
    sck,
    sck_inh,
    sdi,
    sdo,
    ss,
    data_i,
    ld,
    rdy
);

parameter DATA_WIDTH = 8;

input  wire sck;
input  wire sck_inh;
input  wire sdi;
output wire sdo;
input  wire ss;
input  wire [7:0] data_i;
input  wire ld;
output wire rdy;

wire int_sck;
reg int_rdy;
reg int_sdo;

assign int_sck = sck | sck_inh;

always @(posedge int_sck)
begin
    int_sdo <= int_sr[DATA_WIDTH-1];
end

always @(negedge int_sck, posedge ld)
begin
    if (ld == 1'b1) begin
        int_sr <= data_i;
    end
    else begin
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
