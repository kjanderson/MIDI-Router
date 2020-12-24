module shiftreg(
    sck,
    ser_i,
    ser_o,
    data_i,
    data_o,
    ld
);

input  wire       sck;
input  wire       ser_i;
output wire       ser_o;
input  wire [7:0] data_i;
output wire [7:0] data_o;
input  wire       ld;

reg [7:0] int_sr;
reg int_ser_o;

assign ser_o = int_ser_o;
assign data_o = int_sr;

always @(negedge sck)
begin: bhv_ser_o
    int_ser_o <= int_sr[7];
end

/* data sampled during clk falling edge */
always @(posedge sck, posedge ld)
begin: bhv_sr
    if (ld == 1) begin
        int_sr <= data_i;
    end
    else begin
        int_sr <= {int_sr[6:0], ser_i};
    end
end

endmodule
