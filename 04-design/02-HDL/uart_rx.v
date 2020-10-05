module uart_rx(
    reset,
    clk,
    uart_in,
    uart_data,
    uart_data_rdy
);

parameter PERIF_ADDR = 4'h0;

`define UART_STATE_IDLE   2'h0
`define UART_STATE_START  2'h1
`define UART_STATE_DATA   2'h2
`define UART_STATE_STOP   2'h3
`define UART_SAMP_INDEX   3'h6
`define UART_BIT_LEN      3'h7

input        clk;
input        reset;
input        uart_in;
output [7:0] uart_data;
output       uart_data_rdy;

/* internal signals */
reg [1:0] _uart_state;
reg [1:0] _uart_next_state;
reg [2:0] _uart_bit_cnt;
reg [2:0] _uart_samp_cnt;
reg [7:0] _uart_sr;
reg [7:0] _uart_reg;
reg _uart_data_rdy;
reg [2:0] _samp;
wire _uart_vote;
reg _z_uart_in;

/* define sample voting */
assign _uart_vote = ((_samp[0] ^ _samp[1]) & _samp[2]) | (_samp[0] & _samp[1]);
assign uart_data = _uart_reg;
assign uart_data_rdy = _uart_data_rdy;

always @(posedge clk)
begin: bhv_uart_in
    _z_uart_in <= uart_in;
end

/* bhv_state: UART actively shifting or idle */
always @(_uart_state, uart_in, _z_uart_in, _uart_samp_cnt, _uart_vote, _uart_bit_cnt)
begin: bhv_cl_state
    if (_uart_state == `UART_STATE_IDLE) begin
        /* watch for falling edge on uart_in */
        if ((uart_in == 1'b0) && (_z_uart_in == 1'b1)) begin
            _uart_next_state = `UART_STATE_START;
        end
        else begin
            _uart_next_state = `UART_STATE_IDLE;
        end
    end
    else if (_uart_state == `UART_STATE_START) begin
        if (_uart_samp_cnt == `UART_SAMP_INDEX) begin
            if (_uart_vote == 1'b0) begin
                _uart_next_state = `UART_STATE_DATA;
            end
            else begin
                _uart_next_state = `UART_STATE_IDLE;
            end
        end
        else begin
            _uart_next_state = `UART_STATE_START;
        end
    end
    else if (_uart_state == `UART_STATE_DATA) begin
        if (_uart_bit_cnt == `UART_BIT_LEN) begin
            if (_uart_samp_cnt == `UART_SAMP_INDEX) begin
                _uart_next_state = `UART_STATE_STOP;
            end
            else begin
                _uart_next_state = `UART_STATE_DATA;
            end
        end
        else begin
            _uart_next_state = `UART_STATE_DATA;
        end
    end
    else if (_uart_state == `UART_STATE_STOP) begin
        if (_uart_samp_cnt == `UART_SAMP_INDEX) begin
            _uart_next_state = `UART_STATE_IDLE;
        end
        else begin
            _uart_next_state = `UART_STATE_STOP;
        end
    end
    else begin
        _uart_next_state = `UART_STATE_IDLE;
    end
end

/* sequential logic portion of state machine */
always @(posedge clk, posedge reset)
begin: bhv_seq_state
    if (reset == 1'b1) begin
        _uart_state <= `UART_STATE_IDLE;
    end
    else begin
        _uart_state <= _uart_next_state;
    end
end

/* state machine doesn't have outputs */

always @(posedge clk, posedge reset)
begin: bhv_samp_cnt
    if (reset == 1'b1) begin
        _uart_samp_cnt <= 2'h0;
    end
    else begin
        if (_uart_state != `UART_STATE_IDLE) begin
            _uart_samp_cnt <= _uart_samp_cnt + 2'h1;
        end
        else begin
            _uart_samp_cnt <= 2'h0;
        end
    end
end

always @(posedge clk, posedge reset)
begin: bhv_bit_cnt
    if (reset == 1'b1) begin
        _uart_bit_cnt <= 3'h0;
    end
    else begin
        if (_uart_state == `UART_STATE_DATA) begin
            if (_uart_samp_cnt == `UART_SAMP_INDEX) begin
                _uart_bit_cnt <= _uart_bit_cnt + 3'h1;
            end
        end
    end
end

always @(posedge clk, posedge reset)
begin: bhv_samp
    if (reset == 1'b1) begin
        _samp <= 3'h0;
    end
    else begin
        if (_uart_state != `UART_STATE_IDLE) begin
            if (_uart_samp_cnt == `UART_SAMP_INDEX-3'h3) begin
                _samp[0] <= uart_in;
            end
            else if (_uart_samp_cnt == `UART_SAMP_INDEX-3'h2) begin
                _samp[1] <= uart_in;
            end
            else if (_uart_samp_cnt == `UART_SAMP_INDEX-3'h1) begin
                _samp[2] <= uart_in;
            end
        end
    end
end

always @(posedge clk, posedge reset)
begin: bhv_uart_sr
    if (reset == 1'b1) begin
        _uart_sr <= 8'h00;
    end
    else begin
        if (_uart_state == `UART_STATE_DATA) begin
            if (_uart_samp_cnt == `UART_SAMP_INDEX) begin
                _uart_sr <= {_uart_vote, _uart_sr[7:1]};
            end
        end
    end
end

always @(posedge clk, posedge reset)
begin: bhv_uart_data_rdy
    if (reset == 1'b1) begin
        _uart_data_rdy <= 1'b0;
    end
    else begin
        if (_uart_state == `UART_STATE_STOP) begin
            if (_uart_samp_cnt == `UART_SAMP_INDEX) begin
                _uart_data_rdy <= 1'b1;
            end
        end
        else if (_uart_state == `UART_STATE_IDLE) begin
            _uart_data_rdy <= 1'b0;
        end
    end
end

/* duplicate logic from uart_data_rdy block
 * so both signals are ready at the same time. */
always @(posedge clk, posedge reset)
begin: bhv_uart_reg
    if (reset == 1'b1) begin
        _uart_reg <= 8'h00;
    end
    else begin
        if (_uart_state == `UART_STATE_STOP) begin
            if (_uart_samp_cnt == `UART_SAMP_INDEX) begin
                _uart_reg <= _uart_sr;
            end
        end
    end
end

endmodule
