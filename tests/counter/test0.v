module test0();
parameter size = 3;
localparam CYCLES = 8;

reg clk = 1'b0;
reg c_reset = 1'b0;
wire [size-1:0] cout;

counter #(size) c(
	.clk(clk),
	.reset(c_reset),
	.out(cout)
);

initial begin
	$monitor("%b", cout);
	c_reset = 1'b1;
	#1 c_reset = 1'b0;
end

always @ (posedge clk) begin
	$display("Posedge");
end

initial repeat(CYCLES*2) begin
	#5 clk = ~clk;
end

endmodule

