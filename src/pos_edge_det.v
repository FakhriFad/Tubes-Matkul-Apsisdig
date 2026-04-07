module pos_edge_det(
	input clk,
	input in,
	output out
);

	reg sig_dly;
	
	always@(posedge clk) begin
		sig_dly <= in;
	end
	
	assign out = in & ~sig_dly;
	
endmodule
