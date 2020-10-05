module bus_master(
    reset,
    clk,
    addr,
    data,
    irq,
    fifo_data,
    fifo_wr,
    bus_rd
);

input  wire reset;
input  wire clk;
output wire [3:0] addr;
input  wire [7:0] data;
input  wire [3:0] irq;
output wire [7:0] fifo_data;
output wire fifo_wr;
output wire [3:0] bus_rd;

reg [3:0] _bus_rd;
reg [7:0] _fifo_data;
reg _fifo_wr;
reg _addr[3:0];

assign addr = _addr;
assign fifo_data = _fifo_data;
assign fifo_wr = _fifo_wr;
assign bus_rd = _bus_rd;

always @(posedge clk, posedge reset)
begin: bhv_bus_rd
    if (reset == 1'b1) begin
        _bus_rd <= 4'h0;
        _addr <= 4'h0;
    end
    else begin
        if (irq[0] == 1'b1) begin
            _addr <= 4'h0;
            _bus_rd[0] <= 1'b1;
            _bus_rd[1] <= 1'b0;
            _bus_rd[2] <= 1'b0;
            _bus_rd[3] <= 1'b0;
        end
        else if (irq[1] == 1'b1) begin
            _addr <= 4'h1;
            _bus_rd[0] <= 1'b0;
            _bus_rd[1] <= 1'b1;
            _bus_rd[2] <= 1'b0;
            _bus_rd[3] <= 1'b0;
        end
        else if (irq[2] == 1'b1) begin
            _addr <= 4'h2;
            _bus_rd[0] <= 1'b0;
            _bus_rd[1] <= 1'b0;
            _bus_rd[2] <= 1'b1;
            _bus_rd[3] <= 1'b0;
        end
        else if (irq[3] == 1'b1) begin
            _addr <= 4'h3;
            _bus_rd[0] <= 1'b0;
            _bus_rd[1] <= 1'b0;
            _bus_rd[2] <= 1'b0;
            _bus_rd[3] <= 1'b1;
        end
    end
end

always @(posedge clk, posedge reset)
begin: bhv_fifo_data
    if (reset == 1'b1) begin
        _fifo_data <= 8'h00;
        _fifo_wr <= 1'b0;
    end
    else begin
        if (irq > 0) begin
            _fifo_data <= data;
            _fifo_wr <= 1'b1;
        end
        else begin
            _fifo_wr <= 1'b0;
        end
    end
end

endmodule
