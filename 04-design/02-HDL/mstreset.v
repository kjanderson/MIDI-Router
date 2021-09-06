/**********************************************************************
 * mstreset
 *
 * Description
 * This module generates a master reset signal used to reset other modules.
 *********************************************************************/
module mstreset(
    reset,
    clk
);

output wire reset;
input  wire clk;

/* internal signals */
reg [1:0] int_sr;

/* reduce bits and invert */
assign reset = (^ int_sr);

/* implement a shift register to help the simulation along */
always @ (posedge clk)
begin
    int_sr <= {int_sr[0], 1'b1};
end

endmodule
