module Top (
	input        i_clk,
	input        i_rst_n,
	// start generating random number
	input        i_start,
	// stop at given number while generating
	input		 i_stop,
	output [3:0] o_random_out_0,
	// the 3 previous random values
	output [3:0] o_random_out_1,
	output [3:0] o_random_out_2,
	output [3:0] o_random_out_3
);

// ===== States =====
parameter S_IDLE = 2'd0;
parameter S_PROC = 2'd1;
parameter S_WAIT = 2'd2;

// parameter for random number generation
parameter M = 16'd40000;
parameter A = 16'd41;
parameter B = 16'd13;

// simulation speed
parameter speed = 32'd3000000;

// ===== Output Buffers =====
logic [15:0] o_random_out, o_random_out_n;

// ===== Registers & Wires =====
logic [1:0]  state, state_n;
logic [31:0] delay, delay_n;
logic [31:0] upper, upper_n;
logic [5:0]  cnt, cnt_n;
logic [15:0] product;
logic [3:0] history[0:2], history_n[0:2];

// ===== Output Assignments =====
assign o_random_out_0 = o_random_out[3:0];
assign o_random_out_1 = history[0];
assign o_random_out_2 = history[1];
assign o_random_out_3 = history[2];
assign product = (o_random_out * A + B) % M;

// ===== Combinational Circuits =====
always_comb begin
	// Default Values
	o_random_out_n = o_random_out;
	state_n        = state;
	delay_n		   = delay;
	upper_n        = upper;
	cnt_n          = cnt;
	history_n[0]   = history[0];
	history_n[1]   = history[1];
	history_n[2]   = history[2];

	// FSM
	case(state)
		S_IDLE: begin
			if (i_start) begin
				state_n = S_PROC;
				o_random_out_n = product;
				upper_n = 32'd0;
				cnt_n = 0;
				history_n[0] = o_random_out;
				history_n[1] = history[0];
				history_n[2] = history[1];
			end
		end

		S_PROC: begin
			state_n = (cnt == 4'd11 || i_stop) ? S_IDLE : S_WAIT;
			o_random_out_n = product;
			cnt_n = cnt + 1;
		end

		S_WAIT: begin
			delay_n  = (delay == upper || i_stop) ? 4'd0 : delay + 1;
			state_n = (i_stop) ? S_IDLE :
					  (delay == upper) ? S_PROC : S_WAIT;
			upper_n = (delay == upper) ? upper + speed : upper;
		end
	endcase
end

// ===== Sequential Circuits =====
always_ff @(posedge i_clk or negedge i_rst_n) begin
	// reset
	if (!i_rst_n) begin
		o_random_out <= 4'd0;
		state        <= S_IDLE;
		delay		 <= 32'd0;
		upper		 <= 32'd15000000;
		cnt		     <= 0;
		history[0]	   <= 0;
		history[1]	   <= 0;
		history[2]	   <= 0;
	end
	else begin
		o_random_out <= o_random_out_n;
		state        <= state_n;
		delay		 <= delay_n;
		upper		 <= upper_n;
		cnt          <= cnt_n;
		history[0]	   <= history_n[0];
		history[1]	   <= history_n[1];
		history[2]	   <= history_n[2];
	end
end

endmodule

