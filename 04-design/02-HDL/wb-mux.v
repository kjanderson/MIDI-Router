/**********************************************************************
 * wb-mux.v
 *
 * Description
 * This module implements a constant-sized course address selector,
 * as suggested by the WB-V4 specification. Each block of addresses is 16 wide.
 *********************************************************************/
module wb_mux(
    wb_addr_i,
    wb_dat_i,
    wb_dat_o
);

input  wire [7:0] wb_addr_i;
input  wire [11:0] wb_dat_i;
output wire [7:0] wb_dat_o;

reg [7:0] int_dat_o;
wire [3:0] int_sel;

assign wb_dat_o = int_dat_o;
assign int_sel = wb_addr_i[7:4];

always @(int_sel)
begin: bhv_dat_o
// TODO: how to select the bits out of wb_dat_i?
    if (int_sel == 4'h0) begin
        int_dat_o = wb_dat_i[7:0];
    end
    else if (int_sel == 4'h1) begin
        int_dat_o = wb_dat_i[15:8];
    end
    else if (int_sel == 4'h2) begin
        int_dat_o = wb_dat_i[23:16];
    end
    else if (int_sel == 4'h3) begin
        int_dat_o = wb_dat_i[31:24];
    end
    else if (int_sel == 4'h4) begin
        int_dat_o = wb_dat_i[39:32];
    end
    else if (int_sel == 4'h5) begin
        int_dat_o = wb_dat_i[47:40];
    end
    else if (int_sel == 4'h6) begin
        int_dat_o = wb_dat_i[55:48];
    end
    else if (int_sel == 4'h7) begin
        int_dat_o = wb_dat_i[63:56];
    end
    else if (int_sel == 4'h8) begin
        int_dat_o = wb_dat_i[71:64];
    end
    else if (int_sel == 4'h9) begin
        int_dat_o = wb_dat_i[79:72];
    end
    else if (int_sel == 4'hA) begin
        int_dat_o = wb_dat_i[87:80];
    end
    else if (int_sel == 4'hB) begin
        int_dat_o = wb_dat_i[95:88];
    end
    else if (int_sel == 4'hC) begin
        int_dat_o = wb_dat_i[103:96];
    end
    else if (int_sel == 4'hD) begin
        int_dat_o = wb_dat_i[111:104];
    end
    else if (int_sel == 4'hE) begin
        int_dat_o = wb_dat_i[119:112];
    end
    else begin
        int_dat_o = wb_dat_i[127:120];
    end
end

endmodule

