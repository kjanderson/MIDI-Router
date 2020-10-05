module fifo(
    reset,
    clk,
    rd,
    wr,
    data_i,
    data_o,
    empty_n,
    full_n
);

parameter ADDR_SIZE = 9;
parameter RAM_DEPTH = (1 << ADDR_SIZE);
parameter WIDTH = 8;

input  wire             reset;
input  wire             clk;
input  wire             rd;
input  wire             wr;
input  wire [WIDTH-1:0] data_i;
output wire [WIDTH-1:0] data_o;
output wire             empty_n;
output wire             full_n;

/* internal signals */
reg [ADDR_SIZE:0] rd_pointer;
reg [ADDR_SIZE:0] wr_pointer;
wire ram_re;
wire ram_we;

assign ram_re = 1'b1;
assign ram_we = 1'b1;

assign empty_n = !(rd_pointer == wr_pointer);
assign full_n =  !((rd_pointer[ADDR_SIZE] ^ wr_pointer[ADDR_SIZE]) &&
                   (rd_pointer[ADDR_SIZE-1:0] == wr_pointer[ADDR_SIZE-1:0]));

always @(posedge clk, posedge reset)
begin: bhv_rd_pointer
    if (reset == 1'b1) begin
        rd_pointer <= 0;
    end
    else begin
        if (rd == 1'b1) begin
            rd_pointer <= rd_pointer + 1;
        end
    end
end

always @(posedge clk, posedge reset)
begin: bhv_wr_pointer
    if (reset == 1'b1) begin
        wr_pointer <= 0;
    end
    else begin
        if (wr == 1'b1) begin
            wr_pointer <= wr_pointer + 1;
        end
    end
end

ram ram0(
    .wdata(data_i),
    .waddr(wr_pointer[ADDR_SIZE-1:0]),
    .we(ram_we),
    .wclk(!clk),
    .rdata(data_o),
    .raddr(rd_pointer[ADDR_SIZE-1:0]),
    .re(ram_re),
    .rclk(clk)
);

endmodule
