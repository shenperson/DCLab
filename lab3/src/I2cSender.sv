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

parameter S_IDLE = 0;
parameter S_TRANSIT = 1;
parameter S_SEND = 2;
parameter S_ACK = 3;
parameter S_FINISH = 4;

logic [1:0] state_r, state_w;
logic [4:0] bit_cnt_r, bit_cnt_w;

// output registers
logic o_sclk_r, o_sclk_w;
logic o_sdat_r, o_sdat_w;
logic o_oen_r, o_oen_w;
logic o_finished_r, o_finished_w;

always_comb begin
    // initialize
    state_w = state_r;
    bit_cnt_w = bit_cnt_r;
    o_sclk_w = o_sclk_r;
    o_sdat_w = o_sdat_r;
    o_oen_w = o_oen_r;

    case (state_r)
        S_IDLE: begin
            if (i_start) begin
                state_w = S_TRANSIT;
                // SDA pulls to 0 while SCL stays at 1
                o_sdat_w = 0;
                o_sclk_w = 1;
            end
        end

        S_TRANSIT: begin
            // SDA sets transfer bit when SCL is 0
            bit_cnt_w = bit_cnt_r + 1;
            o_sdat_w = i_data[bit_cnt_r];
            o_sclk_w = 0;
        end

        S_SEND: begin
            // data is sent when SCL is 1
        end

        S_ACK: begin
            // Set SDA to high impedance
            o_sdat_w = 1'bz;
        end
        
        S_FINISH: begin
            // SDA pulls to 1 while SCL stays at 1
        end 
    endcase

end

always_ff @(posedge i_clk or posedge i_rst_n) begin
    if (!i_rst_n) begin
		state_r <= S_IDLE;
        bit_cnt_r <= 23;

        o_sclk_r <= 1;
        o_sdat_r <= 1;
        o_oen_r <= 1;
        o_finished_r <= 0;
	end
	else begin
		state_r <= state_w;
        bit_cnt_r <= bit_cnt_w;

        o_sclk_r <= o_sclk_w;
        o_sdat_r <= o_sdat_w;
        o_oen_r <= o_oen_w;
        o_finished_r <= o_finished_w;
	end
end

endmodule