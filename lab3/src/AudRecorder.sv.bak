module AudRecorder(
	input         i_rst_n, 
	input         i_clk,
	input         i_lrc,
	input         i_start,
	input         i_pause,
	input         i_stop,
	input         i_data,
	output [19:0] o_address,
	output [15:0] o_data
);

typedef enum {
    S_IDLE,
    S_PROC,
    S_WAIT,
    S_PAUSE
} Recorder_state;

logic  [2:0] state_r, state_w;
logic  [4:0] cnt_r, cnt_w;
logic [19:0] addr_r, addr_w;
logic [15:0] data_r, data_w;

assign o_address = addr_r;
assign o_data = data_r;

always_comb begin
    state_w = state_r;
    cnt_w = cnt_r;
    addr_w = addr_r;
    data_w = data_r;
    case(state_r)
        S_IDLE: begin
            if(i_start) begin
                state_w = S_PAUSE;
                addr_w = 0;
                cnt_w = 0;
            end
        end
        S_PROC: begin
            if(i_stop) begin
                state_w = S_IDLE;
            end
            else if(i_pause) begin
                state_w = S_PAUSE;
            end
            else if(cnt_r < 16) begin
                data_w[15-cnt_r] = i_data;
                cnt_w = cnt_r + 1;
            end
            else if(i_lrc) begin
                state_w = S_WAIT;
            end
        end
        S_WAIT: begin
            if(i_stop) begin
                state_w = S_IDLE;
            end
            else if(i_pause) begin
                state_w = S_PAUSE;
            end
            else if(!i_lrc) begin
               state_w = S_PROC; 
               cnt_w = 0;
            end
        end
        S_PAUSE: begin
            if(i_stop) begin
                state_w = S_IDLE;
            end
            else if(!i_pause) begin
                if(i_lrc) begin
                    state_w = S_WAIT; 
                end
                else begin
                    state_w = S_PROC;
                    data_w[15-cnt_r] = i_data;
                    cnt_w = cnt_r + 1;
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
        cnt_r <= 0;
        addr_r <= 0;
        data_r <= 0;
    end
    else begin
        state_r <= state_w;
        cnt_r <= cnt_w;
        addr_r <= addr_w;
        data_r <= data_w;
    end
end

endmodule