test:
	iverilog -c dependencies.txt && ./a.out

rx: rx-test0

rx-test0:
	iverilog counter.v clock_divider.v shift_reg_piso.v shift_reg_sipo.v rx_module.v tests/rx_module/test0.v && ./a.out

rx-test1:
	iverilog counter.v clock_divider.v shift_reg_piso.v shift_reg_sipo.v rx_module.v tests/rx_module/test1.v && ./a.out

ctr-test0:
	iverilog counter.v tests/counter/test0.v && ./a.out

cdiv-test0:
	iverilog counter.v clock_divider.v tests/clock_divider/test0.v && ./a.out

tx: tx-test0 tx-test1 tx-test2

tx-test0:
	iverilog shift_reg_piso.v shift_reg_sipo.v tx_module.v tests/tx_module/test0.v && ./a.out

tx-test1:
	iverilog shift_reg_piso.v shift_reg_sipo.v tx_module.v tests/tx_module/test1.v && ./a.out

tx-test2:
	iverilog shift_reg_piso.v shift_reg_sipo.v tx_module.v tests/tx_module/test2.v && ./a.out

sr: sr-sipo sr-piso

sr-sipo: sr-sipo-test0 sr-sipo-test1 sr-sipo-test2

sr-sipo-test0:
	iverilog shift_reg_sipo.v tests/shift_reg_sipo/test0.v && ./a.out

sr-sipo-test1:
	iverilog shift_reg_sipo.v tests/shift_reg_sipo/test1.v && ./a.out

sr-sipo-test2:
	iverilog shift_reg_sipo.v tests/shift_reg_sipo/test2.v && ./a.out

sr-piso: sr-piso-test0 sr-piso-test1 sr-piso-test2

sr-piso-test0:
	iverilog shift_reg_piso.v tests/shift_reg_piso/test0.v && ./a.out

sr-piso-test1:
	iverilog shift_reg_piso.v tests/shift_reg_piso/test1.v && ./a.out

sr-piso-test2:
	iverilog shift_reg_piso.v tests/shift_reg_piso/test2.v && ./a.out

clean:
	rm -f a.out

