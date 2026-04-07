module clock_divider #(parameter divisor = 28'd500000)(
	input CLK_50,
	input RESET,
	
	output reg out_clk
);

	reg [27:0] counter = 28'd0;
	// 50MHz / 500.000 = 100Hz
	
	always@(posedge CLK_50 or posedge RESET) begin
		if(RESET)
			counter <= 28'd0;
		else begin
			counter <= counter + 28'd1;
			if(counter >= (divisor - 1))
				counter <= 28'd0;
			out_clk <= (counter < divisor/2) ? 1'b1 : 1'b0;
		end
	end

endmodule
