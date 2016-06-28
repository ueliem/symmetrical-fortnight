module counter(
	input clk,
	input reset,
	output [size-1:0] out
);
parameter size = 3;

assign out = r;

reg [size-1:0] r;

always @ (posedge clk) begin
	r = r + 1;
end

always @ (posedge reset) begin
	r = 0;
end

endmodule

