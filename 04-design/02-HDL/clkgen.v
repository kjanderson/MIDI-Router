module clkgen(
    reset,
    clkin,
    clkdiv8
);

input  wire reset;
input  wire clkin;
output wire clkdiv8;

/* internal signals */
reg [2:0] _ps_cnt;

assign clkdiv8 = _ps_cnt[2];

always @(posedge clkin, posedge reset)
begin: bhv_ps_cnt
    if (reset == 1'b1) begin
        _ps_cnt <= 0;
    end
    else begin
        _ps_cnt <= _ps_cnt + 1;
    end
end

endmodule
