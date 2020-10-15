module Rsa256Core (
	input          i_clk,
	input          i_rst,
	input          i_start,
	input  [255:0] i_a, // cipher text y
	input  [255:0] i_d, // private key
	input  [255:0] i_n,
	output [255:0] o_a_pow_d, // plain text x
	output         o_finished
);

// operations for RSA256 decryption
// namely, the Montgomery algorithm
parameter S_IDLE = 3'd0;
parameter S_PREP = 3'd1;
parameter S_MONT = 3'd2;
parameter S_CALC = 3'd3;
parameter S_DONE = 3'd4;

logic   [2:0] state, state_n;
logic         finished, finished_n;
logic [255:0] y, y_n;
logic         prep_start, prep_start_n;
logic         mont_start, mont_start_n;
logic   [8:0] counter, counter_n;
logic [255:0] t, t_n;
logic [255:0] m, m_n;
logic [255:0] m_update, m_update_n;
logic [255:0] t_square, t_square_n;
logic         prep_done, mont_done, mont_done_m, mont_done_t;
logic [255:0] t_start;

assign o_finished = finished;
assign o_a_pow_d = m;
assign mont_done = mont_done_m & mont_done_t;

RsaPrep rsa_prep_0(
	.i_clk(i_clk),
	.N({1'b0, i_n}),
	.a({1'b1, {256{1'b0}}}),
	.b({1'b0, y}),
	.k(9'd256),
	.i_start(prep_start),
	.o_m(t_start),
	.o_finished(prep_done)
);

RsaMont rsa_mont_0(
	.i_clk(i_clk),
	.N(i_n),
	.a(m),
	.b(t),
	.i_start(mont_start),
	.o_m(m_update_n),
	.o_finished(mont_done_m)
);

RsaMont rsa_mont_1(
	.i_clk(i_clk),
	.N(i_n),
	.a(t),
	.b(t),
	.i_start(mont_start),
	.o_m(t_square_n),
	.o_finished(mont_done_t)
);

always_comb begin
	state_n = state;
	finished_n = finished;
	y_n = y;
	prep_start_n = prep_start;
	mont_start_n = mont_start;
	counter_n = counter;
	t_n = t;
	m_n = m;
	case(state)
		S_IDLE: begin
			if (i_start) begin
				state_n = S_PREP;
				y_n = i_a;
				prep_start_n = 1'b1;
			end
		end
		S_PREP: begin
			if (prep_done) begin
				state_n = S_MONT;
				prep_start_n = 1'b0;
				mont_start_n = 1'b1;
				t_n = t_start;
				m_n = 1;
				counter_n = 9'b0;
			end
		end
		S_MONT: begin
			if (mont_done) begin
				mont_start_n = 1'b0;
				state_n = S_CALC;
			end
		end
		S_CALC: begin
			if (counter <= 255) begin
				counter_n = counter + 1;
				state_n = S_MONT;
				mont_start_n = 1'b1;
				if (i_d[counter]) begin
					m_n = m_update;
				end
				t_n = t_square;
			end
			else begin
				state_n = S_DONE;
				finished_n = 1'b1;
			end
		end
		S_DONE: begin
			state_n = S_IDLE;
			finished_n = 1'b0;
		end
		default: begin
			
		end
	endcase
end
always_ff @(posedge i_clk or negedge i_rst) begin
	if (i_rst) begin
		state      <= S_IDLE;
		finished   <= 1'b0;
		y          <= 256'd0;
		prep_start <= 1'b0;
		mont_start <= 1'b0;
		counter    <= 9'b0;
		t          <= 256'd0;
		m          <= 256'd0;
		m_update   <= 256'd0;
		t_square   <= 256'd0;
	end
	else begin
		state      <= state_n;
		finished   <= finished_n;
		y          <= y_n;
		prep_start <= prep_start_n;
		mont_start <= mont_start_n;
		counter    <= counter_n;
		t          <= t_n;
		m          <= m_n;
		m_update   <= m_update_n;
		t_square   <= t_square_n;
	end
end
endmodule

module RsaPrep (
	input         i_clk,
	input [256:0] N,
	input [256:0] a,
	input [256:0] b,
	input   [8:0] k,
	input         i_start,
	output [255:0] o_m,
	output         o_finished
);

parameter S_IDLE = 1'b0;
parameter S_CALC = 1'b1;

logic         state, state_n;
logic [256:0] t, t_n;
logic 	[8:0] bit_cnt, bit_cnt_n;
logic [256:0] m, m_n;
logic [256:0] sum;
logic [256:0] t_d;
logic         finished, finished_n;

assign t_d = t << 1;
assign o_m = m[255:0];
assign o_finished = finished;

always_comb begin
	state_n = state;
	t_n = t;
	bit_cnt_n = bit_cnt;
	m_n = m;
	sum = 0;
	finished_n = finished;
	case(state)
		S_IDLE: begin
			state_n = S_CALC;
			t_n = b;
			bit_cnt_n = 0;
			m_n = 0;
		end
		S_CALC: begin
			if (bit_cnt <= k) begin
				bit_cnt_n = bit_cnt + 1;
				if (a[bit_cnt]) begin
					sum = m + t;
					m_n = (sum >= N)? sum - N : sum;
				end
				t_n = (t_d >= N)? t_d - N : t_d;
			end
			else begin
				state_n = S_IDLE;
				finished_n = 1'b1;
			end
		end
		default: begin
		end
	endcase
end
always_ff @(posedge i_clk) begin
	if(i_start) begin
		state    <= state_n;
		t        <= t_n;
		bit_cnt  <= bit_cnt_n;
		m        <= m_n;
		finished <= finished_n; 
	end
	else begin
		state    <= 0;
		t        <= 0;
		bit_cnt  <= 0;
		m        <= 0;
		finished <= 0; 
	end
end
endmodule

module RsaMont (
	input         i_clk,
	input [255:0] N,
	input [255:0] a,
	input [255:0] b,
	input         i_start,
	output [255:0] o_m,
	output         o_finished
);

parameter S_IDLE = 1'b0;
parameter S_CALC = 1'b1;

parameter k = 9'd255;

logic         state, state_n;
logic   [8:0] bit_cnt, bit_cnt_n;
logic [299:0] m, m_n;
logic         finished, finished_n;
logic [299:0] sum, sum2;

assign o_m = m[255:0];
assign o_finished = finished;

always_comb begin
	state_n = state;
	bit_cnt_n = bit_cnt;
	m_n = m;
	finished_n = finished;
	sum = 0;
	sum2 = 0;
	case(state)
		S_IDLE: begin
			state_n = S_CALC;
			bit_cnt_n = 0;
			m_n = 0;
		end
		S_CALC: begin
			if (bit_cnt <= 255) begin
				bit_cnt_n = bit_cnt + 1;
				if (a[bit_cnt]) begin
					sum = m + {44'd0, b};
				end
				else begin
					sum = m;
				end
				if (sum[0]) begin
					sum2 = sum + N;
				end
				else begin
					sum2 = sum;
				end
				m_n = sum2 >> 1;
			end
			else begin
				state_n = S_IDLE;
				finished_n = 1'b1;
				if (m >= N) begin
					m_n = m - N;
				end
			end
		end
		default: begin
		end
	endcase
end
always_ff @(posedge i_clk) begin
	if(i_start) begin
		state    <= state_n;
		bit_cnt  <= bit_cnt_n;
		m        <= m_n;
		finished <= finished_n; 
	end
	else begin
		state    <= 0;
		bit_cnt  <= 0;
		m        <= 0;
		finished <= 0; 
	end
end
endmodule
