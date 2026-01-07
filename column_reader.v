module column_reader (
    input wire clk,              
    input wire rst,              
    input wire [3:0] col_in,     
    output reg [3:0] col_data,   
    output reg key_pressed       
);

    reg [3:0] col_sync_1;
    reg [3:0] col_sync_2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            col_sync_1 <= 4'b1111;
            col_sync_2 <= 4'b1111;
            col_data   <= 4'b1111;
            key_pressed <= 1'b0;
        end else begin
            col_sync_1 <= col_in;
            col_sync_2 <= col_sync_1;


            col_data <= col_sync_2;
            
            if (col_sync_2 != 4'b1111) 
                key_pressed <= 1'b1;
            else
                key_pressed <= 1'b0;
        end
    end

endmodule
