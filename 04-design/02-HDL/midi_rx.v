/**********************************************************************
 * midi_rx
 *
 * Description
 * This module implements a receiver for MIDI data. It implements a
 * simple MIDI message parser as a state machine.
 *
 * Notes
 * This state machine still needs to handle the case when an expected data byte
 * is actually a status byte.
 *
 * Problems
 *  1. Need to work out how the logic and the wishbone interface
 *     can both update the register file.
 *********************************************************************/

`include "midi_messages.vh"

module midi_rx(
    midi_in,
    clk,
    rst,
    wb_addr_i,
    wb_dat_i,
    wb_dat_o,
    wb_we_i,
    wb_stb_i,
    wb_ack_o
);

parameter BASE_ADDR    = 8'h00;
parameter ST_STATUS    = 3'h0;
parameter ST_DATA2_RX1 = 3'h1;
parameter ST_DATA3_RX1 = 3'h2;
parameter ST_DATA3_RX2 = 3'h3;

/* address map */
`define MIDI_RX_BITMAP   3'h0
`define MIDI_RX_BITMAP_REALTIME 3'h0
`define MIDI_RX_BITMAP_2B       3'h1
`define MIDI_RX_BITMAP_3B       3'h2
`define MIDI_RX_REALTIME 3'h1
`define MIDI_RX_STATUS   3'h2
`define MIDI_RX_BYTE1    3'h3
`define MIDI_RX_BYTE2    3'h4

input  wire       midi_in;
input  wire       clk;
input  wire       rst;
input  wire [7:0] wb_addr_i;
input  wire [7:0] wb_dat_i;
output wire [7:0] wb_dat_o;
input  wire       wb_we_i;
input  wire       wb_stb_i;
output wire       wb_ack_o;

/* internal signals */
wire int_uart_data_rdy;
wire [7:0] int_uart_data;
reg int_wb_ack_o;
reg [7:0] int_wb_dat_o;

reg [7:0] int_databuf[4:0];
reg [7:0] int_wb_databuf[4:0];
reg int_we_ack;

reg [1:0] int_curr_state;
reg [1:0] int_next_state;

assign wb_ack_o = int_wb_ack_o;
assign wb_dat_o = int_wb_dat_o;

/* access function for status bit in MIDI message */
function get_status;
input [7:0] in_data;
begin
    get_status = in_data[7] == 1'b1;
end
endfunction

function get_status_2b_msg;
input [7:0] in_data;
begin
    get_status_2b_msg = ((in_data[7:4] == `MIDI_PGM_CHANGE) ||
                         (in_data[7:4] == `MIDI_CHNL_PRESSURE));
end
endfunction

function get_status_3b_msg;
input [7:0] in_data;
begin
    get_status_3b_msg = ((in_data[7:4] == `MIDI_NOTE_OFF) ||
                         (in_data[7:4] == `MIDI_NOTE_ON) ||
                         (in_data[7:4] == `MIDI_POLY_PRESSURE) ||
                         (in_data[7:4] == `MIDI_CTRL_CHANGE) ||
                         (in_data[7:4] == `MIDI_PITCH_BEND));
end
endfunction

