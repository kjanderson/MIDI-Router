module wb_ram(
    wb_rst_i,
    wb_clk_i,
    wb_addr_i,
    wb_dat_i,
    wb_dat_o,
    wb_we_i,
    wb_stb_i,
    wb_ack_o,
);

input  wire wb_rst_i;
input  wire wb_clk_i;
input  wire [7:0] wb_addr_i;
input  wire [7:0] wb_dat_i;
output wire [7:0] wb_dat_o;
input  wire wb_we_i;
input  wire wb_stb_i;
output wire wb_ack_o;

reg int_ack;

assign wb_ack_o = int_ack;

always @(wb_stb_i)
begin: bhv_ack
    int_ack = wb_stb_i;
end

ram r0(
    .wdata(wb_dat_i),
    .waddr(wb_addr_i),
    .we(wb_we_i & wb_stb_i),
    .wclk(wb_clk_i),
    .rdata(wb_dat_o),
    .raddr(wb_addr_i),
    .re(~wb_we_i & wb_stb_i),
    .rclk(wb_clk_i)
);

endmodule
