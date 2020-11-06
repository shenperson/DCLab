module I2cSender(
    input        i_rst_n,
	input        i_clk,
	input        i_start,
    input [23:0] i_data,
	output       o_finished,
	output       o_sclk, // SCL
	inout        o_sdat, // SDA
	output       o_oen // you are outputing (you are not outputing only when you are "ack"ing.)
);

parameter S_IDLE     = 0;
parameter S_TRANSIT  = 1;
parameter S_SEND     = 2;
parameter S_ACK      = 3;
parameter S_FINISH   = 4;
parameter S_FINISH_2 = 5;

parameter BIT_CNT_START = 24;

logic [3:0] state_r, state_w;
logic [4:0] bit_cnt_r, bit_cnt_w;

// output registers
logic       o_sclk_r, o_sclk_w;
logic       o_sdat_r, o_sdat_w;
logic       o_oen_r, o_oen_w;
logic       o_finished_r, o_finished_w;

assign o_finished = o_finished_r;
assign o_sclk = o_sclk_r;
assign o_sdat = o_sdat_r;
assign o_oen = o_oen_r;

always_comb begin
    // initialize
    state_w      = state_r;
    bit_cnt_w    = bit_cnt_r;
    o_sclk_w     = o_sclk_r;
    o_sdat_w     = o_sdat_r;
    o_oen_w      = o_oen_r;
    o_finished_w = o_finished_r;

    case (state_r)
        S_IDLE: begin
            if (i_start) begin
                state_w = S_TRANSIT;
                
                // SDA pulls to 0 while SCL stays at 1
                o_sdat_w     = 0;
                o_sclk_w     = 1;
                o_oen_w      = 1;
                o_finished_w = 0;
            end
        end

        S_TRANSIT: begin
            // SDA sets transfer bit when SCL is 0
            o_sclk_w     = 0;
            o_oen_w      = 1;
            o_finished_w = 0;

            // set acknowledge after sending 8 bits
            if (bit_cnt_r == 16 || bit_cnt_r == 8 || bit_cnt_r == 0) begin
                state_w = S_ACK;
            end
            else begin
                state_w = S_SEND;
            end
        end

        S_SEND: begin
            state_w = S_TRANSIT;

            // data is sent when SCL is 1
            o_sdat_w     = i_data[bit_cnt_r - 1];
            o_sclk_w     = 1;
            o_oen_w      = 1;
            o_finished_w = 0;

            bit_cnt_w = bit_cnt_r - 1;
        end

        S_ACK: begin
            if (bit_cnt_r == 0) begin
                state_w = S_FINISH;
            end
            else begin
                state_w = S_SEND;
            end
            
            // Set SDA to high impedance
            o_sdat_w     = 1'bz;
            o_sclk_w     = 1;
            o_oen_w      = 0;
            o_finished_w = 0;

        end
        
        S_FINISH: begin
            // SDA pulls to 1 while SCL stays at 1
            o_sdat_w     = 0;
            o_sclk_w     = 1;
            o_oen_w      = 1;
            o_finished_w = 0;

            state_w   = S_FINISH_2;
            bit_cnt_w = BIT_CNT_START;
        end

        S_FINISH_2: begin
            // SDA pulls to 1 while SCL stays at 1
            o_sdat_w     = 1;
            o_sclk_w     = 1;
            o_oen_w      = 1;
            o_finished_w = 1;

            state_w   = S_IDLE;
        end 
    endcase

end

// always_ff @(posedge i_clk or posedge i_rst_n) begin
always_ff @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
		state_r      <= S_IDLE;
        bit_cnt_r    <= BIT_CNT_START;

        o_sclk_r     <= 1;
        o_sdat_r     <= 1;
        o_oen_r      <= 1;
        o_finished_r <= 0;
	end
	else begin
		state_r      <= state_w;
        bit_cnt_r    <= bit_cnt_w;

        o_sclk_r     <= o_sclk_w;
        o_sdat_r     <= o_sdat_w;
        o_oen_r      <= o_oen_w;
        o_finished_r <= o_finished_w;
	end
end

endmodule