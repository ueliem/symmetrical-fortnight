module clock_divider(
	input clkin,
	input reset,
	output clkout
);

reg c;
assign clkout = c;
wire [2:0] cr_out;

counter #(3) cr(
	.clk(clkin),
	.reset(reset),
	.out(cr_out)
);

always @ ( * ) begin
	if (cr_out == 3'b000) begin
		c = 1'b1;
	end
	else begin
		c = 1'b0;
	end
end

always @ (posedge reset) begin
	c = 1'b0;
end

endmodule

