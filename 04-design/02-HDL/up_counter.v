module up_counter
(
    clk,
    clr,
    cnt
);

input wire clk;
input wire clr;
output wire [7:0] cnt;

reg [7:0] int_cnt;

assign cnt = int_cnt;

always @(posedge clk)
begin: bhv_cnt
    if (clr == 1) begin
        int_cnt <= 0;
    end
    else begin
        int_cnt <= int_cnt + 1;
    end
end

endmodule

