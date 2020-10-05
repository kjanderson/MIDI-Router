module synchronizer(
    reset,
    clk,
    a,
    y
);

input  wire reset;
input  wire clk;
input  wire a;
output wire y;

reg [1:0] _sr;

assign y = _sr[1];

always @(posedge clk, posedge reset)
begin: bhv_y
    if (reset == 1'b1) begin
        _sr <= 0;
    end
    else begin
        _sr[0] <= a;
        _sr[1] <= _sr[0];
    end
end

endmodule
