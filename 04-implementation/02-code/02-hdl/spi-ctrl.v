/**********************************************************************
 * spi_ctrl
 *
 * Description
 * This Verilog module implements the memory-access controller for the
 * externally-facing SPI interface.
 *********************************************************************/
module spi_ctrl(
    spi_miso,
    spi_mosi,
    spi_sck,
    spi_ss,
    wb_clk_i,
    wb_rst_i,
    wb_adr_o,
    wb_dat_i,
    wb_dat_o,
    wb_we_o,
    wb_cs_o,
    wb_ack_i
);

parameter WB_ADR_SIZE = 8;
parameter WB_DAT_SIZE = 8;
parameter SPI_CTL_SIZE = 8;
parameter SPI_DAT_SIZE = 8;

`define SPI_ST_IDLE 3'h0
`define SPI_ST_CMD 3'h1
`define SPI_ST_ADR 3'h2
`define SPI_ST_DAT 3'h3

`define WB_ST_IDLE 3'h0

output wire spi_miso;
input wire spi_mosi;
input wire spi_sck;
input wire spi_ss;
input wire wb_clk_i;
input wire wb_rst_i;
output wire [WB_ADR_SIZE-1:0] wb_adr_o;
input wire [WB_DAT_SIZE-1:0] wb_dat_i;
output wire [WB_DAT_SIZE-1:0] wb_dat_o;
output wire wb_we_o;
output wire wb_cs_o;
input wire wb_ack_i;

/* internal signals */
wire [SPI_DAT_SIZE-1:0] _spi_reg;
wire _spi_reset_n;

/* internal memory elements */
reg _wb_we;
reg _wb_cs;
reg [WB_ADR_SIZE-1:0] _wb_adr;
reg [WB_DAT_SIZE-1:0] _spi_dat_lat;
reg [SPI_CTL_SIZE-1:0] _spi_cmd;
reg [2:0] _spi_state;
reg [2:0] _spi_next_state;
reg [2:0] _wb_state;
reg [2:0] _wb_next_state;

/* continuous assignments */
assign wb_adr_o = _wb_adr;
assign _spi_reset_n = !wb_rst_i;

/* SPI controller state machine */
/* TODO: need to generate a trigger at the end of each SPI transaction */
always @(posedge wb_clk_i) begin
    case(_spi_state)
        `SPI_ST_IDLE: begin
            _spi_next_state = `SPI_ST_CMD;
        end
        `SPI_ST_CMD: begin
            _spi_next_state = `SPI_ST_ADR;
        end
        `SPI_ST_ADR: begin
            _spi_next_state = `SPI_ST_DAT;
        end
        `SPI_ST_DAT: begin
            _spi_next_state = `SPI_ST_IDLE;
        end
        default: begin
            _spi_next_state = `SPI_ST_IDLE;
        end
    endcase
end

always @(posedge wb_clk_i) begin
    if (wb_rst_i == 1'b1) begin
        _spi_state <= `SPI_ST_IDLE;
    end
    else begin
        _spi_state <= _spi_next_state;
    end
end

/* WB state machine */
always @(posedge wb_clk_i) begin
    case(_wb_state)
        `WB_ST_IDLE: begin
        end
        default: begin
            _wb_next_state = `WB_ST_IDLE;
        end
    endcase
end

always @(posedge wb_clk_i) begin
    if (wb_rst_i == 1'b1) begin
        _wb_state <= `WB_ST_IDLE;
    end
    else begin
        _wb_state <= _wb_next_state;
    end
end

/* instantiate modules */
shiftreg s0(
    .nreset(_spi_reset_n),
    .clk(wb_clk_i),
    .spi_clk(spi_sck),
    .din(spi_mosi),
    .dout(spi_miso),
    .regout(_spi_reg)
);

endmodule

