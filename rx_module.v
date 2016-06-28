module rx_module(
	input clk,
	input reset,
	input enable,
	output [7:0] data_out,
	input rx
);
localparam STATE_Idle = 4'd0,
	STATE_StartBit = 4'd1,
	STATE_Data0 = 4'd2,
	STATE_Data1 = 4'd3,
	STATE_Data2 = 4'd4,
	STATE_Data3 = 4'd5,
	STATE_Data4 = 4'd6,
	STATE_Data5 = 4'd7,
	STATE_Data6 = 4'd8,
	STATE_Data7 = 4'd9,
	STATE_Parity = 4'd10,
	STATE_StopBit = 4'd11;

reg [3:0] cur_state, next_state;

reg sr_reset;
reg receiving;
reg parity_bit;

wire [7:0] sr_out;
reg [7:0] sr_rec;
assign data_out = sr_rec;
assign sr_in = receiving ? rx
			: 1'bz;

wire sr_parity;
assign sr_parity = ^sr_out;
wire sr_clk;
reg sr_enable;

shift_reg_sipo #(.size(8)) sr(
	.clk(sr_enable),
	.reset(sr_reset),
	.datain(rx),
	.dataout(sr_out)
);

reg cr_reset;
wire [2:0] cr_out;

counter #(3) cr(
	.clk(clk),
	.reset(cr_reset),
	.out(cr_out)
);

initial begin
end

// always @ ( cur_state ) begin
always @ ( * ) begin
	// $display("state: %d", cur_state);
	next_state = cur_state;
	case (cur_state)
		STATE_Idle: begin
			sr_enable = 1'b0;
		end
		STATE_StartBit: begin
			sr_reset = 1'b1;
			cr_reset = 1'b0;
			if (cr_out == 3'b111) begin
				next_state = STATE_Data0;
			end
		end
		STATE_Data0: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample the input
				sr_enable = 1'b1;
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Data1;
			end
			else begin
				// Turn off sampling
				sr_enable = 1'b0;
			end
		end
		STATE_Data1: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample the input
				sr_enable = 1'b1;
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Data2;
			end
			else begin
				// Turn off sampling
				sr_enable = 1'b0;
			end
		end
		STATE_Data2: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample the input
				sr_enable = 1'b1;
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Data3;
			end
			else begin
				// Turn off sampling
				sr_enable = 1'b0;
			end
		end
		STATE_Data3: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample the input
				sr_enable = 1'b1;
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Data4;
			end
			else begin
				// Turn off sampling
				sr_enable = 1'b0;
			end
		end
		STATE_Data4: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample the input
				sr_enable = 1'b1;
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Data5;
			end
			else begin
				// Turn off sampling
				sr_enable = 1'b0;
			end
		end
		STATE_Data5: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample the input
				sr_enable = 1'b1;
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Data6;
			end
			else begin
				// Turn off sampling
				sr_enable = 1'b0;
			end
		end
		STATE_Data6: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample the input
				sr_enable = 1'b1;
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Data7;
			end
			else begin
				// Turn off sampling
				sr_enable = 1'b0;
			end
		end
		STATE_Data7: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample the input
				sr_enable = 1'b1;
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Parity;
			end
			else begin
				// Turn off sampling
				sr_enable = 1'b0;
			end
		end
		STATE_Parity: begin
			sr_rec = sr_out;
			if (cr_out == 3'b100) begin
				// Midway through, sample parity
				if (rx == sr_parity) begin
					$display("Parity good");
				end
				else begin
					$display("Parity bad");
				end
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_StopBit;
			end
			else begin
				// Don't care
			end
		end
		STATE_StopBit: begin
			if (cr_out == 3'b100) begin
				// Midway through, sample parity
				if (rx == 1'b1) begin
					$display("Stop good");
				end
				else begin
					$display("Stop bad");
				end
			end
			else if (cr_out == 3'b111) begin
				// After 8 cycles go to the next state
				next_state = STATE_Idle;
			end
			else begin
				// Don't care
			end
		end
	endcase
end

always @ (negedge rx && cur_state == STATE_Idle) begin
	$display("Starting");
	cr_reset = 1'b1;
	cur_state = STATE_StartBit;
end

always @ (posedge clk) begin
	if (reset) begin
		$display("reset again");
		cur_state <= STATE_Idle;
	end
	else begin
		cur_state <= next_state;
	end
end

always @ (posedge reset) begin
	$display("reset");
	cur_state <= STATE_Idle;
end

endmodule

