module tx_module(
	input clk,
	input reset,
	input enable,
	input [7:0] data_in,
	output tx
);
parameter data_width = 8;
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

reg parity_bit;
assign tx = tx_data ? sr_dout
		: cur_state == STATE_Idle ? 1'b1
		: cur_state == STATE_StartBit ? 1'b0
		: cur_state == STATE_Parity ? parity_bit
		: cur_state == STATE_StopBit ? 1'b1
		: 1'bx;
reg tx_data;

wire sr_clk, sr_dout;
reg sr_reset;

shift_reg_piso #(.size(8)) sr(
	.clk(clk),
	.reset(sr_reset),
	.datain(data_in),
	.dataout(sr_dout)
);

always @ ( * ) begin
	next_state = cur_state;
	case (cur_state)
		STATE_Idle: begin
			tx_data = 1'b0;
			// if tx enable, start transmitting
			if (enable) begin
				next_state = STATE_StartBit;
				// sr_reset = 1'b1;
			end
			else begin
				next_state = STATE_Idle;
			end
		end
		STATE_StartBit: begin
			// $display("Start");
			next_state = STATE_Data0;
			parity_bit = 1'b0;
			sr_reset = 1'b1;
		end
		STATE_Data0: begin
			// $display("Data0");
			parity_bit = parity_bit ^ sr_dout;
			next_state = STATE_Data1;
			sr_reset = 1'b0;
			tx_data = 1'b1;
		end
		STATE_Data1: begin
			// $display("Data1");
			parity_bit = parity_bit ^ sr_dout;
			next_state = STATE_Data2;
		end
		STATE_Data2: begin
			// $display("Data2");
			parity_bit = parity_bit ^ sr_dout;
			next_state = STATE_Data3;
		end
		STATE_Data3: begin
			// $display("Data3");
			parity_bit = parity_bit ^ sr_dout;
			next_state = STATE_Data4;
		end
		STATE_Data4: begin
			// $display("Data4");
			parity_bit = parity_bit ^ sr_dout;
			next_state = STATE_Data5;
		end
		STATE_Data5: begin
			// $display("Data5");
			parity_bit = parity_bit ^ sr_dout;
			next_state = STATE_Data6;
		end
		STATE_Data6: begin
			// $display("Data6");
			parity_bit = parity_bit ^ sr_dout;
			next_state = STATE_Data7;
		end
		STATE_Data7: begin
			// $display("Data7");
			parity_bit = parity_bit ^ sr_dout;
			next_state = STATE_Parity;
		end
		STATE_Parity: begin
			// $display("Parity");
			next_state = STATE_StopBit;
			tx_data = 1'b0;
		end
		STATE_StopBit: begin
			// $display("Stop");
			next_state = STATE_Idle;
		end
	endcase
end

always @ (posedge clk) begin
	if (reset) begin
		cur_state <= STATE_Idle;
	end
	else begin
		cur_state <= next_state;
	end
end

always @ (posedge reset) begin
	cur_state <= STATE_Idle;
end

endmodule

