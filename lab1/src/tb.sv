`timescale 1ns/10ps
`define CYCLE 10.0
`include "Top.sv"

module tb();

    logic clk, rst;
    logic start;

    initial begin
        clk = 1'b1;
        rst = 1'b1;
        start = 1'b1;
        #(`CYCLE*0.2) rst = 1'b0;
        #(`CYCLE*1.5) rst = 1'b1;
        #(`CYCLE*1.5) start = 1'b0;
    end

    always begin #(`CYCLE * 0.5) clk = ~clk;
    end

    logic [3:0] out;

    Top top(
        .i_clk(clk),
        .i_rst_n(rst),
        .i_start(start),
        .o_random_out(out)
    );

    initial begin
    $fsdbDumpfile("top.fsdb");
    $fsdbDumpvars;
    end

    `define TIME_OUT 10000000
    initial #(`TIME_OUT) $finish;

endmodule