function get_realtime;
input [7:0] in_data;
begin
    get_realtime = ((in_data & `MIDI_REALTIME_MASK) == `MIDI_REALTIME_MASK);
end
endfunction

/**********************************************************************
 * wishbone interface
 *********************************************************************/
always @(posedge clk)
begin
    if (rst == 1'b1) begin
    end
    else begin
        if (wb_stb_i == 1'b1) begin
            if (wb_addr_i <= (BASE_ADDR + `MIDI_RX_BYTE2)) begin
                if (wb_we_i == 1'b0) begin
                    int_wb_dat_o <= int_wb_databuf[wb_addr_i];
                    int_wb_ack_o <= 1'b1;
                end
                else begin
                    int_wb_ack_o <= int_we_ack;
                end
            end
            else begin
                int_wb_ack_o <= 1'b1;
            end
        end
        else begin
            int_wb_ack_o <= 1'b0;
        end
    end
end

/**********************************************************************
 * state machine combinational logic
 *********************************************************************/
always @(int_curr_state, int_uart_data_rdy, int_uart_data)
begin: bhv_sm_cl
    case(int_curr_state)
    ST_STATUS: begin
        if (int_uart_data_rdy == 1) begin
            if (get_realtime(int_uart_data)) begin
                int_next_state = ST_STATUS;
            end
            else begin
                if (get_status(int_uart_data)) begin
                    if (get_status_2b_msg(int_uart_data)) begin
                        int_next_state = ST_DATA2_RX1;
                    end
                    else if (get_status_3b_msg(int_uart_data)) begin
                        int_next_state = ST_DATA3_RX1;
                    end
                    else begin
                        int_next_state = ST_STATUS;
                    end
                end
                else begin
                    int_next_state = ST_STATUS;
                end
            end
        end
        else begin
            int_next_state = ST_STATUS;
        end
    end
    ST_DATA2_RX1: begin
        if (int_uart_data_rdy == 1) begin
            if (get_realtime(int_uart_data)) begin
                int_next_state = ST_DATA2_RX1;
            end
            else begin
                if (get_status(int_uart_data)) begin
                    if (get_status_2b_msg(int_uart_data)) begin
                        int_next_state = ST_DATA2_RX1;
                    end
                    else if (get_status_3b_msg(int_uart_data)) begin
                        int_next_state = ST_DATA3_RX1;
                    end
                    else begin
                        int_next_state = ST_STATUS;
                    end
                end
                else begin
                    int_next_state = ST_STATUS;
                end
            end
        end
        else begin
            int_next_state = ST_DATA2_RX1;
        end
    end
    ST_DATA3_RX1: begin
        if (int_uart_data_rdy == 1) begin
            if (get_realtime(int_uart_data)) begin
                int_next_state = ST_DATA3_RX1;
            end
            else begin
                if (get_status(int_uart_data)) begin
                    if (get_status_2b_msg(int_uart_data)) begin
                        int_next_state = ST_DATA2_RX1;
                    end
                    else if (get_status_3b_msg(int_uart_data)) begin
                        int_next_state = ST_DATA3_RX1;
                    end
                    else begin
                        int_next_state = ST_STATUS;
                    end
                end
                else begin
                    int_next_state = ST_DATA3_RX2;
                end
            end
        end
        else begin
            int_next_state = ST_DATA3_RX1;
        end
    end
    ST_DATA3_RX2: begin
        if (int_uart_data_rdy == 1) begin
            if (get_realtime(int_uart_data)) begin
                int_next_state = ST_DATA3_RX2;
            end
            else begin
                if (get_status(int_uart_data)) begin
                    if (get_status_2b_msg(int_uart_data)) begin
                        int_next_state = ST_DATA2_RX1;
                    end
                    else if (get_status_3b_msg(int_uart_data)) begin
                        int_next_state = ST_DATA3_RX1;
                    end
                    else begin
                        int_next_state = ST_STATUS;
                    end
                end
                else begin
                    int_next_state = ST_STATUS;
                end
            end
        end
        else begin
            int_next_state = ST_DATA3_RX2;
        end
    end
    default: begin
        int_next_state = ST_STATUS;
    end
    endcase
end

/**********************************************************************
 * state machine sequential logic
 *********************************************************************/
always @(posedge clk)
begin: bhv_sm_sl
    if (rst == 1'b1) begin
        int_curr_state <= ST_STATUS;
    end
    else begin
        int_curr_state <= int_next_state;
    end
end

/**********************************************************************
 * state machine outputs
 *********************************************************************/
always @(posedge clk)
begin: bhv_sm_op
    if (rst == 1'b1) begin
    end
    else begin
        if (int_we_ack == 1'b1) begin
            int_we_ack <= 1'b0;
        end

        case(int_curr_state)
        ST_STATUS: begin
            if (int_uart_data_rdy == 1'b1) begin
                if (get_realtime(int_uart_data)) begin
                    int_databuf[`MIDI_RX_REALTIME] <= int_uart_data;
                    int_databuf[`MIDI_RX_BITMAP][`MIDI_RX_BITMAP_REALTIME] <= 1'b1;
                    int_wb_databuf[`MIDI_RX_REALTIME] <= int_uart_data;
                    int_wb_databuf[`MIDI_RX_BITMAP][`MIDI_RX_BITMAP_REALTIME] <= 1'b1;
                end
                else if (get_status(int_uart_data)) begin
                    int_databuf[`MIDI_RX_STATUS] <= int_uart_data;

                    if (get_status_2b_msg(int_uart_data)) begin
                        int_databuf[`MIDI_RX_BITMAP][`MIDI_RX_BITMAP_2B] <= 1'b1;
                        int_databuf[`MIDI_RX_BITMAP][`MIDI_RX_BITMAP_3B] <= 1'b0;
                    end
                    else if (get_status_3b_msg(int_uart_data)) begin
                        int_databuf[`MIDI_RX_BITMAP][`MIDI_RX_BITMAP_3B] <= 1'b1;
                        int_databuf[`MIDI_RX_BITMAP][`MIDI_RX_BITMAP_2B] <= 1'b0;
                    end
                end
            end
            else begin
                /* wishbone write request restricted to idle state */
                if (wb_stb_i) begin
                    if (wb_we_i) begin
                        if (wb_addr_i == (BASE_ADDR + `MIDI_RX_BITMAP)) begin
                            int_databuf[wb_addr_i] <= wb_dat_i;
                        end
                    end
                    /* still need to signal the read process to trigger ack */
                    int_we_ack <= 1'b1;
                end
            end
        end
        ST_DATA2_RX1: begin
            if (int_uart_data_rdy == 1'b1) begin
                int_databuf[`MIDI_RX_BYTE1] <= int_uart_data;

                int_wb_databuf[`MIDI_RX_BITMAP] <= int_databuf[`MIDI_RX_BITMAP];
                int_wb_databuf[`MIDI_RX_STATUS] <= int_databuf[`MIDI_RX_STATUS];
                int_wb_databuf[`MIDI_RX_BYTE1] <= int_databuf[`MIDI_RX_BYTE1];
            end
        end
        ST_DATA3_RX1: begin
            if (int_uart_data_rdy == 1'b1) begin
                int_databuf[`MIDI_RX_BYTE1] <= int_uart_data;
            end
        end
        ST_DATA3_RX2: begin
             if (int_uart_data_rdy == 1'b1) begin
                int_databuf[`MIDI_RX_BYTE2] <= int_uart_data;

                int_wb_databuf[`MIDI_RX_BITMAP] <= int_databuf[`MIDI_RX_BITMAP];
                int_wb_databuf[`MIDI_RX_STATUS] <= int_databuf[`MIDI_RX_STATUS];
                int_wb_databuf[`MIDI_RX_BYTE1] <= int_databuf[`MIDI_RX_BYTE1];
                int_wb_databuf[`MIDI_RX_BYTE2] <= int_databuf[`MIDI_RX_BYTE2];
            end
       end
        default: begin
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

endmodule
