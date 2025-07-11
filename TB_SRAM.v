`timescale 1ns / 1ps

module tb_sram;
    reg clk = 0;
    reg we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;

    // Instantiate SRAM
    sram uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Test pattern:
        $display("Start SRAM Test...");
        we = 0;
        addr = 0;
        din = 0;

        // Write 0xAA to address 0x1
        @(negedge clk);
        we = 1;
        addr = 4'h1;
        din = 8'hAA;

        // Write 0x55 to address 0x2
        @(negedge clk);
        addr = 4'h2;
        din = 8'h55;

        // Disable write to read back
        @(negedge clk);
        we = 0;
        addr = 4'h1;

        // Wait and read from 0x1
        @(negedge clk);
        $display("Read from addr 0x1: %h (Expected: AA)", dout);

        // Read from 0x2
        addr = 4'h2;
        @(negedge clk);
        $display("Read from addr 0x2: %h (Expected: 55)", dout);

        $finish;
    end
endmodule
