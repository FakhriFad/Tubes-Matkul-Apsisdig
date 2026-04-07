module matrix_scanner #(parameter DIVISOR = 500000)(
	input CLK_50,
	input RESET_IN,
	
	input [3:0] col_in,
	output [3:0] row_out,
	
	input fifo_rd,
	output [7:0] data_out,
	output fifo_full,
	output fifo_empty
);

	wire clk_100;
	wire [1:0] row_idx;
	wire [3:0] col_data;
	wire key_pressed;
	wire debounce_out;
	wire [7:0] encode_ascii;
	wire pulse_out;
	wire RESET = ~RESET_IN;
	
	clock_divider #(.divisor(DIVISOR)) clk_div(
		.CLK_50(CLK_50),
		.RESET(RESET),
		.out_clk(clk_100)
	);
	
	row_driver row_drv(
		.CLK_100HZ(clk_100),
		.RESET(RESET),
		.ROW_OUT(row_out),
		.ROW_IDX(row_idx)
	);
	
	column_reader col_read(
		.clk(clk_100),
		.rst(RESET),
		.col_in(col_in),
		.col_data(col_data),
		.key_pressed(key_pressed)
	);
	
	key_encoder key_enc(
		.row(row_idx),
		.col(col_data),
		.key_code(encode_ascii)
	);
	
	debounce debounce(
		.clk(clk_100),
		.in(key_pressed),
		.out(debounce_out)
	);
	
	pos_edge_det pulse(
		.clk(clk_100),
		.in(debounce_out),
		.out(pulse_out)
	);
	
	fifo_queue fifo(
		.CLK_50(clk_100),
		.RESET(RESET),
		.WR_EN(pulse_out),
		.WR_DATA(encode_ascii),
		.RD_EN(fifo_rd),
		.RD_DATA(data_out),
		.FIFO_FULL(fifo_full),
		.FIFO_EMPTY(fifo_empty)
	);

endmodule 
