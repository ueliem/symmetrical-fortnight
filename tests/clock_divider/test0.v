module test0();
localparam CYCLES = 16;
reg clk = 1'b0;
reg reset = 1'b0;

wire cout;

clock_divider cd(
	.clkin(clk),
	.reset(reset),
	.clkout(cout)
);

initial begin
	$monitor("%b", cout);
	reset = 1'b1;
	#1 reset = 1'b0;
end

always @ (posedge clk) begin
	$display("Posedge");
end

initial repeat(CYCLES*2) begin
	#5 clk = ~clk;
end

endmodule

