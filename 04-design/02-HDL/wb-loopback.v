/**********************************************************************
 * wb_loopback
 *
 * Description
 * This module implements a loopback interface for testing during
 * board bring up.
 *********************************************************************/
module wb_loopback(
    wb_rst_i,
    wb_clk_i,
    wb_addr_i,
    wb_data_i,
    wb_data_o,
    wb_stb_i,
    wb_we_i,
    wb_ack_o
);

input  wire wb_rst_i;
input  wire wb_clk_i;
input  wire [7:0] wb_addr_i;
input  wire [7:0] wb_data_i;
output wire [7:0] wb_data_o;
input  wire wb_stb_i;
input  wire wb_we_i;
output wire wb_ack_o;

/* internal signals */
reg [7:0] int_data;

assign wb_data_o = int_data;
assign wb_ack_o = wb_stb_i;

always @(posedge wb_clk_i)
begin: bhv_data
    if (wb_stb_i == 1) begin
        if (wb_we_i == 1) begin
            int_data <= wb_data_i;
        end
    end
end

endmodule

