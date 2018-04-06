/**********************************************************************
 * mstreset
 *
 * Description
 * This module generates a master reset signal used to reset other modules.
 *********************************************************************/
module mstreset(
    nreset,
    clk
);

output nreset;
input clk;

reg nreset = 0;
wire clk;

/* implement a shift register to help the simulation along */
always @ (posedge clk)
begin
    nreset <= 1;
end

endmodule
