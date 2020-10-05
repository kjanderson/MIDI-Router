module shiftreg(
    reset,
    clk,
    data_i,
    ser_o,
    fifo_rd,
    fifo_empty_n
);

parameter ST_IDLE = 2'h0;
parameter ST_START = 2'h1;
parameter ST_DATA = 2'h2;
parameter ST_STOP = 2'h3;

input  wire reset;
input  wire clk;
input  wire [7:0] data_i;
output wire ser_o;
output wire fifo_rd;
input  wire fifo_empty_n;

reg [7:0] _data_reg;
reg [2:0] _cnt_prescale;

assign ser_o = _data_reg[_cnt];
assign fifo_rd = (_cnt == 0);

reg [2:0] _cnt;
reg [1:0] _curr_state;
reg [1:0] _next_state;
reg _cnt_prescale_en;

/**********************************************************************
 * UART TX state machine
 *********************************************************************/
always @(fifo_empty_n, _cnt_prescale, _cnt, _curr_state)
begin: bhv_tx_state_machine_cl
    case(_curr_state)
    ST_IDLE:
    begin
        if (fifo_empty_n == 1'b1) begin
            _cnt_prescale_en = 1'b1;
        end
        else begin
            _cnt_prescale_en = 1'b0;
        end
        if (_cnt_prescale == 3'h7) begin
            _next_state = ST_START;
        end
        else begin
            _next_state = ST_IDLE;
        end
    end
    ST_START:
    begin
        _cnt_prescale_en = 1'b1;
        if (_cnt_prescale == 3'h7) begin
            _next_state = ST_DATA;
        end
        else begin
            _next_state = ST_START;
        end
    end
    ST_DATA:
    begin
        _cnt_prescale_en = 1'b1;
        if ((_cnt_prescale == 3'h7) && (_cnt == 7)) begin
            _next_state = ST_STOP;
        end
        else begin
            _next_state = ST_DATA;
        end
    end
    ST_STOP:
    begin
        _cnt_prescale_en = 1'b1;
        if (_cnt == 7) begin
            _next_state = ST_IDLE;
        end
        else begin
            _next_state = ST_STOP;
        end
    end
    endcase
end

always @(posedge clk, posedge reset)
begin: bhv_tx_state_machine_sl
    if (reset == 1'b1) begin
        _curr_state <= ST_IDLE;
    end
    else begin
        _curr_state <= _next_state;
    end
end

always @(posedge clk, posedge reset)
begin: bhv_cnt_prescale
    if (reset == 1'b1) begin
        _cnt_prescale <= 0;
    end
    else begin
        _cnt_prescale <= _cnt_prescale + 1;
    end
end

always @(posedge clk, posedge reset)
begin: bhv_cnt
    if (reset == 1'b1) begin
        _cnt <= 0;
    end
    else begin
        if (_curr_state == ST_DATA) begin
            _cnt <= _cnt + 1;
        end
        else begin
            _cnt <= 0;
        end
    end
end

always @(posedge clk, posedge reset)
begin: bhv_data_reg
    if (reset == 1'b1) begin
        _data_reg <= 8'h00;
    end
    else begin
        _data_reg <= data_i;
    end
end

endmodule
