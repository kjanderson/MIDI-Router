/**********************************************************************
 * shiftreg.v
 *
 * Description
 * This module implements a shift register to be compatible with a SPI
 * module operating in mode (CKP=0, CKE=0).
 * Data is output on SCK rising edge and sampled on the SCK falling edge.
 *
 * Notes
 * yosys is not able to synthesize the bhv_sr with a ld input.
 * since this was not needed for the simplified design, I commented it out for now.
 *
 * Verification level
 * This was simulated using ModelSim
 *********************************************************************/
module spislave(
    clk,
    sck,
    sdi,
    sdo,
    ss,
    data_i,
    data_o,
    ld,
    rdy
);

parameter DATA_WIDTH = 8;

input  wire       clk;
input  wire       sck;
input  wire       sdi;
output wire       sdo;
input  wire       ss;
input  wire [DATA_WIDTH-1:0] data_i;
output wire [DATA_WIDTH-1:0] data_o;
input  wire       ld;
output wire       rdy;

reg int_ss;
reg [DATA_WIDTH-1:0] int_sr;
reg int_sdo;
wire ss_rising;
reg int_rdy;
wire ff_rst;

assign sdo = int_sdo;
assign data_o = int_sr;
assign ss_rising = (ss == 1) && (int_ss == 0);
assign rdy = int_rdy;
assign ff_rst = (ld == 1) && (ss == 1);

always @(posedge clk)
begin: bhv_ss
    int_ss <= ss;
end

/* data output during clk rising edge */
/* set sdo to the MSb of input data on parallel load */
always @(posedge sck, posedge ff_rst)
begin: bhv_sdo
    if (ff_rst == 1) begin
        int_sdo <= data_i[DATA_WIDTH-1];
    end
    else begin
        if (ss == 0) begin
            int_sdo <= int_sr[DATA_WIDTH-1];
        end
    end
end

/* data sampled during clk falling edge */
always @(negedge sck, posedge ff_rst)
begin: bhv_sr
    if (ff_rst == 1) begin
        int_sr <= data_i;
    end
    else begin
        if (ss == 0) begin
            int_sr <= {int_sr[DATA_WIDTH-2:0], sdi};
        end
    end
end

/*
always @(negedge sck)
begin: bhv_sr
    if (ss == 0) begin
        int_sr <= {int_sr[DATA_WIDTH-2:0], sdi};
    end
end
*/

always @(posedge clk)
begin: bhv_rdy
    if (ss_rising) begin
        int_rdy <= 1;
    end
    else if (int_rdy == 1) begin
        int_rdy <= 0;
    end
end

endmodule

