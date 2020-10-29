`timescale 1ns/10ps
`define CYCLE 1.0
`include "AudPlayer.sv"

module tb();

    logic clk, rst;
    logic start;
    logic lrc, en, out;
    logic [15:0] in;

    initial begin
        clk = 1'b1;
        rst = 1'b1;
        lrc = 0;
        en = 0;
        #(`CYCLE*0.2) rst = 1'b0;
        #(`CYCLE*1.5) rst = 1'b1;
        #(`CYCLE*1.5) en = 1'b1;
        lrc = 0;
        #(`CYCLE*1.3) lrc = 1;
        in = 16'b1010_1010_1010_1010;
        #(`CYCLE*20) lrc = 0;
        in = 16'b0000_1111_1111_1111;
        #(`CYCLE*20) lrc = 1;
        in = 16'b0000_1111_1111_0000;
        #(`CYCLE*20) lrc = 0;
        in = 16'b1111_1111_1111_1111;
        #(`CYCLE*20) lrc = 1;
        in = 16'b1111_1111_0000_1111;
    end

    always begin #(`CYCLE * 0.5) clk = ~clk;
    end


    AudPlayer player0(
        .i_rst_n(rst),
        .i_bclk(clk),
        .i_daclrck(lrc),
        .i_en(en), // enable AudPlayer only when playing audio, work with AudDSP
        .i_dac_data(in), //dac_data
        .o_aud_dacdat(out)
    );

    initial begin
        $fsdbDumpfile("AudPlayer.fsdb");
        $fsdbDumpvars;
    end

    `define TIME_OUT 120
    initial #(`TIME_OUT) $finish;

endmodule