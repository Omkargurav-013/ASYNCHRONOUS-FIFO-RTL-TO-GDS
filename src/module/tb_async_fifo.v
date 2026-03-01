`timescale 1ns/1ps

module tb_async_fifo;

    reg wr_clk;
    reg rd_clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [7:0] din;

    wire [7:0] dout;
    wire full;
    wire empty;

    // ----------------------------
    // DUT (GLS STYLE)
    // ----------------------------
    async_fifo dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    // ----------------------------
    // Clock generation
    // ----------------------------
    always #5  wr_clk = ~wr_clk;
    always #7  rd_clk = ~rd_clk;

    // ----------------------------
    // VCD
    // ----------------------------
    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0, tb_async_fifo);
    end

    // ----------------------------
    // Watchdog
    // ----------------------------
    initial begin
        #5000;
        $display("ERROR: Simulation timeout");
        $finish;
    end

    // ----------------------------
    // Main stimulus
    // ----------------------------
    initial begin
        // Init
        wr_clk = 0;
        rd_clk = 0;
        rst    = 1;
        wr_en  = 0;
        rd_en  = 0;
        din    = 0;

        #50 rst = 0;

        // ----------------------------
        // WRITE ONLY PHASE (UNCHANGED)
        // ----------------------------
        repeat (16) begin
            @(posedge wr_clk);
            if (!full) begin
                wr_en = 1;
                din   = din + 1;
            end
        end
        wr_en = 0;

        // ----------------------------
        // READ ONLY PHASE (FIXED)
        // ----------------------------
        repeat (16) begin
            // issue read pulse
            @(posedge rd_clk);
            if (!empty)
                rd_en = 1;
            else
                rd_en = 0;

            // FIX: deassert after 1 cycle
            @(posedge rd_clk);
            rd_en = 0;

            // FIX: wait for data to become valid
            @(posedge rd_clk);
        end

        // ----------------------------
        // CONCURRENT READ & WRITE (FIXED)
        // ----------------------------
        fork
            // WRITE side (UNCHANGED)
            begin
                repeat (20) begin
                    @(posedge wr_clk);
                    if (!full) begin
                        wr_en = 1;
                        din   = din + 1;
                    end else
                        wr_en = 0;
                end
                wr_en = 0;
            end

            // READ side (FIXED)
            begin
                repeat (20) begin
                    @(posedge rd_clk);
                    if (!empty)
                        rd_en = 1;
                    else
                        rd_en = 0;

                    @(posedge rd_clk);
                    rd_en = 0;

                    @(posedge rd_clk);
                end
            end
        join

        #100;
        $display("Simulation completed successfully");
        $finish;
    end

endmodule
