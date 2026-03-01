module read_domain #(
    parameter ADDR_WIDTH = 4
)(
    input  wire                rd_clk,
    input  wire                rst,
    input  wire                rd_en,
    input  wire [ADDR_WIDTH:0] wr_gray_sync2,

    output reg  [ADDR_WIDTH:0] rd_ptr_bin,
    output reg  [ADDR_WIDTH:0] rd_ptr_gray,
    output wire                empty
);

    function [ADDR_WIDTH:0] bin2gray(input [ADDR_WIDTH:0] bin);
        bin2gray = (bin >> 1) ^ bin;
    endfunction

    assign empty = (rd_ptr_gray == wr_gray_sync2);

    always @(posedge rd_clk) begin
        if (rst) begin
            rd_ptr_bin  <= 0;
            rd_ptr_gray <= 0;
        end
        else if (rd_en && !empty) begin
            rd_ptr_bin  <= rd_ptr_bin + 1'b1;
            rd_ptr_gray <= bin2gray(rd_ptr_bin + 1'b1);
        end
    end

endmodule