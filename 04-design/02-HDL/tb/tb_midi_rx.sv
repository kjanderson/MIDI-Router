/**********************************************************************
 * tb_midi_rx
 *
 * This module implements the test bench for the midi_rx module.
 *
 * The application provides a 125 KHz sample clock to the module.
 *
 * Notes
 * This module compiles and generates midi_in.
 * Still need to verify the bus and irq interface.
 * May need to come back to irq and bus_rd interface, depending on details
 * of the FIFO implementation.
 *
 * TODO
 *
 * Tests
 * 01: verify the midi_rx module receives a signal and asserts its data on the bus.
 * 02: verify the midi_rx module sends queued data when a status byte is received.
 *********************************************************************/

`timescale 1us / 1ns

module tb(
);

parameter STATE_IDLE = 1'b0;
parameter STATE_READ = 1'b1;

reg clk;
reg bus_clk;
reg bus_rd;
reg midi_in;
reg rst;
wire irq;
wire [7:0] midi_dat;
wire midi_dat_rdy;
reg midi_dat_rd;
reg [7:0] gen_midi_dat;
reg [7:0] rcv_midi_dat;
reg int_curr_state;
reg int_next_state;

always #4 clk <= ~clk;

/* send data on falling clock edge */
task uart_tx;
    input [7:0] datai;
    integer ii;
    integer jj;
    
    begin
    /* start bit */
    @(negedge clk);
    midi_in = 1'b0;
    for (ii=0; ii<8; ii++) begin
        @(negedge clk);
    end
    
    /* data bits */
    for (jj=0; jj<8; jj=jj+1) begin
        midi_in = datai[jj];
        for (ii=0; ii<8; ii=ii+1) begin
            @(negedge clk);
        end
    end
    
    /* stop bit */
    midi_in = 1'b1;
    for (ii=0; ii<8; ii++) begin
        @(negedge clk);
    end
    end
endtask

/* introduce a state machine to automatically read out the FIFO data */
always @(int_curr_state, midi_dat_rdy)
begin: st_cl
    case(int_curr_state)
    STATE_IDLE: begin
        if (midi_dat_rdy == 1'b1) begin
            int_next_state = STATE_READ;
        end
    end
    STATE_READ: begin
        if (midi_dat_rdy == 1'b0) begin
            int_next_state = STATE_IDLE;
        end
    end
    default: begin
        int_next_state = STATE_IDLE;
    end
    endcase
end

always @(posedge clk, posedge rst)
begin: st_sl
    if (rst == 1'b1) begin
        int_curr_state <= STATE_IDLE;
    end
    else begin
        int_curr_state <= int_next_state;
    end
end

always @(posedge clk, posedge rst)
begin: st_op
    if (rst == 1'b1) begin
        midi_dat_rd <= 1'b0;
    end
    else begin
        case(int_curr_state)
        STATE_IDLE: begin
            midi_dat_rd <= 1'b0;
        end
        STATE_READ: begin
            midi_dat_rd <= 1'b1;
        end
        default: begin
            midi_dat_rd <= 1'b0;
        end
        endcase
    end
end

/* use sequential logic in the initial block to avoid race conditions */
initial begin
    rst = 0;
    clk = 0;
    midi_in = 1'b1;
    midi_dat_rd = 1'b0;
    
    /* reset pulse */
    @(negedge clk);
    rst = 1;
    @(negedge clk);
    rst = 0;
    
    /* simulation */
    @(negedge clk);
    gen_midi_dat = 8'h80;
    uart_tx(gen_midi_dat);
    
    @(posedge midi_dat_rdy);
    assert(gen_midi_dat == midi_dat);
    
    @(negedge clk);
    gen_midi_dat = 8'h01;
    uart_tx(gen_midi_dat);
    
    assert(gen_midi_dat == midi_dat);
    
    @(negedge clk);
    gen_midi_dat = 8'h80;
    uart_tx(gen_midi_dat);
    
    @(posedge midi_dat_rdy);
    @(negedge midi_dat_rdy);
    assert(gen_midi_dat == midi_dat);
    /*
    */
    
    @(negedge clk);
    /*
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    */
    
    $finish;
end

midi_rx midi_rx_0(
    .rst(rst),
    .clk(clk),
    .midi_in(midi_in),
    .midi_data(midi_dat),
    .midi_data_rdy(midi_dat_rdy),
    .midi_data_rd(midi_dat_rd)
);

endmodule
