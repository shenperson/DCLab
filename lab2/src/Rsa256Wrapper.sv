module Rsa256Wrapper (
    input         avm_rst,
    input         avm_clk,
    output  [4:0] avm_address,
    output        avm_read,
    input  [31:0] avm_readdata,
    output        avm_write,
    output [31:0] avm_writedata,
    input         avm_waitrequest
);

localparam RX_BASE     = 0*4;
localparam TX_BASE     = 1*4;
localparam STATUS_BASE = 2*4;
localparam TX_OK_BIT   = 6;
localparam RX_OK_BIT   = 7;

// Feel free to design your own FSM!
// localparam S_GET_KEY = 0;
// localparam S_GET_DATA = 1;
// localparam S_WAIT_CALCULATE = 2;
// localparam S_SEND_DATA = 3;
localparam S_QUERY_RX       = 0;
localparam S_READ           = 1;
localparam S_WAIT_CALCULATE = 2;
localparam S_QUERY_TX       = 3;
localparam S_WRITE          = 4;

logic [255:0] n_r, n_w, d_r, d_w, enc_r, enc_w, dec_r, dec_w;
logic [2:0] state_r, state_w;
logic [6:0] bytes_counter_r, bytes_counter_w;
logic [4:0] avm_address_r, avm_address_w;
logic avm_read_r, avm_read_w, avm_write_r, avm_write_w;

logic rsa_start_r, rsa_start_w;
logic rsa_finished;
logic [255:0] rsa_dec;

// additional definition
logic [6:0] read_cnt_r, read_cnt_w;
logic [6:0] write_cnt_r, write_cnt_w;

assign avm_address   = avm_address_r;
assign avm_read      = avm_read_r;
assign avm_write     = avm_write_r;
assign avm_writedata = dec_r[247-:8];

Rsa256Core rsa256_core(
    .i_clk(avm_clk),
    .i_rst(avm_rst),
    .i_start(rsa_start_r),
    .i_a(enc_r),
    .i_d(d_r),
    .i_n(n_r),
    .o_a_pow_d(rsa_dec),
    .o_finished(rsa_finished)
);

task StartRead;
    input [4:0] addr;
    begin
        avm_read_w    = 1;
        avm_write_w   = 0;
        avm_address_w = addr;
    end
endtask

task StartWrite;
    input [4:0] addr;
    begin
        avm_read_w    = 0;
        avm_write_w   = 1;
        avm_address_w = addr;
    end
endtask

// no read or write when calculating
task StartWait;
    begin
        avm_read_w    = 0;
        avm_write_w   = 0;
        avm_address_w = 0;
    end
endtask

always_comb begin
    // TODO
    // initialize
    n_w             = n_r;
    d_w             = d_r;
    enc_w           = enc_r;
    dec_w           = dec_r;
    avm_address_w   = avm_address_r;
    avm_read_w      = avm_read_r;
    avm_write_w     = avm_write_r;
    state_w         = state_r;
    bytes_counter_w = bytes_counter_r;
    rsa_start_w     = rsa_start_r;

    read_cnt_w      = read_cnt_r;
    write_cnt_w     = write_cnt_r;

    case (state_r)
        // if ready -> read data
        S_QUERY_RX: begin
            if (!avm_waitrequest) begin
                StartRead(STATUS_BASE);
                // make sure ip is ready
                if (avm_address_r == STATUS_BASE && avm_readdata[RX_OK_BIT] == 1) begin
                    state_w = S_READ;
                    StartRead(RX_BASE);
                end
            end
        end
        // read 1 btye a time -> need 32 times for n, e, a each
        S_READ: begin
            if (!avm_waitrequest) begin
                read_cnt_w = read_cnt_r + 1;
                state_w = S_QUERY_RX; // back to querying
                StartRead(STATUS_BASE);
                // receive n
                if (read_cnt_r < 32) begin
                    n_w[255 - (read_cnt_r << 3) -: 8] = avm_readdata[7:0];
                end
                // receive e
                else if (read_cnt_r < 64) begin
                    d_w[255 - ((read_cnt_r - 32) << 3) -: 8] = avm_readdata[7:0];
                end
                // receive a (or receive a new one)
                else begin
                    enc_w[255 - ((read_cnt_r - 64) << 3) -: 8] = avm_readdata[7:0];
                    // finish loading n, e, a -> calculate
                    if (read_cnt_r == 95) begin
                        state_w = S_WAIT_CALCULATE;
                        StartWait();
                        rsa_start_w = 1;
                        // for loading another 'a' later on
                        read_cnt_w = 64;
                    end
                end
            end
        end
        // use module rsaCore to calculate
        S_WAIT_CALCULATE: begin
            // don't care avm_waitrequest
            if (rsa_finished) begin
                state_w = S_QUERY_TX;
                StartRead(STATUS_BASE);
                // stop rsaCore
                rsa_start_w = 0;
                dec_w = rsa_dec;
            end
        end
        // if ready -> write data
        S_QUERY_TX: begin
            if (!avm_waitrequest) begin
                // make sure ip is ready
                if (avm_address_r == STATUS_BASE && avm_readdata[TX_OK_BIT] == 1) begin
                    state_w = S_WRITE;
                    StartWrite(TX_BASE);
                end
                else begin
                    StartRead(STATUS_BASE);
                end
            end
        end
        // write 1 btye a time -> need 32 times for rsa_dec (use dec_r to help)
        S_WRITE: begin
            if (!avm_waitrequest) begin
                write_cnt_w = write_cnt_r + 1;
                state_w = S_QUERY_TX;
                StartRead(STATUS_BASE);
                // write
                if (write_cnt_r < 31) begin
                    dec_w = dec_r << 8;
                    // finish writing
                    if (write_cnt_r == 30) begin
                        state_w = S_QUERY_RX;
                        write_cnt_w = 0;
                    end
                end
            end
        end
    endcase
end

always_ff @(posedge avm_clk or posedge avm_rst) begin
    if (avm_rst) begin
        n_r             <= 0;
        d_r             <= 0;
        enc_r           <= 0;
        dec_r           <= 0;
        avm_address_r   <= STATUS_BASE;
        avm_read_r      <= 1;
        avm_write_r     <= 0;
        state_r         <= S_QUERY_RX;
        bytes_counter_r <= 63;
        rsa_start_r     <= 0;
        read_cnt_r      <= 0;
        write_cnt_r     <= 0;
    end else begin
        n_r             <= n_w;
        d_r             <= d_w;
        enc_r           <= enc_w;
        dec_r           <= dec_w;
        avm_address_r   <= avm_address_w;
        avm_read_r      <= avm_read_w;
        avm_write_r     <= avm_write_w;
        state_r         <= state_w;
        bytes_counter_r <= bytes_counter_w;
        rsa_start_r     <= rsa_start_w;
        read_cnt_r      <= read_cnt_w;
        write_cnt_r     <= write_cnt_w;
    end
end

endmodule
