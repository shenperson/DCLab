`timescale 1ns/10ps
`define CYCLE 10.0
// `include "I2cInitializer.sv"

module tb();

    // different operations
    parameter OP_RESET = 0;
    parameter OP_AAPC  = 1;
    parameter OP_DAPC  = 2;
    parameter OP_PDC   = 3;
    parameter OP_DAIF  = 4;
    parameter OP_SC    = 5;
    parameter OP_AC    = 6;

    logic clk, rst;
    logic start;
    logic [2:0] op;

    initial begin
        clk = 1'b1;
        rst = 1'b1;
        start = 1'b0;
        #(`CYCLE*0.2) rst = 1'b0;
        #(`CYCLE*1.5) rst = 1'b1;
        start = 1'b1;
        op = 1'b1;
    end

    always begin #(`CYCLE * 0.5) clk = ~clk;
    end

    logic finished;
    logic sclk;
    logic sdat;
    logic oen;

    I2cInitializer i2ci(
        .i_rst_n(rst),
        .i_clk(clk),
        .i_start(start),
        .i_op(op), // operation to initialize
        .o_finished(finished),
        .o_sclk(sclk), // SCL
        .o_sdat(sdat), // SDA
        .o_oen(oen)
    );

    initial begin
        $fsdbDumpfile("i2ci.fsdb");
        $fsdbDumpvars;
    end

    // always begin
    //     if (finished == 1'b1) begin
    //         start = 1'b0;
    //         #(`CYCLE * 5) $finish;
    //     end
    // end

    `define TIME_OUT 10000
    initial #(`TIME_OUT) $finish;

endmodule