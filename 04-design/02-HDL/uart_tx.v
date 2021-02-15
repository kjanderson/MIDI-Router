/**********************************************************************
 * uart_tx.v
 *
 * Description
 * This file implements the uart_tx module.
 * This receives data on command and in turn shifts data out on the tx pin.
 *
 * TODO:
 *  1. figure out why the state machine doesn't return to IDLE when finished.
 *********************************************************************/

module uart_tx(
    rst,
    clk,
    tx_strobe,
    data,
    tx,
    busy
);

parameter STATE_IDLE =  2'h0;
parameter STATE_START = 2'h1;
parameter STATE_DATA =  2'h2;
parameter STATE_STOP =  2'h3;

input  wire rst;
input  wire clk;
input  wire tx_strobe;
input  [7:0] data;
output tx;
output busy;

reg [1:0] int_curr_state;
reg [1:0] int_next_state;
reg [2:0] int_cnt;
reg int_cnt_en;
reg [2:0] int_bit_cnt;
reg int_bit_cnt_en;
reg [7:0] int_uart_sr;
reg int_tx;

assign tx = int_tx;
assign busy = (int_curr_state != STATE_IDLE);

/**********************************************************************
 * state machine combinational logic
 *********************************************************************/
always @(int_curr_state, tx_strobe, int_cnt, int_bit_cnt)
begin: bhv_sm_cl
    case(int_curr_state)
    STATE_IDLE: begin
        if (tx_strobe == 1) begin
            int_next_state = STATE_START;
        end
        else begin
            int_next_state = STATE_IDLE;
        end
    end
    STATE_START: begin
        if ((& int_cnt) == 1) begin
            int_next_state = STATE_DATA;
        end
        else begin
            int_next_state = STATE_START;
        end
    end
    STATE_DATA: begin
        if (((& int_cnt) == 1) && ((& int_bit_cnt)== 1)) begin
            int_next_state = STATE_STOP;
        end
        else begin
            int_next_state = STATE_DATA;
        end
    end
    STATE_STOP: begin
        if ((& int_cnt) == 1) begin
            int_next_state = STATE_IDLE;
        end
        else begin
            int_next_state = STATE_STOP;
        end
    end
    default: begin
        int_next_state = STATE_IDLE;
    end
    endcase
end

/**********************************************************************
 * state machine combinational logic
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_sm_sl
    if (rst == 1) begin
        int_curr_state <= STATE_IDLE;
    end
    else begin
        int_curr_state <= int_next_state;
    end
end

/**********************************************************************
 * state machine combinational logic
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_sm_op
    if (rst == 1) begin
    end
    else begin
        case(int_curr_state)
        STATE_IDLE: begin
            int_cnt_en <= 0;
            int_bit_cnt_en <= 0;
        end
        STATE_START: begin
            int_cnt_en <= 1;
            int_bit_cnt_en <= 0;
        end
        STATE_DATA: begin
            int_cnt_en <= 1;
            int_bit_cnt_en <= 1;
        end
        STATE_STOP: begin
            int_cnt_en <= 1;
            int_bit_cnt_en <= 0;
        end
        default: begin
            int_cnt_en <= 0;
            int_bit_cnt_en <= 0;
        end
        endcase
    end
end

always @(posedge clk, posedge rst)
begin: bhv_cnt
    if (rst == 1) begin
        int_cnt <= 0;
    end
    else begin
        if (int_cnt_en == 1) begin
            int_cnt <= int_cnt + 1;
        end
    end
end

always @(posedge clk, posedge rst)
begin: bhv_bit_cnt
    if (rst == 1) begin
        int_bit_cnt <= 0;
    end
    else begin
        if (int_bit_cnt_en == 1) begin
            if ((& int_cnt) == 1) begin
                int_bit_cnt <= int_bit_cnt + 1;
            end
        end
    end
end

always @(posedge clk, posedge rst)
begin: bhv_uart_sr
    if (rst == 1) begin
        int_uart_sr <= 0;
    end
    else begin
        if ((int_bit_cnt_en == 1) && ((& int_cnt) == 1)) begin
            int_uart_sr <= {1'b0, int_uart_sr[7:1]};
        end
        else begin
            if (tx_strobe == 1) begin
                int_uart_sr <= data;
            end
        end
    end
end

always @(posedge clk, posedge rst)
begin: bhv_tx
    if (rst == 1) begin
        int_tx <= 1;
    end
    else begin
        if (int_curr_state == STATE_IDLE) begin
            int_tx <= 1;
        end
        else if (int_curr_state == STATE_START) begin
            int_tx <= 0;
        end
        else if (int_curr_state == STATE_STOP) begin
            int_tx <= 1;
        end
        else if (int_cnt_en && int_bit_cnt_en) begin
            int_tx <= int_uart_sr[0];
        end
    end
end

endmodule

