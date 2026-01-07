module row_driver (
    input  wire       CLK_100HZ,     // Clock 100 Hz
    input  wire       RESET,          // Reset
    output reg  [3:0] ROW_OUT,        // Output ke baris keypad (aktif LOW)
    output reg  [1:0] ROW_IDX         // Indeks baris aktif (0–3)
);

    // Ganti baris setiap rising edge clock 100 Hz
    always @(posedge CLK_100HZ or posedge RESET) begin
        if (RESET)
            ROW_IDX <= 0;
        else
            ROW_IDX <= ROW_IDX + 1;
    end

    // Decoder baris (aktif LOW)
    always @(*) begin
        case (ROW_IDX)
            2'd0: ROW_OUT = 4'b1110;
            2'd1: ROW_OUT = 4'b1101;
            2'd2: ROW_OUT = 4'b1011;
            2'd3: ROW_OUT = 4'b0111;
            default: ROW_OUT = 4'b1111;
        endcase
    end

endmodule