/* use ping pong buffer to dump data received from the UART into each buffer.
 * The external controller will read data_rdy and request to read the data.
 *
 */

module midi_rx(
    rst,
    clk,
    midi_in,
    midi_data,
    midi_data_rdy,
    midi_data_rd
);

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

input  wire       rst;
input  wire       clk;
input  wire       midi_in;
output wire [7:0] midi_data;
output wire       midi_data_rdy;
input  wire       midi_data_rd;

/* internal signals */
wire int_uart_data_rdy;
wire [7:0] int_uart_data;
wire [7:0] int_fifo_data;
wire int_fifo_empty_n;
wire int_fifo_full_n;

reg int_fifo_wr;
reg int_midi_data_rdy;

reg int_curr_state;
reg int_next_state;
reg int_rdy_curr_state;
reg int_rdy_next_state;

assign midi_data = int_fifo_data;
/* signal that the message is ready when a new status byte comes in */
assign midi_data_rdy = int_midi_data_rdy;

/**********************************************************************
 * state machine combinational logic
 *********************************************************************/
always @(int_curr_state, int_uart_data_rdy)
begin: bhv_sm_cl
    case(int_curr_state)
    STATE_IDLE: begin
        if (int_uart_data_rdy == 1'b1) begin
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
always @(posedge clk, posedge rst)
begin: bhv_sm_sl
    if (rst == 1'b1) begin
        int_curr_state <= STATE_IDLE;
    end
    else begin
        int_curr_state <= int_next_state;
    end
end

/**********************************************************************
 * state machine outputs
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_sm_op
    if (rst == 1'b1) begin
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

/**********************************************************************
 * data ready state machine combinational logic
 *********************************************************************/
always @(int_rdy_curr_state, int_fifo_wr, int_fifo_empty_n)
begin: bhv_sm_rdy_cl
    case(int_rdy_curr_state)
    STATE_IDLE: begin
        if ((int_fifo_wr == 1'b1) && (get_status(int_uart_data) > 0)) begin
            int_rdy_next_state = STATE_RDY;
        end
        else begin
            int_rdy_next_state = STATE_IDLE;
        end
    end
    STATE_RDY: begin
        if (int_fifo_empty_n == 1'b0) begin
            int_rdy_next_state = STATE_IDLE;
        end
        else begin
            int_rdy_next_state = STATE_RDY;
        end
    end
    default: begin
        int_rdy_next_state = STATE_IDLE;
    end
    endcase
end

/**********************************************************************
 * data ready state machine sequential logic
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_sm_rdy_sl
    if (rst == 1'b1) begin
        int_rdy_curr_state <= STATE_IDLE;
    end
    else begin
        int_rdy_curr_state <= int_rdy_next_state;
    end
end

/**********************************************************************
 * data ready state machine output logic
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_sm_rdy_op
    if (rst == 1'b1) begin
    end
    else begin
        case(int_rdy_curr_state)
        STATE_IDLE: begin
            int_midi_data_rdy <= 1'b0;
        end
        STATE_RDY: begin
            int_midi_data_rdy <= 1'b1;
        end
        default: begin
            int_midi_data_rdy <= 1'b0;
        end
        endcase
    end
end

uart_rx r0(
    .reset(rst),
    .clk(clk),
    .uart_in(midi_in),
    .uart_data(int_uart_data),
    .uart_data_rdy(int_uart_data_rdy)
);

fifo f0(
    .reset(rst),
    .clk(clk),
    .rd(midi_data_rd & int_fifo_empty_n),
    .wr(int_fifo_wr),
    .data_i(int_uart_data),
    .data_o(int_fifo_data),
    .empty_n(int_fifo_empty_n),
    .full_n(int_fifo_full_n)
);

endmodule
