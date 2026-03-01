module synchronizer #(
    parameter ADDR_WIDTH = 4
)(
    input  wire                clk,
    input  wire                rst,
    input  wire [ADDR_WIDTH:0] gray_in,
    output reg  [ADDR_WIDTH:0] gray_sync2
);

    reg [ADDR_WIDTH:0] gray_sync1;

    always @(posedge clk) begin
        if (rst) begin
            gray_sync1 <= 0;
            gray_sync2 <= 0;
        end else begin
            gray_sync1 <= gray_in;
            gray_sync2 <= gray_sync1;
        end
    end

endmodule