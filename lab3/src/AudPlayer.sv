module AudPlayer(
    input i_rst_n,
    input i_bclk,
    input i_daclrck,
    input i_en, // enable AudPlayer only when playing audio, work with AudDSP
    input i_pause,
    input [15:0] i_dac_data, //dac_data
    output reg o_aud_dacdat
);

typedef enum {
    S_IDLE,
    S_EN,
    S_WAIT,
    S_OUT,
    S_PAUSE
} AudPlayer_state;

// logic o_aud_dacdat_n;
logic [2:0] state, state_n;
logic prev_lrck;

logic [3:0]cnt, cnt_n;
logic change;
assign change = prev_lrck!=i_daclrck;

always_comb begin
    cnt_n = cnt;
    o_aud_dacdat = 0;
    case (state)
        S_IDLE: begin
            state_n = i_en ? S_EN : S_IDLE;
        end
        S_EN: begin
            state_n = change ? S_WAIT : S_EN; 
        end
        S_WAIT:begin
            state_n = S_OUT;
        end
        S_OUT: begin
            cnt_n = i_pause ? cnt : cnt + 1;
            state_n = i_pause ? S_PAUSE : (cnt==15 ? S_EN : S_OUT);
            o_aud_dacdat = i_dac_data[15-cnt];
        end
        S_PAUSE: begin
            state_n = i_pause ? S_PAUSE : S_OUT;
            cnt_n = i_pause ? cnt : cnt + 1;
            o_aud_dacdat = i_dac_data[15-cnt];
        end
        default:begin
            state_n = state;
        end
    endcase
end

always_ff @(posedge i_bclk or posedge i_rst_n) begin
    if(!i_rst_n) begin
        prev_lrck <= 0;
        state <= S_IDLE;
        cnt <= 0;
    end
    else begin
        prev_lrck <= i_daclrck;
        state <= state_n;
        cnt <= cnt_n;
    end
end

endmodule
