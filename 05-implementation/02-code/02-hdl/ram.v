/**********************************************************************
 * ram.v
 *
 * Description
 * Instantiate a block RAM on the iCE40 device.
 *
 * History
 * Revision Date       Notes
 * 1.0      2020-05-25 Initial version
 *********************************************************************/

module ram(
    wdata,
    waddr,
    we,
    wclk,
    rdata,
    raddr,
    re,
    rclk
);

parameter ADDR_SIZE = 9;
parameter DATA_SIZE = 8;
parameter RAM_DEPTH = (1 << ADDR_SIZE);

input  wire [DATA_SIZE-1:0] wdata;
input  wire [ADDR_SIZE-1:0] waddr;
input  wire                 we;
input  wire                 wclk;
output wire [DATA_SIZE-1:0] rdata;
input  wire [ADDR_SIZE-1:0] raddr;
input  wire                 re;
input  wire                 rclk;

/* internal signals */
reg [DATA_SIZE-1:0] _mem_data [RAM_DEPTH-1:0];
reg [DATA_SIZE-1:0] _data_out;

assign rdata = _data_out;

always @(posedge wclk)
begin: bhv_data_write
    if (we == 1'b1) begin
        _mem_data[waddr] <= wdata;
    end
    /*
    else begin
        _mem_data[waddr] <= _mem_data[waddr];
    end
    */
end

always @(posedge rclk)
begin: bhv_data_read
    if (re == 1'b1) begin
        _data_out <= _mem_data[raddr];
    end
    /*
    else begin
        _data_out <= _data_out;
    end
    */
end

endmodule
