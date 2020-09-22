// module Top (
// 	input        i_clk,
// 	input        i_rst_n,
// 	input        i_start,
// 	output [3:0] o_random_out
// );

// // please check out the working example in lab1 README (or Top_exmaple.sv) first


// // ===== States =====
// parameter S_IDLE = 1'b0;
// parameter S_PROC = 1'b1;

// // ===== Output Buffers =====
// logic [3:0] o_random_out_r, o_random_out_w;

// // ===== Registers & Wires =====
// logic state_r, state_w;
// logic [3:0] gen_out;

// // ===== Output Assignments =====
// assign o_random_out = o_random_out_r;

// // ===== Combinational Circuits =====
// RANDOM_GEN random_gen0(
// 	.i_clk(i_clk),
// 	.i_rst_n(i_rst_n),
// 	.o_random_out(gen_out)
// );
// always_comb begin
// 	// Default Values
// 	o_random_out_w = o_random_out_r;
// 	state_w        = state_r;

// 	// FSM
// 	case(state_r)
// 	S_IDLE: begin
// 		if (i_start) begin
// 			state_w = S_PROC;
// 			o_random_out_w = 4'd15;
// 		end
// 	end

// 	S_PROC: begin
// 		if (i_start) begin
// 			state_w = (o_random_out_r == 4'd10) ? S_IDLE : state_w;
// 			o_random_out_w = (o_random_out_r == 4'd10) ? 4'd1 : gen_out;
// 		end
// 	end

// 	endcase
// end

// // ===== Sequential Circuits =====
// always_ff @(posedge i_clk or negedge i_rst_n) begin
// 	// reset
// 	if (!i_rst_n) begin
// 		o_random_out_r <= 4'd0;
// 		state_r        <= S_IDLE;
// 	end
// 	else begin
// 		o_random_out_r <= o_random_out_w;
// 		state_r        <= state_w;
// 	end
// end

// endmodule

// module RANDOM_GEN(
// 	input        i_clk,
// 	input        i_rst_n,
// 	output [3:0] o_random_out
// );
// parameter S_IDLE = 1'b0;
// parameter S_PROC = 1'b1;
// parameter M = 8'd16;
// parameter A = 8'd9;
// parameter B = 8'd15;
// logic state_r, state_w;
// logic [7:0] o_random_out_r, o_random_out_w;
// logic [7:0] product;
// assign o_random_out = o_random_out_r[3:0];
// assign product = ((o_random_out_r << 3) + o_random_out_r + B) & 8'd15;
// // ===== Combinational Circuits =====
// always_comb begin
// 	o_random_out_w = o_random_out_r;
// 	state_w        = state_r;

// 	case(state_r)
// 	S_IDLE: begin
// 		state_w = S_PROC;
// 		o_random_out_w = product;
// 	end

// 	S_PROC: begin
// 		o_random_out_w = product;
// 	end

// 	endcase
// end
// // ===== Sequential Circuits =====
// always_ff @(posedge i_clk or negedge i_rst_n) begin
// 	if (!i_rst_n) begin
// 		o_random_out_r <= 4'd0;
// 		state_r        <= S_IDLE;
// 	end
// 	else begin
// 		o_random_out_r <= o_random_out_w;
// 		state_r        <= state_w;
// 	end
// end

// endmodule

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


parameter M = 16'd40000;
parameter A = 16'd41;
parameter B = 16'd13;


// ===== Output Buffers =====
logic [15:0] o_random_out_r, o_random_out_w;

// ===== Registers & Wires =====
logic [1:0] state_r, state_w;
logic [31:0] wait_r, wait_w;
logic [31:0] upper_r, upper_w;
logic [5:0] cnt_r, cnt_w;
logic [15:0] product;

// ===== Output Assignments =====
assign o_random_out = o_random_out_r[3:0];
assign product = (o_random_out_r * A + B) % M;

// ===== Combinational Circuits =====
always_comb begin
	// Default Values
	o_random_out_w = o_random_out_r;
	state_w        = state_r;
	wait_w		   = wait_r;
	upper_w        = upper_r;
	cnt_w          = cnt_r;

	// FSM
	case(state_r)
	S_IDLE: begin
		if (i_start) begin
			state_w = S_PROC;
			o_random_out_w = product;
			upper_w = 32'd0;
			cnt_w = 0;
		end
	end

	S_PROC: begin
		
		state_w = (cnt_r == 4'd11) ? S_IDLE : S_WAIT;
		o_random_out_w = product;
		cnt_w = cnt_r + 1;
		
	end
	S_WAIT: begin
		wait_w = (wait_r==upper_r) ? 4'd0 : wait_r + 1;
		state_w = (wait_r==upper_r) ? S_PROC : S_WAIT;
		upper_w = (wait_r==upper_r) ? upper_r + 32'd3000000 : upper_r;
	end

	endcase
end

// ===== Sequential Circuits =====
always_ff @(posedge i_clk or negedge i_rst_n) begin
	// reset
	if (!i_rst_n) begin
		o_random_out_r <= 4'd0;
		state_r        <= S_IDLE;
		wait_r		   <= 32'd0;
		upper_r		   <= 32'd15000000;
		cnt_r		   <= 0;
	end
	else begin
		o_random_out_r <= o_random_out_w;
		state_r        <= state_w;
		wait_r		   <= wait_w;
		upper_r		   <= upper_w;
		cnt_r          <= cnt_w;
	end
end

endmodule
