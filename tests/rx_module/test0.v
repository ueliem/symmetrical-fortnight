module test0();
localparam CYCLES = 11*8;
reg clk = 1'b0;
reg rx_reset = 1'b0;
reg rx_enable = 1'b0;

reg sr_reset = 1'b0;
wire dout;
reg [10:0] test_data = 11'b10000001010;
wire [7:0] rx_data;

wire r_in;
assign r_in = rx_enable ? dout : 1'b1;

wire cout;

clock_divider cd(
	.clkin(clk),
	.reset(sr_reset),
	.clkout(cout)
);

shift_reg_piso #(11) sr(
	.clk(cout),
	.reset(sr_reset),
	.datain(test_data),
	.dataout(dout)
);

rx_module rm(
	.clk(clk),
	.reset(rx_reset),
	.enable(rx_enable),
	.data_out(rx_data),
	.rx(r_in)
);

initial begin
	$monitor("%b", rx_data);
	// $monitor("%b", dout);
	sr_reset = 1'b1;
	#1 sr_reset = 1'b0;
	rx_reset = 1'b1;
	#1 rx_reset = 1'b0;
	rx_enable = 1'b1;
end

always @ (posedge clk) begin
	$display("Posedge");
end

initial repeat(CYCLES*2) begin
	#5 clk = ~clk;
end

endmodule

