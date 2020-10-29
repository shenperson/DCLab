module I2cInitializer (
    input       i_rst_n,
	input       i_clk,
	input       i_start,
    input [2:0] i_op, // operation to initialize
	output      o_finished,
	output      o_sclk, // SCL
	output      o_sdat, // SDA
	output      o_oen // you are outputing (you are not outputing only when you are "ack"ing.)
);

// state
parameter S_IDLE   = 0;
parameter S_SEND   = 1;

// different operations
parameter OP_RESET = 0;
parameter OP_AAPC  = 1;
parameter OP_DAPC  = 2;
parameter OP_PDC   = 3;
parameter OP_DAIF  = 4;
parameter OP_SC    = 5;
parameter OP_AC    = 6;

// initialize data
parameter BIT_RESET = 24'b0011_0100_000_1111_0_0000_0000;
parameter BIT_AAPC  = 24'b0011_0100_000_0100_0_0001_0101;
parameter BIT_DAPC  = 24'b0011_0100_000_0101_0_0000_0000;
parameter BIT_PDC   = 24'b0011_0100_000_0110_0_0000_0000;
parameter BIT_DAIF  = 24'b0011_0100_000_0111_0_0100_0010;
parameter BIT_SC    = 24'b0011_0100_000_1000_0_0001_1001;
parameter BIT_AC    = 24'b0011_0100_000_1001_0_0000_0001;

logic state_r, state_w;
logic [23:0] i_data;

I2cSender i2cs (
    .i_rst_n(i_rst_n),
	.i_clk(i_clk),
	.i_start(i_start),
    .i_data(i_data),
	.o_finished(o_finished),
	.o_sclk(o_sclk), // SCL
	.o_sdat(o_sdat), // SDA
	.o_oen(o_oen)
);

// FSM
always_comb begin
    // initialize
    state_w = state_r;
    i_data = BIT_RESET;

    case (state_r)
        S_IDLE: begin
            state_w = (i_start)? S_SEND : S_IDLE;
        end

        S_SEND: begin
            state_w = (o_finished)? S_IDLE : S_SEND;

            i_data = (i_op == OP_RESET)? BIT_RESET :
                     (i_op == OP_AAPC)? BIT_AAPC :
                     (i_op == OP_DAPC)? BIT_DAPC :
                     (i_op == OP_PDC)? BIT_PDC :
                     (i_op == OP_DAIF)? BIT_DAIF :
                     (i_op == OP_SC)? BIT_SC :
                     (i_op == OP_AC)? BIT_AC : BIT_RESET;
        end
    endcase
end

always_ff @(posedge i_clk or posedge i_rst_n) begin
	if (!i_rst_n) begin
		state_r <= S_IDLE;
	end
	else begin
		state_r <= state_w;
	end
end

endmodule