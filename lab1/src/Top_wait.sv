module Top (
	input        i_clk,
	input        i_rst_n,
	input        i_start,
	output [3:0] o_random_out
);

// please check out the working example in lab1 README (or Top_exmaple.sv) first


// ===== States =====
parameter S_IDLE = 2'd0;
parameter S_PROC = 2'd1;
parameter S_WAIT = 2'd2;

// ===== Output Buffers =====
logic [3:0] o_random_out_r, o_random_out_w;

// ===== Registers & Wires =====
logic [1:0] state_r, state_w;
logic [3:0] wait_r, wait_w;
logic [3:0] upper_r, upper_w;

// ===== Output Assignments =====
assign o_random_out = o_random_out_r;

// ===== Combinational Circuits =====
always_comb begin
	// Default Values
	o_random_out_w = o_random_out_r;
	state_w        = state_r;
	wait_w		   = wait_r;
	upper_w        = upper_r;

	// FSM
	case(state_r)
	S_IDLE: begin
		if (i_start) begin
			state_w = S_PROC;
			o_random_out_w = 4'd15;
			upper_w = 4'd0;
		end
	end

	S_PROC: begin
		if (i_start) begin
			state_w = (o_random_out_r == 4'd10) ? S_IDLE : S_WAIT;
			o_random_out_w = (o_random_out_r == 4'd10) ? 4'd1 : (o_random_out_r - 4'd1);
		end
	end
	S_WAIT: begin
		if (i_start) begin
			wait_w = (wait_r==upper_r) ? 4'd0 : wait_r + 1;
			state_w = (wait_r==upper_r) ? S_PROC : S_WAIT;
			upper_w = (wait_r==upper_r) ? upper_r + 1 : upper_r;
		end
	end

	endcase
end

// ===== Sequential Circuits =====
always_ff @(posedge i_clk or negedge i_rst_n) begin
	// reset
	if (!i_rst_n) begin
		o_random_out_r <= 4'd0;
		state_r        <= S_IDLE;
		wait_r		   <= 4'd0;
		upper_r		   <= 4'd0;
	end
	else begin
		o_random_out_r <= o_random_out_w;
		state_r        <= state_w;
		wait_r		   <= wait_w;
		upper_r		   <= upper_w;
	end
end

endmodule
