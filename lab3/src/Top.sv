module Top (
	input i_rst_n,
	input i_clk,
	input i_key_0,
	input i_key_1,
	input i_key_2,
	// input [3:0] i_speed, // design how user can decide mode on your own
	
	// AudDSP and SRAM
	output [19:0] o_SRAM_ADDR,
	inout  [15:0] io_SRAM_DQ,
	output        o_SRAM_WE_N,
	output        o_SRAM_CE_N,
	output        o_SRAM_OE_N,
	output        o_SRAM_LB_N,
	output        o_SRAM_UB_N,
	
	// I2C
	input  i_clk_100k,
	output o_I2C_SCLK,
	inout  io_I2C_SDAT,
	
	// AudPlayer
	input  i_AUD_ADCDAT,
	inout  i_AUD_ADCLRCK,
	inout  i_AUD_BCLK,
	inout  i_AUD_DACLRCK,
	output o_AUD_DACDAT,

	// SEVENDECODER (optional display)
	// output [5:0] o_record_time,
	// output [5:0] o_play_time,
	output [2:0] state

	// LCD (optional display)
	// input        i_clk_800k,
	// inout  [7:0] o_LCD_DATA,
	// output       o_LCD_EN,
	// output       o_LCD_RS,
	// output       o_LCD_RW,
	// output       o_LCD_ON,
	// output       o_LCD_BLON,

	// LED
	// output  [8:0] o_ledg,
	// output [17:0] o_ledr
);
// design the FSM and states as you like
parameter S_IDLE       = 0;
parameter S_I2C        = 1;
parameter S_RECD       = 2;
parameter S_RECD_PAUSE = 3;
parameter S_TUNE       = 4;
parameter S_PLAY       = 5;
parameter S_PLAY_PAUSE = 6;

logic [2:0] state_w, state_r;

logic i2c_start_r, i2c_start_w;
logic i2c_finished;
logic i2c_oen, i2c_sdat;

logic recorder_start_r, recorder_start_w;
logic recorder_pause_r, recorder_pause_w;
logic recorder_stop_r, recorder_stop_w;

logic dsp_start_r, dsp_start_w;
logic dsp_pause_r, dsp_pause_w;
logic dsp_stop_r, dsp_stop_w;

logic [19:0] addr_record, addr_play;
logic [15:0] data_record, data_play, dac_data;
logic player_en_r, player_en_w;
logic player_pause_r, player_pause_w;

assign state = state_r;

assign io_I2C_SDAT = (i2c_oen) ? i2c_sdat : 1'bz;

assign o_SRAM_ADDR = (state_r == S_RECD) ? addr_record : addr_play[19:0];
assign io_SRAM_DQ  = (state_r == S_RECD) ? data_record : 16'dz; // sram_dq as output
assign data_play   = (state_r != S_RECD) ? io_SRAM_DQ : 16'd0; // sram_dq as input

assign o_SRAM_WE_N = (state_r == S_RECD) ? 1'b0 : 1'b1; // write : read
assign o_SRAM_CE_N = 1'b0;
assign o_SRAM_OE_N = 1'b0;
assign o_SRAM_LB_N = 1'b0;
assign o_SRAM_UB_N = 1'b0;

// below is a simple example for module division
// you can design these as you like

// === I2cInitializer ===
// sequentially sent out settings to initialize WM8731 with I2C protocal
I2cInitializer init0(
	.i_rst_n(i_rst_n),
	.i_clk(i_clk_100k),
	.i_start(i2c_start_r),
	.o_finished(i2c_finished),
	.o_sclk(o_I2C_SCLK),
	.o_sdat(i2c_sdat),
	.o_oen(i2c_oen) // you are outputing (you are not outputing only when you are "ack"ing.)
);

// === AudDSP ===
// responsible for DSP operations including fast play and slow play at different speed
// in other words, determine which data addr to be fetch for player 
AudDSP dsp0(
	.i_rst_n(i_rst_n),
	.i_clk(i_AUD_BCLK),
	.i_start(dsp_start_r),
	.i_pause(dsp_pause_r),
	.i_stop(dsp_stop_r),
	// .i_speed(),
	// .i_fast(),
	// .i_slow_0(), // constant interpolation
	// .i_slow_1(), // linear interpolation
	.i_daclrck(i_AUD_DACLRCK),
	.i_sram_data(data_play),
	.o_dac_data(dac_data),
	.o_sram_addr(addr_play)
);

