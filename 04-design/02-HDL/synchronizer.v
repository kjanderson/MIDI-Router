module synchronizer(
    clk,
    a,
    y
);

input  wire clk;
input  wire a;
output wire y;

reg [1:0] _sr;

assign y = _sr[1];

always @(posedge clk)
begin: bhv_y
    _sr[0] <= a;
    _sr[1] <= _sr[0];
end

endmodule
