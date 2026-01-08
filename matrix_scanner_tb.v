`timescale 1ns / 1ps

module matrix_scanner_tb();

    reg CLK_50;
    reg RESET;
    reg [3:0] col_in;
    reg fifo_rd;

    wire [3:0] row_out;
    wire [7:0] data_out;
    wire fifo_full;
    wire fifo_empty;
	 wire press;
	 wire debounce;
	 wire pulse;
	 wire [7:0] ascii;
	 wire clk;

    matrix_scanner #(.DIVISOR(50)) dut (
        .CLK_50(CLK_50),
        .RESET_IN(RESET),
        .col_in(col_in),
        .row_out(row_out),
        .fifo_rd(fifo_rd),
        .data_out(data_out),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
		  .key_pressed(press),
		  .debounce_out(debounce),
		  .pulse_out(pulse),
		  .encode_ascii(ascii),
		  .clk_100(clk)
    );

    always #10 CLK_50 = ~CLK_50;

    initial begin
        CLK_50 = 0;
        RESET = 0; 
        col_in = 4'b1111; 
        fifo_rd = 0;

        #100;
        RESET = 1;
        #100;

        wait(row_out == 4'b1101);
        col_in = 4'b1101; 
        #5000;           
        col_in = 4'b1111; 
        #1000;

        wait(row_out == 4'b1110);
        col_in = 4'b0111;
        #5000;
        col_in = 4'b1111; 
        #1000;

        #1000;
        if (!fifo_empty) begin
            fifo_rd = 1;
            #100;
            fifo_rd = 0;
        end

        #1000;
        if (!fifo_empty) begin
            fifo_rd = 1;
            #100;
            fifo_rd = 0;
        end

        #1000;
        $stop;
    end

endmodule
