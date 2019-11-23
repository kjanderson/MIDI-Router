/**********************************************************************
 * mstreset
 *
 * Description
 * This module generates a master reset signal used to reset other modules.
 *********************************************************************/
module mstreset(
    reset_n,
    clk
);

output reset_n;
input clk;

wire reset_n;
wire clk;

/* internal signals */
reg [1:0] _sr;

/* reduce bits and invert */
assign reset_n = !(& _sr);

/* implement a shift register to help the simulation along */
always @ (posedge clk)
begin
    _sr <= {_sr[0], 1};
end

endmodule
