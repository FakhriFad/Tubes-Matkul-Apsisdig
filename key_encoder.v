module key_encoder (
    input  wire [1:0] row,        // baris keypad (0-3)
    input  wire [3:0] col,        // kolom keypad (0-3)
    output reg  [7:0] key_code    // ASCII output
);

always @(*) begin
    key_code = 8'h00; 

    case ({row, col})
        // Row 0
        6'b001110: key_code = 8'h31; // '1'
        6'b001101: key_code = 8'h32; // '2'
        6'b001011: key_code = 8'h33; // '3'
        6'b000111: key_code = 8'h41; // 'A'

        // Row 1
        6'b011110: key_code = 8'h34; // '4'
        6'b011101: key_code = 8'h35; // '5'
        6'b011011: key_code = 8'h36; // '6'
        6'b010111: key_code = 8'h42; // 'B'

        // Row 2
        6'b101110: key_code = 8'h37; // '7'
        6'b101101: key_code = 8'h38; // '8'
        6'b101011: key_code = 8'h39; // '9'
        6'b100111: key_code = 8'h43; // 'C'

        // Row 3
        6'b111110: key_code = 8'h2A; // '*'
        6'b111101: key_code = 8'h30; // '0'
        6'b111011: key_code = 8'h23; // '#'
        6'b110111: key_code = 8'h44; // 'D'
    endcase
end

endmodule
