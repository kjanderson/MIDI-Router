/**********************************************************************
 * midi_tx.v
 *
 * Description
 * This module implements the output shift register for the MIDI outputs.
 * MIDI uses 8N1 mode for UART signaling.
 *
 * This watches for data made available on MIDI FIFOs, and copies data
 * to the local FIFO for transmission.
 *
 * TODO:
 *   look at the interaction between midi-tx and uart-tx. Make sure the
 *   read state machine begins correctly.
 *
 *   define logic to drive midi_data_rd.
 *********************************************************************/
module midi_tx(
    rst,
    clk,
    midi_data,
    midi_data_rdy,
    midi_data_rd,
    midi_tx
);

parameter STATE_WR_IDLE = 1'b0;
parameter STATE_WR_BUSY = 1'b1;
parameter STATE_RD_IDLE = 1'b0;
parameter STATE_RD_BUSY = 1'b1;

input  wire rst;
input  wire clk;
input  wire [7:0] midi_data[3:0];
input  wire [3:0] midi_data_rdy;
output wire [3:0] midi_data_rd;
output wire [3:0] midi_tx;

wire midi_data_rdy_any;
wire midi_data_rd_any;
wire [7:0] int_fifo_data;
reg int_fifo_rd;
reg [1:0] int_midi_channel;
reg int_wr_curr_state;
reg int_wr_next_state;
reg int_rd_curr_state;
reg int_rd_next_state;
wire uart_tx_busy;
reg int_uart_tx_strobe;

function decode;
    input [1:0] in;
    output [3:0] out;
    
    case(in)
    2'h0: begin
        decode = 4'h1;
    end
    2'h1: begin
        decode = 4'h2;
    end
    2'h2: begin
        decode = 4'h4;
    end
    2'h3: begin
        decode = 4'h8;
    end
    default: begin
        decode = 4'h0;
    end
    endcase;
endfunction

assign midi_data_rd = (int_wr_curr_state == STATE_WR_BUSY) ? decode(int_midi_channel) : 4'h0;
assign midi_data_rd_any = | midi_data_rd;
assign midi_data_rdy_any = | midi_data_rdy;

/**********************************************************************
 * FIFO write state machine combinational logic
 *********************************************************************/
always @(int_wr_curr_state, midi_data_rdy_any)
begin: bhv_fifo_wr_cl
    case(int_wr_curr_state)
    STATE_WR_IDLE: begin
        if (midi_data_rdy_any == 1) begin
            int_wr_next_state = STATE_WR_BUSY;
        end
        else begin
            int_wr_next_state = STATE_WR_IDLE;
        end
    end
    STATE_WR_BUSY: begin
        if (midi_data_rdy[int_midi_channel] == 1) begin
            int_wr_next_state = STATE_WR_BUSY;
        end
        else begin
            int_wr_next_state = STATE_WR_IDLE;
        end
    end
    default: begin
        int_wr_next_state = STATE_WR_IDLE;
    end
    endcase
end

/**********************************************************************
 * FIFO write state machine sequential logic
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_fifo_wr_sl
    if (rst == 1) begin
        int_wr_curr_state <= STATE_WR_IDLE;
    end
    else begin
        int_wr_curr_state <= int_wr_next_state;
    end
end

/**********************************************************************
 * FIFO write state machine output logic
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_fifo_wr_op
    if (rst == 1) begin
        int_midi_channel <= 0;
    end
    else begin
        case(int_wr_curr_state)
        STATE_WR_IDLE: begin
            if (midi_data_rdy[0] == 1) begin
                int_midi_channel <= 0;
            end
            else if (midi_data_rdy[1] == 1) begin
                int_midi_channel <= 1;
            end
            else if (midi_data_rdy[2] == 1) begin
                int_midi_channel <= 2;
            end
            else if (midi_data_rdy[3] == 1) begin
                int_midi_channel <= 3;
            end
        end
        STATE_WR_BUSY: begin
            int_midi_channel <= 0;
        end
        default: begin
            int_midi_channel <= 0;
        end
        endcase
    end
end

/**********************************************************************
 * FIFO read state machine combinational logic
 *********************************************************************/
always @(int_rd_curr_state, int_fifo_empty_n, int_uart_tx_busy)
begin: bhv_fifo_rd_cl
    case(int_rd_curr_state)
    STATE_RD_IDLE: begin
        if (int_fifo_empty_n == 0) begin
            int_rd_next_state = STATE_RD_BUSY;
        end
        else begin
            int_rd_next_state = STATE_RD_IDLE;
        end
    end
    STATE_RD_BUSY: begin
        if (int_uart_tx_busy == 0) begin
            int_rd_next_state = STATE_RD_IDLE;
        end
        else begin
            int_rd_next_state = STATE_RD_BUSY;
        end
    end
    default: begin
        int_rd_next_state = STATE_RD_IDLE;
    end
    endcase
end

/**********************************************************************
 * FIFO read state machine sequential logic
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_fifo_rd_sl
    if (rst == 1) begin
        int_rd_curr_state <= STATE_RD_IDLE;
    end
    else begin
        int_rd_curr_state <= int_rd_next_state;
    end
end

/**********************************************************************
 * FIFO read state machine output logic
 *********************************************************************/
always @(posedge clk, posedge rst)
begin: bhv_fifo_rd_op
    if (rst == 1) begin
        int_uart_tx_strobe <= 0;
    end
    else begin
        case(int_rd_curr_state)
        STATE_RD_IDLE: begin
            int_uart_tx_strobe <= 0;
        end
        STATE_RD_BUSY: begin
            int_uart_tx_strobe <= 1;
        end
        default: begin
            int_uart_tx_strobe <= 0;
        end
        endcase
    end
end

fifo f0(
    .reset(rst),
    .clk(clk),
    .rd(int_fifo_rd),
    .wr(midi_data_rd_any),
    .data_i(midi_data[int_midi_channel]),
    .data_o(int_fifo_data),
    .empty_n(int_fifo_empty_n),
    .full_n(int_fifo_full_n)
);

uart_tx u0(
    .rst(rst),
    .clk(clk),
    .tx_strobe(int_uart_tx_strobe),
    .data(uart_data),
    .tx(midi_tx),
    .busy(int_uart_tx_busy)
);

endmodule
