module spi_ctrl_fsm(
    reset,
    clk,
    spi_rdy_i,
    timeout_i,
    cmd_i,
    wb_ack_i,
    spi_ld_o,
    ctl_spi_addr_o,
    ctl_spi_rd_o,
    ctl_wb_wr_o,
);

input  wire reset;
input  wire clk;
input  wire spi_rdy_i;
input  wire timeout_i;
input  wire cmd_i;
input  wire wb_ack_i;
//input  wire [7:0] spi_data_i;
output reg  spi_ld_o;
//output reg wb_we_o;
//output reg wb_stb_o;
output reg ctl_spi_addr_o;
output reg ctl_spi_rd_o;
output reg ctl_wb_wr_o;

parameter ST_IDLE    = 4'h0;
parameter ST_LAT_CMD = 4'h1;
parameter ST_CMD     = 4'h2;
parameter ST_WR_DATA = 4'h3;
parameter ST_WR_PREP = 4'h4;
parameter ST_WR_EXE  = 4'h5;
parameter ST_RD_PREP = 4'h6;
parameter ST_RD_EXE  = 4'h7;
parameter ST_RD_LOAD = 4'h8;
parameter ST_RD_DATA = 4'h9;
parameter ST_CLR     = 4'hA;

reg [3:0] int_curr_state;
reg [3:0] int_next_state;

