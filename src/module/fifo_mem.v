module fifo_mem #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 16,
    parameter ADDR_WIDTH = 4
)(
    input  wire                  wr_clk,
    input  wire                  rd_clk,
    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire                  full,
    input  wire                  empty,
    input  wire [ADDR_WIDTH-1:0] wr_addr,
    input  wire [ADDR_WIDTH-1:0] rd_addr,
    input  wire [DATA_WIDTH-1:0] din,
    output reg  [DATA_WIDTH-1:0] dout
);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Write
    always @(posedge wr_clk)
        if (wr_en && !full)
            mem[wr_addr] <= din;

    // Read
    always @(posedge rd_clk)
        if (rd_en && !empty)
            dout <= mem[rd_addr];

endmodule