// module AudPlayer(
//     input i_rst_n,
//     input i_bclk,
//     input i_daclrck,
//     input i_en, // enable AudPlayer only when playing audio, work with AudDSP
//     input i_pause,
//     input [15:0] i_dac_data, //dac_data
//     output o_aud_dacdat
// );

// typedef enum {
//     S_IDLE,
//     S_EN,
//     S_WAIT,
//     S_OUT,
//     S_PAUSE
// } AudPlayer_state;

// // logic o_aud_dacdat_n;
// logic [2:0] state, state_n;
// logic       prev_lrck;

// logic [3:0] cnt, cnt_n;
// logic       change;
// logic       aud_dacdat_r, aud_dacdat_w;

// assign change = prev_lrck != i_daclrck;
// assign o_aud_dacdat = aud_dacdat_r;

// always_comb begin
//     cnt_n        = cnt;
// 	aud_dacdat_w = aud_dacdat_r;
//     case (state)
//         S_IDLE: begin
//             state_n = i_en ? S_EN : S_IDLE;
//         end
//         S_EN: begin
//             state_n = change ? S_WAIT : S_EN;
//         end
//         S_WAIT: begin
//             state_n = S_OUT;
//         end
//         S_OUT: begin
//             cnt_n        = i_pause ? cnt : cnt + 1;
//             state_n      = i_pause ? S_PAUSE : (cnt == 15 ? S_EN : S_OUT);
//             aud_dacdat_w = i_daclrck ? i_dac_data[15-cnt] : 0;
//         end
//         S_PAUSE: begin
//             state_n      = i_pause ? S_PAUSE : S_OUT;
//             cnt_n        = i_pause ? cnt : cnt + 1;
//             aud_dacdat_w = i_dac_data[15-cnt];
//         end
//         default: begin
//             state_n = state;
//         end
//     endcase
// end

// // always_ff @(posedge i_bclk or posedge i_rst_n) begin
// always_ff @(posedge i_bclk or negedge i_rst_n) begin
//     if(!i_rst_n) begin
//         prev_lrck <= 0;
//         state <= S_IDLE;
//         cnt <= 0;
// 		aud_dacdat_r <= 0;
//     end
//     else begin
//         prev_lrck <= i_daclrck;
//         state <= state_n;
//         cnt <= cnt_n;
// 		aud_dacdat_r <= aud_dacdat_w;
//     end
// end

// endmodule
module AudPlayer(
    input i_rst_n,
    input i_bclk,
    input i_daclrck,
    input i_en, // enable AudPlayer only when playing audio, work with AudDSP
    input i_pause,
    input [15:0] i_dac_data, //dac_data
    output o_aud_dacdat
);

typedef enum {
    S_IDLE,
    S_EN,
    // S_WAIT,
    S_OUT_L,
    S_OUT_R
    // S_PAUSE
} AudPlayer_state;

// logic o_aud_dacdat_n;
logic [2:0] state, state_n;
logic prev_lrck;

logic [4:0]cnt, cnt_n;
logic change;
logic aud_dacdat_r, aud_dacdat_w;
logic [15:0] get_data_r, get_data_w;
logic [15:0] send_data_r, send_data_w;
assign change = prev_lrck!=i_daclrck;
assign o_aud_dacdat = aud_dacdat_r;

always_comb begin
    aud_dacdat_w = aud_dacdat_r;
    state_n = state;
    get_data_w = get_data_r;
    send_data_w = send_data_r;
    cnt_n = cnt;
    case (state)
        S_IDLE: begin
            state_n = i_en ? S_EN : S_IDLE;
            get_data_w = i_en ? i_dac_data : 0;
        end 
        S_EN: begin
            if(!i_daclrck && i_en) begin
                state_n = S_OUT_L;
                cnt_n = 0;
                send_data_w = get_data_r;
                aud_dacdat_w = get_data_r[15];
            end
        end
        S_OUT_L: begin
            if(!i_daclrck) begin
                state_n = S_OUT_L;
                cnt_n = cnt==16 ? cnt : cnt+1;
                aud_dacdat_w = cnt==16 ? 0 : send_data_r[15-cnt];
            end
            else begin
                aud_dacdat_w = get_data_r[15];
                state_n = S_OUT_R;
                cnt_n = 0;
            end
        end
        S_OUT_R: begin
            if(i_daclrck) begin
                state_n = S_OUT_R;
                cnt_n = cnt==16 ? cnt : cnt+1;
                aud_dacdat_w = cnt==16 ? 0 : send_data_r[15-cnt];
            end
            else begin
                send_data_w = get_data_r;
                aud_dacdat_w = get_data_r[15];
                state_n = S_OUT_L;
                cnt_n = 0;
            end
            get_data_w = i_en ? i_dac_data : get_data_r;
        end
        default: begin
            state_n = state;
        end
    endcase
end

// always_ff @(posedge i_bclk or posedge i_rst_n) begin
always_ff @(posedge i_bclk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        prev_lrck <= 0;
        state <= S_IDLE;
        cnt <= 0;
		aud_dacdat_r <= 0;
        get_data_r <= 0;
        send_data_r <= 0;
    end
    else begin
        prev_lrck <= i_daclrck;
        state <= state_n;
        cnt <= cnt_n;
		aud_dacdat_r <= aud_dacdat_w;
        get_data_r <= get_data_w;
        send_data_r <= send_data_w;
    end
end

endmodule
