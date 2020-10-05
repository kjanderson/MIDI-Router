/**********************************************************************
 * synchronizer
 *
 * Author: Korwin Anderson
 * Date: February 16, 2020
 * Version: 1.0
 *
 * Description
 * This module implements a synchronizer to synchronize external inputs
 * to the primary system clock.
 *********************************************************************/
module synchronizer(
    clk,
    a_in,
    y_out
);

input  wire clk;
input  wire a_in;
output wire y_out;

/* internal signals */
reg [1:0] _sr;

/* continuous assignment */
assign y_out = _sr[1];

/* behavioral model */
always @(posedge clk)
begin: bhv_yout
    _sr <= {_sr[0], a_in};
end

endmodule