// === AudPlayer ===
// receive data address from DSP and fetch data to sent to WM8731 with I2S protocal
AudPlayer player0(
	.i_rst_n(i_rst_n),
	.i_bclk(i_AUD_BCLK),
	.i_daclrck(i_AUD_DACLRCK),
	.i_en(player_en_r), // enable AudPlayer only when playing audio, work with AudDSP
	.i_pause(player_pause_r),
	.i_dac_data(dac_data), //dac_data
	.o_aud_dacdat(o_AUD_DACDAT)
);

// === AudRecorder ===
// receive data from WM8731 with I2S protocal and save to SRAM
AudRecorder recorder0(
	.i_rst_n(i_rst_n), 
	.i_clk(i_AUD_BCLK),
	.i_lrc(i_AUD_ADCLRCK),
	.i_start(recorder_start_r),
	.i_pause(recorder_pause_r),
	.i_stop(recorder_stop_r),
	.i_data(i_AUD_ADCDAT),
	.o_address(addr_record),
	.o_data(data_record)
);

always_comb begin
	// design your control here
	state_w = state_r;
	i2c_start_w = i2c_start_r;
	recorder_start_w = recorder_start_r;
	recorder_pause_w = recorder_pause_r;
	recorder_stop_w = recorder_stop_r;
	dsp_start_w = dsp_start_r;
	dsp_pause_w = dsp_pause_r;
	dsp_stop_w = dsp_stop_r;
	player_en_w = player_en_r;
	player_pause_w = player_pause_r;
	case(state_r)
		S_IDLE: begin
			if(i_key_0) begin
				state_w = S_I2C;
				i2c_start_w = 1;
			end
		end
		S_I2C: begin
			if(i2c_finished) begin
				state_w = S_RECD;
				recorder_start_w = 1;
				recorder_stop_w = 0;
			end
		end
		S_RECD: begin
			if(i_key_0) begin // stop
				state_w = S_TUNE;
				recorder_stop_w = 1;
				recorder_start_w = 0;
			end
			else if(i_key_1) begin // pause
				state_w = S_RECD_PAUSE;
				recorder_pause_w = 1;
			end
		end      
		S_RECD_PAUSE: begin
			if(i_key_0) begin
				state_w = S_TUNE;
				recorder_pause_w = 0;
				recorder_stop_w = 1;
				recorder_start_w = 0;
			end
			else if(i_key_1) begin
				state_w = S_RECD;
				recorder_pause_w = 0;
			end
		end
		S_TUNE: begin
			if(i_key_0) begin
				state_w = S_PLAY;
				player_en_w = 1;
				dsp_start_w = 1;
			end
		end
		S_PLAY: begin
			if(i_key_0) begin
				state_w = S_IDLE;
				player_en_w = 0;
				dsp_stop_w = 1;
				dsp_start_w = 0;
			end
			else if(i_key_1) begin
				state_w = S_PLAY_PAUSE;
				player_pause_w = 1;
				dsp_pause_w = 1;
			end
		end
		S_PLAY_PAUSE: begin
			if(i_key_0) begin
				state_w = S_IDLE;
				player_en_w = 0;
				player_pause_w = 0;
				dsp_stop_w = 1;
				dsp_start_w = 0;
			end
			else if(i_key_1) begin
				state_w = S_PLAY;
				player_pause_w = 0;
				dsp_pause_w = 0;
			end      
		end
		default: begin
			
		end
	endcase
end

always_ff @(posedge i_clk or negedge i_rst_n) begin
	if (!i_rst_n) begin
		state_r <= S_IDLE;
		i2c_start_r <= 0;
		recorder_start_r <= 0;
		recorder_pause_r <= 0;
		recorder_stop_r <= 0;
		dsp_start_r <= 0;
		dsp_pause_r <= 0;
		dsp_stop_r <= 0;
		player_en_r <= 0;
		player_pause_r <= 0;
	end
	else begin
		state_r <= state_w;
		i2c_start_r <= i2c_start_w;
		recorder_start_r <= recorder_start_w;
		recorder_pause_r <= recorder_pause_w;
		recorder_stop_r <= recorder_stop_w;
		dsp_start_r <= dsp_start_w;
		dsp_pause_r <= dsp_pause_w;
		dsp_stop_r <= dsp_stop_w;
		player_en_r <= player_en_w;
		player_pause_r <= player_pause_w;
	end
end

endmodule