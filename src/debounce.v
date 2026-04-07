module debounce (
	input clk, 
	input in, 
	output reg out
);

	reg sync_0;
	reg sync_1;
	
	always@(posedge clk) begin
		sync_0 <= in;
		sync_1 <= sync_0;
		out <= sync_1;
	end
	
endmodule
