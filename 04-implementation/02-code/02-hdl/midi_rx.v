/**********************************************************************
 * midi_sync.v
 *
 * Description
 * This Verilog module implements an input UART receiver for the MIDI
 * input data.
 * Data is provided through a WishBone V3 bus interface.
 * Synchronization is performed through an irq/ack sequence.
 *
 * History
 * Revision Date       Notes
 * 0.0      2020-03-28 Initial version
 *
 * Notes
 * Voting logic uses boolean logic techniques to generate:
 *   vote = (A xor B) C + A B
 *********************************************************************/

module midi_rx(
    reset_n,
    clk,
    midi_in,
    irq,
    bus_clk,
    bus_rd,
    bus_dat
);

`define MIDI_STATE_IDLE   2'h00
`define MIDI_STATE_START  2'h01
`define MIDI_STATE_DATA   2'h02
`define MIDI_STATE_STOP   2'h03
`define MIDI_SAMP_INDEX   3'h6
`define MIDI_BIT_LEN      3'h7

input        clk;
input        reset_n;
input        midi_in;
output       irq;
input        bus_clk;
input        bus_rd;
output [7:0] bus_dat;

/* internal signals */
reg [1:0] _midi_state;
reg [1:0] _midi_next_state;
reg _irq;
reg [3:0] _midi_bit_cnt;
reg [2:0] _midi_samp_cnt;
reg [7:0] _midi_reg;
reg _uart_data_rdy;
reg [2:0] _samp;
wire _midi_vote;
reg _z_midi_in;

/* define sample voting */
assign _midi_vote = ((_samp[0] ^ _samp[1]) & _samp[2]) | (_samp[0] & _samp[1]);
assign irq = _irq;
assign bus_dat = _midi_reg;

always @(clk)
begin: bhv_midi_in
    _z_midi_in <= midi_in;
end

/* bhv_state: UART actively shifting or idle */
always @(_midi_state, midi_in, _midi_samp_cnt, _midi_bit_cnt)
begin: bhv_cl_state
    if (_midi_state == `MIDI_STATE_IDLE) begin
        /* watch for falling edge on midi_in */
        if ((midi_in == 1'b0) && (_z_midi_in == 1'b1)) begin
            _midi_next_state = `MIDI_STATE_START;
        end
    end
    else if (_midi_state == `MIDI_STATE_START) begin
        if (_midi_samp_cnt == `MIDI_SAMP_INDEX) begin
            if (_midi_vote == 1'b0) begin
                _midi_next_state = `MIDI_STATE_DATA;
            end
            else begin
                _midi_next_state = `MIDI_STATE_IDLE;
            end
        end
    end
    else if (_midi_state == `MIDI_STATE_DATA) begin
        if (_midi_bit_cnt == `MIDI_BIT_LEN) begin
            if (_midi_samp_cnt == `MIDI_SAMP_INDEX) begin
                _midi_next_state = `MIDI_STATE_STOP;
            end
        end
    end
    else if (_midi_state == `MIDI_STATE_STOP) begin
        if (_midi_samp_cnt == `MIDI_SAMP_INDEX) begin
            _midi_next_state = `MIDI_STATE_IDLE;
        end
    end
    else begin
        _midi_next_state = _midi_state;
    end
end

/* sequential logic portion of state machine */
always @(posedge clk)
begin: bhv_seq_state
    _midi_state <= _midi_next_state;
end

/* state machine doesn't have outputs */

always @(posedge clk)
begin: bhv_samp_cnt
    if (_midi_state != `MIDI_STATE_IDLE) begin
        _midi_samp_cnt <= _midi_samp_cnt + 2'h1;
    end
    else begin
        _midi_samp_cnt <= 2'h0;
    end
end

always @(posedge clk)
begin: bhv_bit_cnt
    if (_midi_samp_cnt == `MIDI_SAMP_INDEX) begin
        _midi_bit_cnt <= _midi_bit_cnt + 3'h1;
    end
    else begin
        _midi_bit_cnt <= _midi_bit_cnt;
    end
end

always @(posedge clk)
begin: bhv_samp
    if (_midi_state != `MIDI_STATE_IDLE) begin
        if (_midi_samp_cnt == `MIDI_SAMP_INDEX-3'h3) begin
            _samp[0] <= midi_in;
        end
        else if (_midi_samp_cnt == `MIDI_SAMP_INDEX-3'h2) begin
            _samp[1] <= midi_in;
        end
        else if (_midi_samp_cnt == `MIDI_SAMP_INDEX-3'h1) begin
            _samp[2] <= midi_in;
        end
        else begin
            _samp[0] <= _samp[0];
            _samp[1] <= _samp[1];
            _samp[2] <= _samp[2];
        end
    end
    else begin
        _samp[0] <= _samp[0];
        _samp[1] <= _samp[1];
        _samp[2] <= _samp[2];
    end
end

always @(posedge clk)
begin: bhv_midi_reg
    if (_midi_state == `MIDI_STATE_DATA) begin
        if (_midi_samp_cnt == `MIDI_SAMP_INDEX) begin
            _midi_reg <= {_midi_reg[6:0], _midi_vote};
        end
        else begin
            _midi_reg <= _midi_reg;
        end
    end
    else begin
        _midi_reg <= _midi_reg;
    end
end

always @(posedge clk)
begin: bhv_irq
    if (_uart_data_rdy == 1'b1) begin
        _irq <= 1'b1;
    end
    if (bus_rd == 1'b1) begin
        _irq <= 1'b0;
    end
end

always @(posedge clk)
begin: bhv_uart_data_rdy
    if (_midi_state == `MIDI_STATE_STOP) begin
        if (_midi_samp_cnt == `MIDI_SAMP_INDEX) begin
            _uart_data_rdy <= 1'b1;
        end
        else begin
            _uart_data_rdy <= _uart_data_rdy;
        end
    end
    else begin
        _uart_data_rdy <= 1'b0;
    end
end

endmodule
