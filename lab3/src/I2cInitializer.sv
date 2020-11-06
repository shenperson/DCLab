module I2cInitializer (
    input       i_rst_n,
	input       i_clk,
	input       i_start,
	output      o_finished,
	output      o_sclk, // SCL
	output      o_sdat, // SDA
	output      o_oen // you are outputing (you are not outputing only when you are "ack"ing.)
);

// state
parameter S_IDLE   = 0;
parameter S_PREP   = 1;
parameter S_SEND   = 2;
parameter S_FINISH = 3;

// initialize data
parameter BIT_RESET = 24'b0011_0100_000_1111_0_0000_0000;
parameter BIT_AAPC  = 24'b0011_0100_000_0100_0_0001_0101;
parameter BIT_DAPC  = 24'b0011_0100_000_0101_0_0000_0000;
parameter BIT_PDC   = 24'b0011_0100_000_0110_0_0000_0000;
parameter BIT_DAIF  = 24'b0011_0100_000_0111_0_0100_0010;
parameter BIT_SC    = 24'b0011_0100_000_1000_0_0001_1001;
parameter BIT_AC    = 24'b0011_0100_000_1001_0_0000_0001;

logic [1:0]  state_r, state_w;
logic        sender_start_r, sender_start_w;
logic [23:0] sender_data_r, sender_data_w;
logic        sender_finished;

logic [2:0]  data_cnt_r, data_cnt_w;
logic o_finished_r, o_finished_w;

assign o_finished = o_finished_r;

I2cSender i2cs (
    .i_rst_n(i_rst_n),
	.i_clk(i_clk),
	.i_start(sender_start_r),
    .i_data(sender_data_r),
	.o_finished(sender_finished),
	.o_sclk(o_sclk), // SCL
	.o_sdat(o_sdat), // SDA
	.o_oen(o_oen)
);

// FSM
always_comb begin
    // initialize
    state_w = state_r;
    data_cnt_w = data_cnt_r;
    sender_start_w = sender_start_r;
    sender_data_w = sender_data_r;
    o_finished_w = o_finished_r;

    case (state_r)
        S_IDLE: begin
            if (i_start) begin
                state_w = S_PREP;
            end
        end

        S_PREP: begin
            if (data_cnt_r == 7) begin
                state_w = S_FINISH;
            end
            else begin
                state_w = S_SEND;
                sender_start_w = 1;
                case (data_cnt_r)
                    0:       sender_data_w = BIT_RESET;
                    1:       sender_data_w = BIT_AAPC;
                    2:       sender_data_w = BIT_DAPC;
                    3:       sender_data_w = BIT_PDC;
                    4:       sender_data_w = BIT_DAIF;
                    5:       sender_data_w = BIT_SC;
                    6:       sender_data_w = BIT_AC;
                    default: sender_data_w = BIT_RESET;
                endcase
                data_cnt_w = data_cnt_r + 1;
            end
        end

        S_SEND: begin
            if (sender_finished) begin
                state_w = S_PREP;
                sender_start_w = 0;
            end
        end

        S_FINISH: begin
            o_finished_w = 1;
            state_w = S_IDLE;
            sender_start_w = 0;
            sender_data_w = 0;
        end
    endcase
end

// always_ff @(posedge i_clk or posedge i_rst_n) begin
always_ff @(posedge i_clk or negedge i_rst_n) begin
	if (!i_rst_n) begin
		state_r        <= S_IDLE;
        sender_start_r <= 0;
        sender_data_r  <= BIT_RESET;
        data_cnt_r     <= 0;
        o_finished_r   <= 0;
	end
	else begin
		state_r        <= state_w;
        sender_start_r <= sender_start_w;
        sender_data_r  <= sender_data_w;
        data_cnt_r     <= data_cnt_w;
        o_finished_r   <= o_finished_w;
	end
end

endmodule