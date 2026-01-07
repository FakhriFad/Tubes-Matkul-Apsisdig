module fifo_queue(
    input wire CLK_50,
    input wire RESET,           
    
    input wire WR_EN,            // Write enable
    input wire [7:0] WR_DATA,    // ASCII data in
    
    input wire RD_EN,            // Read enable
    output wire [7:0] RD_DATA,   // ASCII data out (Changed to OUTPUT)

    output wire FIFO_FULL,       // High when FIFO Full
    output wire FIFO_EMPTY       // High when FIFO Empty
);
    parameter DATA_WIDTH = 8;
    parameter FIFO_DEPTH = 16;
    parameter PTR_WIDTH = 4;     // Log2(16) = 4

    reg [DATA_WIDTH-1:0] mem_arr [0:FIFO_DEPTH-1];
    
    reg [PTR_WIDTH:0] ptr_wr;
    reg [PTR_WIDTH:0] ptr_rd;
    
    always @(posedge CLK_50 or posedge RESET) begin
        if (RESET) begin
            ptr_wr <= 0;
            ptr_rd <= 0;
        end else begin
            // Parallel Write
            if(WR_EN && !FIFO_FULL) begin
                mem_arr[ptr_wr[PTR_WIDTH-1:0]] <= WR_DATA;
                ptr_wr <= ptr_wr + 1;
            end
            // Parallel Read
            if(RD_EN && !FIFO_EMPTY) begin
                ptr_rd <= ptr_rd + 1; 
            end
        end
    end
    
    assign RD_DATA = mem_arr[ptr_rd[PTR_WIDTH-1:0]];
    
    assign FIFO_EMPTY = (ptr_wr == ptr_rd);
    assign FIFO_FULL  = (ptr_wr[PTR_WIDTH-1:0] == ptr_rd[PTR_WIDTH-1:0]) && 
                        (ptr_wr[PTR_WIDTH] != ptr_rd[PTR_WIDTH]);

endmodule
