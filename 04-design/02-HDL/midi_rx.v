module midi_rx(
    midi_in,
    wb_clk_i,
    wb_rst_i,
    wb_addr_i,
    wb_dat_i,
    wb_dat_o,
    wb_stb_i,
    wb_ack_o,
    wb_we_i
);

parameter BASE_ADDR = 8'h00;
parameter STATE_IDLE = 1'h0;
parameter STATE_READ = 1'h1;
parameter STATE_RDY  = 1'b1;

/* access function for status bit in MIDI message */
function get_status;
input [7:0] in_data;
begin
    get_status = in_data[7] == 1'b1;
end
endfunction

input  wire       midi_in;
input  wire       wb_clk_i;
input  wire       wb_rst_i;
input  wire [7:0] wb_addr_i;
input  wire [7:0] wb_dat_i;
output wire [7:0] wb_dat_o;
input  wire       wb_stb_i;
output wire       wb_ack_o;
input  wire       wb_we_i;

/* internal signals */
wire int_uart_data_rdy;
wire [7:0] int_uart_data;
wire [7:0] int_fifo_data;
wire int_fifo_empty_n;
wire int_fifo_full_n;

reg int_fifo_rd;
reg int_fifo_wr;
reg int_wb_ack_o;
reg [7:0] int_wb_dat_o;

reg int_curr_state;
reg int_next_state;

assign wb_dat_o = int_wb_dat_o;
assign wb_ack_o = int_wb_ack_o;

/**********************************************************************
 * wishbone interface
 *********************************************************************/
always @(posedge wb_stb_i)
begin: bhv_wb_dat_cl
    if (wb_addr_i == BASE_ADDR) begin
        int_wb_dat_o = int_fifo_empty_n;
    end
    else begin
        int_wb_dat_o = int_fifo_data;
    end
end

always @(posedge wb_stb_i)
begin: bhv_wb_rd_cl
    if (int_fifo_empty_n == 1) begin
        if (wb_addr_i != BASE_ADDR) begin
            int_fifo_rd = wb_stb_i & !wb_we_i;
        end
        else begin
            int_fifo_rd = 0;
        end
    end
    else begin
        int_fifo_rd = 0;
    end
end

always @(posedge wb_stb_i)
begin: bhv_wb_ack_cl
    int_wb_ack_o = wb_stb_i;
end

/**********************************************************************
 * state machine combinational logic
 *********************************************************************/
always @(int_curr_state, int_uart_data_rdy)
begin: bhv_sm_cl
    case(int_curr_state)
    STATE_IDLE: begin
        if (int_uart_data_rdy == 1) begin
            int_next_state = STATE_READ;
        end
        else begin
            int_next_state = STATE_IDLE;
        end
    end
    STATE_READ: begin
        /* write the received byte, then return to idle */
        int_next_state = STATE_IDLE;
    end
    default: begin
        int_next_state = STATE_IDLE;
    end
    endcase
end

/**********************************************************************
 * state machine sequential logic
 *********************************************************************/
always @(posedge wb_clk_i, posedge wb_rst_i)
begin: bhv_sm_sl
    if (wb_rst_i == 1'b1) begin
        int_curr_state <= STATE_IDLE;
    end
    else begin
        int_curr_state <= int_next_state;
    end
end

/**********************************************************************
 * state machine outputs
 *********************************************************************/
always @(posedge wb_clk_i, posedge wb_rst_i)
begin: bhv_sm_op
    if (wb_rst_i == 1'b1) begin
        int_fifo_wr <= 1'b0;
    end
    else begin
        case(int_curr_state)
        STATE_IDLE: begin
            int_fifo_wr <= 1'b0;
        end
        STATE_READ: begin
            int_fifo_wr <= 1'b1;
        end
        default: begin
            int_fifo_wr <= 1'b0;
        end
        endcase
    end
end

uart_rx r0(
    .reset(wb_rst_i),
    .clk(wb_clk_i),
    .uart_in(midi_in),
    .uart_data(int_uart_data),
    .uart_data_rdy(int_uart_data_rdy)
);

fifo f0(
    .reset(wb_rst_i),
    .clk(wb_clk_i),
    .rd(int_fifo_rd),
    .wr(int_fifo_wr),
    .data_i(int_uart_data),
    .data_o(int_fifo_data),
    .empty_n(int_fifo_empty_n),
    .full_n(int_fifo_full_n)
);

endmodule
