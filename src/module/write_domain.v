module write_domain #(
    parameter ADDR_WIDTH = 4
)(
    input  wire                wr_clk,
    input  wire                rst,
    input  wire                wr_en,
    input  wire [ADDR_WIDTH:0] rd_gray_sync2,

    output reg  [ADDR_WIDTH:0] wr_ptr_bin,
    output reg  [ADDR_WIDTH:0] wr_ptr_gray,
    output wire                full
);

    function [ADDR_WIDTH:0] bin2gray(input [ADDR_WIDTH:0] bin);
        bin2gray = (bin >> 1) ^ bin;
    endfunction

    wire [ADDR_WIDTH:0] wr_ptr_gray_succ;
    assign wr_ptr_gray_succ = bin2gray(wr_ptr_bin + 1'b1);

    assign full =
        (wr_ptr_gray_succ ==
         {~rd_gray_sync2[ADDR_WIDTH:ADDR_WIDTH-1],
           rd_gray_sync2[ADDR_WIDTH-2:0]});

    always @(posedge wr_clk) begin
        if (rst) begin
            wr_ptr_bin  <= 0;
            wr_ptr_gray <= 0;
        end
        else if (wr_en && !full) begin
            wr_ptr_bin  <= wr_ptr_bin + 1'b1;
            wr_ptr_gray <= bin2gray(wr_ptr_bin + 1'b1);
        end
    end

endmodule