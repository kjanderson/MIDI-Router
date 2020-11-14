module shiftreg(
    clk,
    ser_i,
    ser_o,
    data_i,
    ld
);

input  wire       clk;
input  wire       ser_i;
output wire       ser_o;
input  wire [7:0] data_i;
input  wire       ld;

reg [7:0] int_sr;
reg int_ser_o;

assign ser_o = int_ser_o;

always @(posedge clk)
begin: bhv_ser_o
    int_ser_o <= int_sr[7];
end

/* data sampled during clk falling edge */
always @(negedge clk, posedge ld)
begin: bhv_sr
    if (ld == 1) begin
        int_sr <= data_i;
    end
    else begin
        int_sr <= {int_sr[6:0], ser_i};
    end
end

endmodule
