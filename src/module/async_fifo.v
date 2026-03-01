module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 16
)(
    input  wire                  wr_clk,
    input  wire                  rd_clk,
    input  wire                  rst,
    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire [DATA_WIDTH-1:0] din,
    output wire [DATA_WIDTH-1:0] dout,
    output wire                  full,
    output wire                  empty
);

    localparam ADDR_WIDTH = $clog2(DEPTH);

    wire [ADDR_WIDTH:0] wr_ptr_bin, wr_ptr_gray;
    wire [ADDR_WIDTH:0] rd_ptr_bin, rd_ptr_gray;
    wire [ADDR_WIDTH:0] wr_gray_sync2;
    wire [ADDR_WIDTH:0] rd_gray_sync2;

    // Write domain
    write_domain #(.ADDR_WIDTH(ADDR_WIDTH)) u_write (
        .wr_clk(wr_clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_gray_sync2(rd_gray_sync2),
        .wr_ptr_bin(wr_ptr_bin),
        .wr_ptr_gray(wr_ptr_gray),
        .full(full)
    );

    // Read domain
    read_domain #(.ADDR_WIDTH(ADDR_WIDTH)) u_read (
        .rd_clk(rd_clk),
        .rst(rst),
        .rd_en(rd_en),
        .wr_gray_sync2(wr_gray_sync2),
        .rd_ptr_bin(rd_ptr_bin),
        .rd_ptr_gray(rd_ptr_gray),
        .empty(empty)
    );

    // Synchronizers
    synchronizer #(.ADDR_WIDTH(ADDR_WIDTH)) u_sync_wr2rd (
        .clk(rd_clk),
        .rst(rst),
        .gray_in(wr_ptr_gray),
        .gray_sync2(wr_gray_sync2)
    );

    synchronizer #(.ADDR_WIDTH(ADDR_WIDTH)) u_sync_rd2wr (
        .clk(wr_clk),
        .rst(rst),
        .gray_in(rd_ptr_gray),
        .gray_sync2(rd_gray_sync2)
    );

    // Memory
    fifo_mem #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_mem (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .full(full),
        .empty(empty),
        .wr_addr(wr_ptr_bin[ADDR_WIDTH-1:0]),
        .rd_addr(rd_ptr_bin[ADDR_WIDTH-1:0]),
        .din(din),
        .dout(dout)
    );

endmodule