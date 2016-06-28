module uart(
	input txclk,
	input rxclk,
	input [7:0] data_in,
	output [7:0] data_out,
	input rx,
	output tx
);
localparam STATE_Idle = 3'd0;

reg [2:0] cur_state, next_state;

reg tx_enable, rx_enable;

reg tx_reset, rx_reset;

rx_module rm(
	.clk(rxclk),
	.reset(rx_reset),
	.enable(rx_enable),
	.data_out(data_out),
	.rx(rx)
);
tx_module tm(
	.clk(txclk),
	.reset(tx_reset),
	.enable(tx_enable),
	.data_in(data_in),
	.tx(tx)
);

always @ ( * ) begin
	// next_state = cur_state;
	case (cur_state)
		STATE_Idle: begin
		end
	endcase
end*/

always @ (posedge clk) begin
	if (reset) begin
		cur_state <= STATE_Idle;
	end
	else begin
		cur_state <= next_state;
	end
end
endmodule