always @(int_curr_state or cmd_i or spi_rdy_i or wb_ack_i)
begin: sm_cl
    case(int_curr_state)
    ST_IDLE: begin
        int_next_state = ST_IDLE;
        if (spi_rdy_i == 1'b1) begin
            int_next_state = ST_LAT_CMD;
        end
    end
    ST_LAT_CMD: begin
        int_next_state = ST_CMD;
    end
    ST_CMD: begin
        int_next_state = ST_RD_DATA;
        if (cmd_i == 1'b1) begin
            int_next_state = ST_WR_EXE;
        end
    end
    ST_WR_DATA: begin
        int_next_state = ST_WR_DATA;
        if (spi_rdy_i == 1'b1) begin
            int_next_state = ST_WR_PREP;
        end
    end
    ST_WR_PREP: begin
        int_next_state = ST_WR_EXE;
    end
    ST_WR_EXE: begin
        int_next_state =  ST_WR_EXE;
        if (wb_ack_i == 1'b1) begin
            int_next_state = ST_CLR;
        end
    end
    ST_RD_DATA: begin
        int_next_state = ST_CLR;
    end
/*
    ST_RD_PREP: begin
        int_next_state = ST_RD_EXE;
    end
    ST_RD_EXE: begin
        int_next_state = ST_RD_LOAD;
    end
    ST_RD_LOAD: begin
        int_next_state = ST_RD_DATA;
    end
 */
    ST_CLR: begin
        int_next_state = ST_IDLE;
    end
    default: begin
        int_next_state = ST_IDLE;
    end
    endcase
end
/*
always @(int_curr_state, spi_rdy_i, timeout_i, cmd_i, wb_ack_i)
begin: sm_cl
    case(int_curr_state)
    ST_IDLE: begin
        if (spi_rdy_i == 1) begin
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
        if (timeout_i == 1) begin
            int_next_state = ST_IDLE;
        end
        else begin
            if (cmd_i == 1) begin
                int_next_state = ST_WR_DATA;
            end
            else begin
                int_next_state = ST_RD_PREP;
            end
        end
    end
    ST_WR_DATA: begin
        if (timeout_i == 1) begin
            int_next_state = ST_IDLE;
        end
        else begin
            if (spi_rdy_i == 1) begin
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
        if (timeout_i == 1) begin
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
        if (timeout_i == 1) begin
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
        if (timeout_i == 1) begin
            int_next_state = ST_IDLE;
        end
        else begin
            if (spi_rdy_i == 1) begin
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
*/

always @(posedge clk)
begin: bhv_sm_sl
    if (reset == 1'b1) begin
        int_curr_state <= ST_IDLE;
    end
    else begin
        int_curr_state <= int_next_state;
    end
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
    if (reset == 1'b1) begin
        ctl_spi_addr_o <= 1'b0;
        ctl_spi_rd_o <= 1'b0;
        ctl_wb_wr_o <= 1'b0;
        spi_ld_o <= 1'b0;
    end
    else begin
        case(int_curr_state)
        ST_IDLE: begin
            ctl_spi_addr_o <= 1'b0;
            ctl_spi_rd_o <= 1'b0;
            ctl_wb_wr_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        ST_LAT_CMD: begin
            ctl_spi_addr_o <= 1'b1;
            ctl_spi_rd_o <= 1'b0;
            ctl_wb_wr_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        ST_CMD: begin
            ctl_spi_addr_o <= 1'b0;
            ctl_spi_rd_o <= 1'b0;
            ctl_wb_wr_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        ST_WR_DATA: begin
            ctl_spi_addr_o <= 1'b0;
            ctl_spi_rd_o <= 1'b0;
            ctl_wb_wr_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        ST_WR_PREP: begin
            ctl_wb_wr_o <= 1'b1;
            ctl_spi_rd_o <= 1'b0;
            ctl_spi_addr_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        ST_WR_EXE: begin
            ctl_wb_wr_o <= 1'b0;
            ctl_spi_addr_o <= 1'b0;
            ctl_spi_rd_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        ST_RD_DATA: begin
            ctl_spi_rd_o <= 1'b0;
            ctl_spi_addr_o <= 1'b0;
            ctl_wb_wr_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        ST_CLR: begin
            ctl_wb_wr_o <= 1'b0;
            ctl_spi_rd_o <= 1'b0;
            ctl_spi_addr_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        default: begin
            ctl_spi_addr_o <= 1'b0;
            ctl_spi_rd_o <= 1'b0;
            ctl_wb_wr_o <= 1'b0;
            spi_ld_o <= 1'b0;
        end
        endcase
    end
end
/*
always @(posedge clk)
begin: bhv_sm_op
    case(int_curr_state)
    ST_IDLE: begin
        spi_ld_o <= 0;
        addr_o <= 7'h00;
        wb_we_o <= 0;
        cmd_o <= 0;
        ctl_wb_wr_o <= 0;
        ctl_spi_rd_o <= 0;
    end
    ST_LAT_CMD: begin
        cmd_o <= spi_data_i[7];
        addr_o <= spi_data_i[6:0];
        ctl_wb_wr_o <= 0;
        ctl_spi_rd_o <= 0;
    end
    ST_CMD: begin
    end
    ST_WR_DATA: begin
    end
    ST_WR_PREP: begin
        wb_stb_o <= 1;
        wb_we_o <= 1;
        //int_data <= int_spi_data_o;
        ctl_wb_wr_o <= 1;
        ctl_spi_rd_o <= 0;
    end
    ST_WR_EXE: begin
    end
    ST_RD_PREP: begin
        wb_stb_o <= 1;
        wb_we_o <= 0;
        ctl_wb_wr_o <= 0;
        ctl_spi_rd_o <= 0;
    end
    ST_RD_EXE: begin
    end
    ST_RD_LOAD: begin
        wb_stb_o <= 0;
        wb_we_o <= 0;
        spi_ld_o <= 1;
        ctl_spi_rd_o <= 1;
        //int_spi_data_i <= wb_dat_i;
        ctl_wb_wr_o <= 0;
    end
    ST_RD_DATA: begin
        spi_ld_o <= 0;
        ctl_wb_wr_o <= 0;
        ctl_spi_rd_o <= 0;
    end
    ST_CLR: begin
        wb_stb_o <= 0;
        wb_we_o <= 0;
        ctl_wb_wr_o <= 0;
        ctl_spi_rd_o <= 0;
    end
    default: begin
    end
    endcase
end
 */

endmodule