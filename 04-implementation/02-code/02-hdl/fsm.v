/**********************************************************************
 * fsm.v
 *
 * Description
 * This module implements a state machine to test startup and outputs.
 *
 * History
 * Revision    Notes
 * --------    -----
 * 1.0         Initial version
 *********************************************************************/
module fsm(
    reset_n,
    clk,
    status
);

`define STATE_RESET 2'h0
`define STATE_IDLE  2'h1
`define STATE_SET   2'h2
`define STATE_RESET 2'h3

input reset_n;
input clk;
output [1:0] status;

wire reset_n;
wire clk;
wire [1:0] status;

/* internal signals */
reg [1:0] _state;
reg [1:0] _status;

assign status = _status;

always @ (posedge clk, negedge reset_n)
begin
    if (reset_n == 0)
    begin
        _state <= `STATE_IDLE;
        _status <= 0;
    end
    else
    begin
        case(_state)
        `STATE_IDLE:
        begin
            _state <= `STATE_SET;
            _status <= 2'h0;
        end
        `STATE_SET:
        begin
            _state <= `STATE_RESET;
            _status <= 2'h1;
        end
        `STATE_RESET:
        begin
            _state <= `STATE_SET;
            _states <= 2'h2;
        end
        endcase
    end
end

endmodule
