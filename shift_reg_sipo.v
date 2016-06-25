module shift_reg_sipo(
	input clk,
	input reset,
	input datain,
	output [size-1:0] dataout
);
parameter size = 8;

reg [size-1:0] r;
assign dataout = r;

integer x;
always @ (posedge clk) begin
	r[0] <= datain;
	for (x = 0; x < size - 1; x = x + 1) begin
		r[x+1] <= r[x];
	end
end
endmodule

