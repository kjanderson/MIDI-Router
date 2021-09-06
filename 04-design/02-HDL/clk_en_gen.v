module clk_en_gen(
    clk,
    clk_en_2,
    clk_en_4,
    clk_en_8,
    clk_en_16,
    clk_en_32,
    clk_en_64
);

input  wire clk;
output wire clk_en_2;
output wire clk_en_4;
output wire clk_en_8;
output wire clk_en_16;
output wire clk_en_32;
output wire clk_en_64;

/* internal signals */
reg [5:0] int_cnt;

/* continuous assignments */
assign clk_en_2 = int_cnt[0] == 0;
assign clk_en_4 = int_cnt[1:0] == 0;
assign clk_en_8 = int_cnt[2:0] == 0;
assign clk_en_16 = int_cnt[3:0] == 0;
assign clk_en_32 = int_cnt[4:0] == 0;
assign clk_en_64 = int_cnt[5:0] == 0;

always @(posedge clk)
begin
    int_cnt <= int_cnt + 1;
end

endmodule
