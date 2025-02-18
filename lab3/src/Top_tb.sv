`timescale 1ns/10ps
`define CYCLE 1.0

module tb();

    logic i_rst_n;
	logic i_clk;
	logic i_key_0;
	logic i_key_1;
	logic i_key_2;

	logic [19:0] o_SRAM_ADDR;
	wire  [15:0] io_SRAM_DQ;
	logic        o_SRAM_WE_N;
	logic        o_SRAM_CE_N;
	logic        o_SRAM_OE_N;
	logic        o_SRAM_LB_N;
	logic        o_SRAM_UB_N;

	logic i_clk_100k;
	logic o_I2C_SCLK;
	wire  io_I2C_SDAT;

	logic i_AUD_ADCDAT;
	wire  i_AUD_ADCLRCK;
    reg lrc;
	wire  i_AUD_BCLK;
	wire  i_AUD_DACLRCK;
	logic o_AUD_DACDAT;

    Top top0(
        .i_rst_n(i_rst_n),
	    .i_clk(i_clk),
	    .i_key_0(i_key_0),
	    .i_key_1(i_key_1),
	    .i_key_2(i_key_2),

	    .o_SRAM_ADDR(o_SRAM_ADDR),
	    .io_SRAM_DQ(io_SRAM_DQ),
	    .o_SRAM_WE_N(o_SRAM_WE_N),
	    .o_SRAM_CE_N(o_SRAM_CE_N),
	    .o_SRAM_OE_N(o_SRAM_OE_N),
	    .o_SRAM_LB_N(o_SRAM_LB_N),
	    .o_SRAM_UB_N(o_SRAM_UB_N),

	    .i_clk_100k(i_clk_100k),
	    .o_I2C_SCLK(o_I2C_SCLK),
	    .io_I2C_SDAT(io_I2C_SDAT),

	    .i_AUD_ADCDAT(i_AUD_ADCDAT),
	    .i_AUD_ADCLRCK(i_AUD_ADCLRCK),
	    .i_AUD_BCLK(i_AUD_BCLK),
	    .i_AUD_DACLRCK(i_AUD_DACLRCK),
	    .o_AUD_DACDAT(o_AUD_DACDAT)
    );
    assign i_AUD_ADCLRCK = lrc;
    assign i_AUD_DACLRCK = lrc;
    // assign i_AUD_BCLK = i_clk_100k;
    assign i_AUD_BCLK = i_clk;
    initial begin
        i_clk = 1'b0;
        i_rst_n = 1'b1;
        i_key_0 = 1'b0;
        i_key_1 = 1'b0;
        i_key_2 = 1'b0;
        // io_SRAM_DQ = 16'dz;
        i_clk_100k = 1'b0;
        // io_I2C_SDAT = 16'dz;
        i_AUD_ADCDAT = 0;

        lrc = 0;
        // i_AUD_BCLK = 0;
        #(`CYCLE*0.2); i_rst_n = 1'b0;
        #(`CYCLE*1.5); i_rst_n = 1'b1;
        #(`CYCLE*5); i_key_0 = 1;
        #(`CYCLE*2); i_key_0 = 0;

        #(`CYCLE*40000);i_AUD_ADCDAT = 1;
        #(`CYCLE*1500); i_AUD_ADCDAT = 0;
        #(`CYCLE*1600); i_AUD_ADCDAT = 1;
        #(`CYCLE*1700); i_AUD_ADCDAT = 0;
        #(`CYCLE*1800); i_AUD_ADCDAT = 0;
        #(`CYCLE*2000); i_key_0 = 1;
        #(`CYCLE*1); i_key_0 = 0;
        #(`CYCLE*1000); i_key_0 = 1;
        #(`CYCLE*1); i_key_0 = 0;
    end

    always begin 
        #(`CYCLE * 0.5) i_clk = ~i_clk;
    end
    always begin
        #(`CYCLE * 20) lrc = ~lrc;
    end
    // always begin 
    //     #(`CYCLE * 1) i_AUD_BCLK = ~i_AUD_BCLK;
    // end
    always begin 
        #(`CYCLE * 50) i_clk_100k = ~i_clk_100k;
    end
    // always begin
    //     #(`CYCLE * 29.5); i_AUD_DACLRCK = ~i_AUD_DACLRCK;
    //     i_AUD_ADCLRCK = ~i_AUD_ADCLRCK; #(`CYCLE * 0.5);
    // end

    initial begin
        $fsdbDumpfile("Top.fsdb");
        $fsdbDumpvars;
    end


    `define TIME_OUT 120000
    initial #(`TIME_OUT) $finish;

endmodule