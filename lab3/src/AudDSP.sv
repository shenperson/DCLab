module AudDSP(
	input         i_rst_n,
	input         i_clk,
    input  [19:0] i_len,
	input         i_start,
    input         i_pause,
	input         i_stop,
	input   [3:0] i_speed,
	input         i_fast,
	input         i_slow_0, // constant interpolation
	input         i_slow_1, // linear interpolation
	input         i_daclrck,
	input  [15:0] i_sram_data,
	output [15:0] o_dac_data,
	output [19:0] o_sram_addr
);

typedef enum {
    S_IDLE,
    S_WAIT,
    S_NORM,
    S_FAST,
    S_SLOW_0,
    S_SLOW_1,
    S_PAUSE
} DSP_state;

logic  [2:0] state_r, state_w;
logic        prev_lrck;
logic [15:0] o_dac_data_r, o_dac_data_w;
logic [19:0] o_sram_addr_r, o_sram_addr_w;
logic  [3:0] cnt_slow_0_r, cnt_slow_0_w;
logic  [3:0] cnt_slow_1_r, cnt_slow_1_w;
logic [15:0] diff_r, diff_w;

assign o_dac_data = o_dac_data_r;
assign o_sram_addr = o_sram_addr_r;

always_comb begin
    state_w = state_r;
    o_dac_data_w = o_dac_data_r;
    o_sram_addr_w = o_sram_addr_r;
    cnt_slow_0_w = cnt_slow_0_r;
    cnt_slow_1_w = cnt_slow_1_r;
    diff_w = diff_r;

    case (state_r)
        S_IDLE: begin
            if (i_start) begin
                state_w = S_WAIT;
                o_sram_addr_w = 0;
            end
        end

        S_WAIT: begin
            if (i_stop) begin
                state_w = S_IDLE;
            end
            else if (i_pause) begin
                state_w = S_PAUSE;
            end
            else if (prev_lrck != i_daclrck) begin
                if (i_fast) begin // play fast
                    state_w = S_FAST;
                    cnt_slow_0_w = 0;
                    cnt_slow_1_w = 0;
                end
                else if (i_slow_0) begin // play slow with constant interpolation
                    state_w = S_SLOW_0;
                    cnt_slow_1_w = 0;
                    // why i_speed-1 : speed = 4 means 4 times slower, repeat original data 4 times, then read in new data
                    cnt_slow_0_w = (cnt_slow_0_r < i_speed - 1)? cnt_slow_0_r + 1 : 0; 
                end
                else if (i_slow_1) begin // play slow with linear interpolation
                    state_w = S_SLOW_1;
                    cnt_slow_0_w = 0;
                    // why i_speed-1 : speed = 4 means 4 times slower, interpolate original data 4 times, then read in new data
                    cnt_slow_1_w = (cnt_slow_1_r < i_speed - 1)? cnt_slow_1_r + 1 : 0;
                end
                else begin // play normally
                    state_w = S_NORM;
                    cnt_slow_0_w = 0;
                    cnt_slow_1_w = 0;
                end
            end
        end

        S_NORM: begin
            if (i_stop) begin
                state_w = S_IDLE;
            end
            else if (i_pause) begin
                state_w = S_PAUSE;
            end
            else begin
                state_w = S_PAUSE;
                o_sram_addr_w = (o_sram_addr_r < i_len)? o_sram_addr_r + 1 : 0; // +1 : normal speed
                o_dac_data_w = i_sram_data;
            end
        end

        S_FAST: begin
            if (i_stop) begin
                state_w = S_IDLE;
            end
            else if (i_pause) begin
                state_w = S_PAUSE;
            end
            else begin
                state_w = S_PAUSE;
                o_sram_addr_w = (o_sram_addr_r < i_len - i_speed)? o_sram_addr_r + i_speed : 0; // +i_speed : faster speed
                o_dac_data_w = i_sram_data;
            end
        end

        S_SLOW_0: begin
            if (i_stop) begin
                state_w = S_IDLE;
            end
            else if (i_pause) begin
                state_w = S_PAUSE;
            end
            else begin
                state_w = S_PAUSE;
                // if not, address and data remain the same
                if (cnt_slow_0_r == (i_speed - 1)) begin
                    o_sram_addr_w = (o_sram_addr_r < i_len)? o_sram_addr_r + 1 : 0;
                    o_dac_data_w = i_sram_data;
                end
            end
        end

        S_SLOW_1: begin
            if (i_stop) begin
                state_w = S_IDLE;
            end
            else if (i_pause) begin
                state_w = S_PAUSE;
            end
            else begin
                state_w = S_PAUSE;
                // get the current data
                if (cnt_slow_1_r == 0) begin
                    o_sram_addr_w = (o_sram_addr_r < i_len)? o_sram_addr_r + 1 : 0; // read (current+1) data in next cycle
                    o_dac_data_w = i_sram_data; // output current data
                end
                // use the (current+1) and current data to find difference
                // current data : stored in o_dac_data_r
                // (current+1) data : read in i_sram_data
                else if (cnt_slow_1_r == 1) begin
                    diff_w = ( $signed(i_sram_data) - $signed(o_dac_data_r) ) / $signed(i_speed);
                    o_dac_data_w = $signed(o_dac_data_r) + ( $signed(i_sram_data) - $signed(o_dac_data_r) ) / $signed(i_speed);
                end
                else begin
                    diff_w = diff_r;
                    o_dac_data_w = $signed(o_dac_data_r) + $signed(diff_r);
                end
            end
        end
        
        S_PAUSE: begin
            if (i_stop) begin
                state_w = S_IDLE;
            end 
            if (!i_pause) begin
                if (prev_lrck != i_daclrck) begin
                    state_w = S_WAIT;
                end
            end
        end
    endcase
end

// always_ff @(posedge i_clk or posedge i_rst_n) begin
always_ff @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        state_r <= S_IDLE;
        prev_lrck <= 0;
        o_dac_data_r <= 0;
        o_sram_addr_r <= 0;
        cnt_slow_0_r <= 0;
        cnt_slow_1_r <= 0;
        diff_r <= 0;
    end
    else begin
        state_r <= state_w;
        prev_lrck <= i_daclrck;
        o_dac_data_r <= o_dac_data_w;
        o_sram_addr_r <= o_sram_addr_w;
        cnt_slow_0_r <= cnt_slow_0_w;
        cnt_slow_1_r <= cnt_slow_1_w;
        diff_r <= diff_w;
    end
end

endmodule