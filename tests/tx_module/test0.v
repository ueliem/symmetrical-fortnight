module test0();
localparam CYCLES = 12;
reg clk = 1'b0;
reg tx_reset = 1'b0;
reg tx_enable = 1'b0;

wire dout;
reg [7:0] test_data = 8'b00000000;
wire [7+1+1+1:0] rx_data;

shift_reg_sipo #(11) sr(
	.clk(clk),
	.reset(),
	.datain(dout),
	.dataout(rx_data)
);

tx_module tm(
	.clk(clk),
	.reset(tx_reset),
	.enable(tx_enable),
	.data_in(test_data),
	.tx(dout)
);

initial begin
	$monitor("%b", rx_data);
	tx_enable = 1'b1;
	tx_reset = 1'b1;
	#1 tx_reset = 1'b0;
end

always @ (posedge clk) begin
	$display("Posedge");
end

initial repeat(CYCLES*2) begin
	#5 clk = ~clk;
end

endmodule

