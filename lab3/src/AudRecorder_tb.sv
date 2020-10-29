`timescale 1ns/10ps
`define CYCLE 1.0
`include "AudRecorder.sv"

module tb();

    logic clk, rst;
    logic start, pause, stop;
    logic lrc, en, in;
    logic zzz;

    logic [15:0] out, in16;
    integer i;

    initial begin
        clk = 1'b1;
        rst = 1'b1;
        lrc = 0;
        stop = 0;
        in=0;
        pause = 0;
        en = 0;
        start = 1;
        #(`CYCLE*0.2) rst = 1'b0;
        #(`CYCLE*1.5) rst = 1'b1;
        #(`CYCLE*1.5) en = 1'b1;
        lrc = 0;

        #(`CYCLE*1.3) lrc = 1;
        in16 = 16'b1010_1010_1010_1010;
        for(i=0;i<16;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end
        #(`CYCLE*4) lrc = 0;
        in16 = 16'b1010_1010_1010_1010;
        for(i=0;i<5;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end
        pause = 1;
        #(`CYCLE*5) pause=0;
        for(i=5;i<16;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end

        pause = 1;
        #(`CYCLE*5) pause=0;

        #(`CYCLE*4) lrc = 1;
        in16 = 16'b0000_1111_1111_0000;
        for(i=0;i<16;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end
        #(`CYCLE*4) lrc = 0;
        in16 = 16'b0000_1111_1111_0000;
        for(i=0;i<7;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end
        pause = 1;
        #(`CYCLE*20) pause=0;
        for(i=7;i<16;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end

        #(`CYCLE*4) lrc = 1;
        in16 = 16'b1111_1111_1111_1111;
        for(i=0;i<16;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end
        #(`CYCLE*4) lrc = 0;
        in16 = 16'b1111_1111_1111_1111;
        for(i=0;i<16;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end

        #(`CYCLE*4) lrc = 1;
        in16 = 16'b1111_1111_0000_1111;
        for(i=0;i<16;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end
        #(`CYCLE*4) lrc = 0;
        in16 = 16'b1111_1111_0000_1111;
        for(i=0;i<16;i=i+1) begin
            #(`CYCLE) in=in16[15-i];
        end
        #(`CYCLE*4) lrc = 1;
    end

    always begin #(`CYCLE * 0.5) clk = ~clk;
    end


    // AudPlayer player0(
    //     .i_rst_n(rst),
    //     .i_bclk(clk),
    //     .i_daclrck(lrc),
    //     .i_en(en), // enable AudPlayer only when playing audio, work with AudDSP
    //     .i_dac_data(in), //dac_data
    //     .o_aud_dacdat(out)
    // );
    AudRecorder recorder0(
        .i_rst_n(rst),
        .i_clk(clk),
        .i_lrc(lrc),
        .i_start(en),
        .i_pause(pause),
        .i_stop(stop),
        .i_data(in),
        .o_address(addr),
        .o_data(out)
    );

    initial begin
        $fsdbDumpfile("AudRecoder.fsdb");
        $fsdbDumpvars;
    end

    `define TIME_OUT 200
    initial #(`TIME_OUT) $finish;

endmodule