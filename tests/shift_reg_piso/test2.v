module test0();
localparam CYCLES = 8;
reg clock = 1'b0;
reg reset = 1'b0;

reg [7:0] testdata = 8'b11011101;

wire dout;

shift_reg_piso #(.size(8)) sr(
	.clk(clock),
	.reset(reset),
	.datain(testdata),
	.dataout(dout)
);

initial begin
	reset = 1'b1;
	#1 reset = 1'b0;
end

always @ (posedge clock) begin
	$display("Posedge");
	$display("%b", dout);
end

initial repeat(CYCLES*2) begin
	#5 clock = ~clock;
end

endmodule

