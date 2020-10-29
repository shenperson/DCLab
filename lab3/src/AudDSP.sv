module AudDSP(
	input         i_rst_n,
	input         i_clk,
	input         i_start,
    input         i_pause,
	input         i_stop,
	// input         i_speed,
	// input         i_fast,
	// input         i_slow_0, // constant interpolation
	// input         i_slow_1, // linear interpolation
	input         i_daclrck,
	input  [15:0] i_sram_data,
	output [15:0] o_dac_data,
	output [19:0] o_sram_addr
);

typedef enum {
    S_IDLE,
    S_PLAY,
    S_WAIT,
    S_PAUSE
} DSP_state;

logic  [2:0] state_r, state_w;
logic [19:0] o_dac_data_r, o_dac_data_w;
logic [15:0] o_sram_addr_r, o_sram_addr_w;

assign o_dac_data = o_dac_data_r;
assign o_sram_addr = o_sram_addr_r;

always_comb begin
    state_w = state_r;
    o_dac_data_w = o_dac_data_r;
    o_sram_addr_w = o_sram_addr_r;
    case(state_r)
        S_IDLE: begin
            if(i_start) begin
                state_w = S_PAUSE;
                o_sram_addr_w = 0;
            end
        end
        S_PLAY: begin
            if(i_stop) begin
                state_w = S_IDLE;
            end
            else if(i_pause) begin
                state_w = S_PAUSE;
            end
            else if(i_daclrck) begin
                state_w = S_WAIT;
                o_sram_addr_w = o_sram_addr_r + 1;
            end
        end
        S_WAIT: begin
            if(i_stop) begin
                state_w = S_IDLE;
            end
            else if(i_pause) begin
                state_w = S_PAUSE;
            end
            else if(!i_daclrck) begin
                state_w = S_WAIT;
                o_dac_data_w = i_sram_data;
            end
        end
        S_PAUSE: begin
            if(i_stop) begin
                state_w = S_IDLE;
            end if(!i_pause) begin
                if(i_daclrck) begin
                    state_w = S_WAIT;
                end
                else begin
                    state_w = S_PLAY;
                end
            end
        end
        default: begin
            
        end
    endcase
end

always_ff @(posedge i_clk or posedge i_rst_n) begin
    if(!i_rst_n) begin
        state_r <= S_IDLE;
        o_dac_data_r <= 0;
        o_sram_addr_r <= 0;
    end
    else begin
        state_r <= state_w;
        o_dac_data_r <= o_dac_data_w;
        o_sram_addr_r <= o_sram_addr_w;
    end
end

endmodule