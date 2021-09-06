module spi_fsm(
    clk,
    spi_rdy_i,
    timeout_i,
    cmd_i,
    wb_ack_i,
    spi_ld_o,
    addr_o,
    cmd_o,
    wb_we_o,
    wb_stb_o,
    wb_data_o,
    spi_data_o
);

input  wire clk;
input  wire spi_rdy_i;
input  wire timeout_i;
input  wire cmd_i;
input  wire wb_ack_i;
output wire spi_ld_o;
output wire [6:0] addr_o;
output wire cmd_o;
output wire wb_we_o;
output wire wb_stb_o;
output wire [7:0] wb_data_o;
output wire [7:0] spi_data_o;

reg [2:0] int_curr_state;
reg [2:0] int_next_state;
reg int_spi_ld;
reg [6:0] int_addr;
reg int_cmd;
reg int_wb_we_o;
reg int_wb_stb_o;
reg [7:0] int_data;
reg [7:0] int_spi_data_o;

assign spi_ld_o = int_spi_ld;
assign addr_o = int_addr;
assign cmd_o = int_cmd;
assign wb_we_o = int_wb_we_o;
assign wb_stb_o = int_wb_stb_o;
assign wb_data_o = int_data;
assign spi_data_o = int_spi_data_o;

always @(int_curr_state, int_spi_rdy, int_timeout, int_cmd, wb_ack_i)
begin: sm_cl
    case(int_curr_state)
    ST_IDLE: begin
        if (int_spi_rdy == 1) begin
            int_next_state = ST_LAT_CMD;
        end
        else begin
            int_next_state = ST_IDLE;
        end
    end
    ST_LAT_CMD: begin
        int_next_state = ST_CMD;
    end
    ST_CMD: begin
        if (int_timeout == 1) begin
            int_next_state = ST_IDLE;
        end
        else begin
            if (int_cmd == 1) begin
                int_next_state = ST_WR_DATA;
            end
            else begin
                int_next_state = ST_RD_PREP;
            end
        end
    end
    ST_WR_DATA: begin
        if (int_timeout == 1) begin
            int_next_state = ST_IDLE;
        end
        else begin
            if (int_spi_rdy == 1) begin
                int_next_state = ST_WR_PREP;
            end
            else begin
                int_next_state = ST_WR_DATA;
            end
        end
    end
    ST_WR_PREP: begin
        int_next_state = ST_WR_EXE;
    end
    ST_WR_EXE: begin
        if (int_timeout == 1) begin
            int_next_state = ST_IDLE;
        end
        else begin
            if (wb_ack_i == 1) begin
                int_next_state = ST_CLR;
            end
            else begin
                int_next_state = ST_WR_EXE;
            end
        end
    end
    ST_RD_PREP: begin
        int_next_state = ST_RD_EXE;
    end
    ST_RD_EXE: begin
        if (int_timeout == 1) begin
            int_next_state = ST_IDLE;
        end
        else begin
            if (wb_ack_i == 1) begin
                int_next_state = ST_RD_LOAD;
            end
            else begin
                int_next_state = ST_RD_EXE;
            end
        end
    end
    ST_RD_LOAD: begin
        int_next_state = ST_RD_DATA;
    end
    ST_RD_DATA: begin
        if (int_timeout == 1) begin
            int_next_state = ST_IDLE;
        end
        else begin
            if (int_spi_rdy == 1) begin
                int_next_state = ST_CLR;
            end
            else begin
                int_next_state = ST_RD_DATA;
            end
        end
    end
    ST_CLR: begin
        int_next_state = ST_IDLE;
    end
    default: begin
        int_next_state = ST_IDLE;
    end
    endcase
end

always @(posedge clk)
begin: bhv_sm_sl
    int_curr_state <= int_next_state;
end

/* outputs controlled in this block:
 *   spi_ld
 *   int_addr
 *   int_cmd
 *   int_wb_we_o
 *   int_wb_stb_o
 *   int_spi_xchg_ack
 *   int_data
 */
always @(posedge clk)
begin: bhv_sm_op
    case(int_curr_state)
    ST_IDLE: begin
        int_spi_ld <= 0;
        int_addr <= 7'h00;
        int_wb_we_o <= 0;
        int_cmd <= 0;
    end
    ST_LAT_CMD: begin
        int_cmd <= int_spi_data_o[7];
        int_addr <= int_spi_data_o[6:0];
    end
    ST_WR_PREP: begin
        int_wb_stb_o <= 1;
        int_wb_we_o <= 1;
        int_data <= int_spi_data_o;
    end
    ST_RD_PREP: begin
        int_wb_stb_o <= 1;
        int_wb_we_o <= 0;
    end
    ST_RD_LOAD: begin
        int_wb_stb_o <= 0;
        int_wb_we_o <= 0;
        int_spi_ld <= 1;
        int_spi_data_o <= wb_dat_i;
    end
    ST_RD_DATA: begin
        int_spi_ld <= 0;
    end
    ST_CLR: begin
        int_wb_stb_o <= 0;
        int_wb_we_o <= 0;
    end
    endcase
end

endmodule
