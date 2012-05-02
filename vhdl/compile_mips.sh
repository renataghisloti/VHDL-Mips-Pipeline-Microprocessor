rm *.o
ghdl -a --ieee=synopsys -fexplicit vhdl/adder.vhd 
ghdl -a --ieee=synopsys -fexplicit vhdl/mux.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/regaux1.vhd 
ghdl -a --ieee=synopsys -fexplicit vhdl/regaux2.vhd 
ghdl -a --ieee=synopsys -fexplicit vhdl/regaux3.vhd 
ghdl -a --ieee=synopsys -fexplicit vhdl/regaux4.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/sl2.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/alu.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/aludecoder.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/genericreg.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/rf.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/signextension.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/maindecoder.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/datapath.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/controller.vhd
ghdl -a --ieee=synopsys -fexplicit vhdl/mips.vhd

