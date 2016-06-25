test:
	iverilog -c dependencies.txt && ./a.out

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

