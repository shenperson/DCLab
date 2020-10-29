// PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;32m\]\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

`timescale 1ns/10ps
`define CYCLE 1.0
`include "AudDSP.sv"

module tb();

    logic clk, rst;
    logic start, pause, stop, lrc;
    logic [15:0] in, out;
    logic [19:0] addr;
    logic [15:0] mem[0:5];

    assign mem[0] = 16'd1;
    assign mem[1] = 16'd3;
    assign mem[2] = 16'd5;
    assign mem[3] = 16'd7;
    assign mem[4] = 16'd9;
    assign mem[5] = 16'd11;

    assign in = mem[addr];

    initial begin
        clk = 1'b1;
        rst = 1'b1;
        lrc = 0;
        start = 0;
        pause = 0;
        stop = 0;
        #(`CYCLE*0.2) rst = 1'b0;
        #(`CYCLE*1.5) rst = 1'b1;
        #(`CYCLE*1.5) start = 1'b1;
        #(`CYCLE*1) start = 1'b0;
        #(`CYCLE*20) pause = 1;
        #(`CYCLE*5) pause = 0;

        #(`CYCLE*5) pause = 1;
        #(`CYCLE*5) pause = 0;
        #(`CYCLE*24) pause = 1;
        #(`CYCLE*10) pause = 0;
    end

    always begin #(`CYCLE * 0.5) clk = ~clk;
    end
    always begin #(`CYCLE * 14.5) lrc = ~lrc;
    end


    AudDSP dsp0(
        .i_rst_n(rst),
        .i_clk(clk),
        .i_start(start),
        .i_pause(pause),
        .i_stop(stop),
        .i_daclrck(lrc),
        .i_sram_data(in),
        .o_dac_data(out),
        .o_sram_addr(addr)
    );

    initial begin
        $fsdbDumpfile("AudDSP.fsdb");
        $fsdbDumpvars;
    end

    `define TIME_OUT 120
    initial #(`TIME_OUT) $finish;

endmodule