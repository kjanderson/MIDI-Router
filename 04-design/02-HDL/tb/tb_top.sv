module tb(
);

reg clk;
reg int_rst;
wire [7:0] int_spi_data;
wire int_spi_rdy;
reg spi_enable;
reg spi_mosi;
wire spi_miso;
wire spi_sck;
reg sck_in;
reg spi_ss;
reg [7:0] int_test_data;
integer ii;
reg [3:0] midi_in;
wire [3:0] midi_out;
wire [3:0] fbin;
wire test_pin_0;
wire test_pin_1;

always #4 clk = !clk;

assign spi_sck = (spi_enable == 1) ? sck_in : 0;

always @(posedge clk)
begin: bhv_sck
    sck_in = ~sck_in;
end

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

task spi_xchg;
    input [7:0] datai;
    output [7:0] datao;

    /* setup frame: initialize clock input for clock driver and assert ss */
    /* SR samples on the falling edge and outputs on rising edge */
    begin
    @(posedge sck_in);

    spi_enable = 1;
    spi_mosi = datai[7];
    @(negedge spi_sck);
    datao[7] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[6];
    @(negedge spi_sck);
    datao[6] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[5];
    @(negedge spi_sck);
    datao[5] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[4];
    @(negedge spi_sck);
    datao[4] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[3];
    @(negedge spi_sck);
    datao[3] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[2];
    @(negedge spi_sck);
    datao[2] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[1];
    @(negedge spi_sck);
    datao[1] = spi_miso;

    @(posedge spi_sck);
    spi_mosi = datai[0];
    @(negedge spi_sck);
    datao[0] = spi_miso;

    spi_enable = 0;
    @(negedge sck_in);

    end
endtask

initial begin
    int_rst = 0;
    clk = 0;
    spi_enable = 0;
    spi_mosi = 0;
    sck_in = 0;
    spi_ss = 1;
    midi_in = 4'h0;

    /* initialize peripheral memory */
    t0.spi0.int_sr = 8'h00;
    t0.spi0.int_sdo = 0;
    t0.spi0.int_rdy = 0;

    t0.m0.u0.int_cnt = 0;
    t0.m0.u0.int_bit_cnt = 0;

    t0.f0.rd_pointer = 0;
    t0.f0.wr_pointer = 0;
    for (ii=0; ii<512; ii++) begin
        t0.f0.ram0._mem_data[ii] = 0;
    end

    @(posedge clk);
    int_rst = 1;
    @(posedge clk);
    int_rst = 0;

    @(posedge clk);
    spi_ss = 0;
    spi_xchg(8'h80, int_test_data);
    spi_ss = 1;
    for (ii=0; ii<10; ii++) begin
        @(posedge clk);
    end

    /* since the application will do the same, give plenty of time between bytes */
    for (ii=0; ii<100; ii++) begin
        @(posedge clk);
    end

    spi_ss = 0;
    spi_xchg(8'h3E, int_test_data);
    spi_ss = 1;
    for (ii=0; ii<10; ii++) begin
        @(posedge clk);
    end

    for (ii=0; ii<100; ii++) begin
        @(posedge clk);
    end

    $finish;
end

top t0(
    .clk(clk),
    .midi_in(midi_in),
    .midi_out(midi_out),
    .gpio_fbin_0(fbin[0]),
    .gpio_fbin_1(fbin[1]),
    .gpio_fbin_2(fbin[2]),
    .gpio_fbin_3(fbin[3]),
    .gpio_bin_14(test_pin_0),
    .gpio_bin_15(test_pin_1),
    .spi_clk(spi_sck),
    .spi_miso(spi_miso),
    .spi_mosi(spi_mosi),
    .spi_ss(spi_ss)
);

endmodule
