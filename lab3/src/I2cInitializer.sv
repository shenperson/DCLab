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
parameter S_FINISH = 2;

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

logic [1:0] state_r, state_w;
// logic [4:0] bit_cnt_r, bit_cnt_w; // bit 23 ~ 0
// logic [7:0] init_data [0:21];

// // Reset : 0011_0100_000_1111_0_0000_0000
// assign init_data[0] = 8'b0011_0100;
// assign init_data[1] = 8'b000_1111_0;
// assign init_data[2] = 8'b0000_0000;

// // Analogue Audio Path Control : 0011_0100_000_0100_0_0001_0101
// assign init_data[3] = 8'b0011_0100;
// assign init_data[4] = 8'b000_0100_0;
// assign init_data[5] = 8'b0001_0101;

// // Digital Audio Path Control : 0011_0100_000_0101_0_0000_0000
// assign init_data[6] = 8'b0011_0100;
// assign init_data[7] = 8'b000_0101_0;
// assign init_data[8] = 8'b0000_0000;

// // Power Down Control : 0011_0100_000_0110_0_0000_0000
// assign init_data[9] = 8'b0011_0100;
// assign init_data[10] = 8'b000_0110_0;
// assign init_data[11] = 8'b0000_0000;

// // Digital Audio Interface Format : 0011_0100_000_0111_0_0100_0010
// assign init_data[12] = 8'b0011_0100;
// assign init_data[13] = 8'b000_0111_0;
// assign init_data[14] = 8'b0100_0010;

// // Sampling Control : 0011_0100_000_1000_0_0001_1001
// assign init_data[15] = 8'b0011_0100;
// assign init_data[16] = 8'b000_1000_0;
// assign init_data[17] = 8'b0001_1001;

// // Active Control : 0011_0100_000_1001_0_0000_0001
// assign init_data[18] = 8'b0011_0100;
// assign init_data[19] = 8'b000_1001_0;
// assign init_data[20] = 8'b0000_0001;

// FSM
always_comb begin
    // initialize
    state_w = state_r;
    bit_cnt_w = bit_cnt_r;

    case (state_r)
        S_IDLE: begin
            state_w = (i_start)? S_SEND : S_IDLE;
        end

        S_SEND: begin
            

        S_FINISH: begin
            state_w = S_IDLE;
            bit_cnt_w = 31;
        end
        default: 
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