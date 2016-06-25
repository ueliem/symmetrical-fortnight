module shift_reg_piso(
	input clk,
	input reset,
	input [size-1:0] datain,
	output dataout
);
parameter size = 8;

reg [size-1:0] r;
assign dataout = r[0];

integer x;
always @ (posedge clk) begin
	for (x = 0; x < size - 1; x = x + 1) begin
		r[x] <= r[x+1];
	end
end

always @ (reset) begin
	r <= datain;
end

endmodule

