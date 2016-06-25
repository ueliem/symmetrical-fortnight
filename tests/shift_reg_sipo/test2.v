module test2();
localparam CYCLES = 8;
reg clock = 1'b0;
reg reset = 1'b0;

reg [7:0] testdata = 8'b11011101;

wire [7:0] dout;
integer i = 0;
reg din;


shift_reg_sipo #(.size(8)) sr(
	.clk(clock),
	.reset(reset),
	.datain(din),
	.dataout(dout)
);

initial begin
	$monitor("%b", dout);
	din = testdata[i];
end

always @ (posedge clock) begin
	$display("Posedge");
	i = i + 1;
	#3 din = testdata[i];
end

initial repeat(CYCLES*2) begin
	#5 clock = ~clock;
end

endmodule

