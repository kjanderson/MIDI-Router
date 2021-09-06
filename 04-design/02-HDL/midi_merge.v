module midi_merge(
    rst,
    clk,
    wb_addr,
    wb_dat_i,
    wb_dat_o,
    wb_we_o,
    wb_stb_o,
    wb_ack_i
);

parameter ST_RDBM_0 = 0;
parameter ST_EVRT_0 = 1;
parameter ST_CPRT_0 = 2;
parameter ST_RDST_0 = 3;
parameter ST_CPB0_0 = 4;
parameter ST_CPB1_0 = 5;
parameter ST_WRBM_0 = 6;
parameter ST_RDBM_1 = 70;
parameter ST_EVRT_1 = 81;
parameter ST_CPRT_1 = 92;
parameter ST_RDST_1 = 10;
parameter ST_CPB0_1 = 11;
parameter ST_CPB1_1 = 12;
parameter ST_WRBM_1 = 13;
parameter ST_RDBM_2 = 14;
parameter ST_EVRT_2 = 15;
parameter ST_CPRT_2 = 16;
parameter ST_RDST_2 = 17;
parameter ST_CPB0_2 = 18;
parameter ST_CPB1_2 = 19;
parameter ST_WRBM_2 = 20;
parameter ST_RDBM_3 = 21;
parameter ST_EVRT_3 = 22;
parameter ST_CPRT_3 = 23;
parameter ST_RDST_3 = 24;
parameter ST_CPB0_3 = 25;
parameter ST_CPB1_3 = 26;
parameter ST_WRBM_3 = 27;

input  wire rst;
input  wire clk;
output wire [7:0] wb_addr;
input  wire [7:0] wb_dat_i;
output wire [7:0] wb_dat_o;
output wire wb_we_o;
output wire wb_stb_o;
input  wire wb_ack_i;

/* internal signals */

assign wb_we_o = 1'b0;

reg [4:0] int_curr_state;
reg [4:0] int_next_state;

always @(int_curr_state)
begin
    case(int_curr_state)
    ST_RDBM_0: begin
        int_next_state <= ST_EVRT_0;
    end
    ST_EVRT_0: begin
        if (wb_ack_i == 1'b1) begin
            if (get_status(wb_dat_i)) begin
            end
            else begin
            end
        end
        else begin
        end
    end
    ST_CPRT_0: begin
    end
    ST_RDST_0: begin
    end
    ST_CPB0_0: begin
    end
    ST_CPB1_0: begin
    end
    ST_WRBM_0: begin
    end
    default: begin
    end
    endcase
end

always @(posedge clk)
begin
    if (rst == 1'b1) begin
        int_curr_state <= ST_RDBM_0;
    end
    else begin
        int_curr_state <= int_next_state;
    end
end

always @(posedge clk)
begin
    case(int_curr_state)
    endcase
end

endmodule
