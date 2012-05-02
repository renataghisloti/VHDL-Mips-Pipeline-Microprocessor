library ieee;
library std;

--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;

entity tb_mips is
end tb_mips;

architecture behaviour of tb_mips is

    component mips 
    generic(nbits : positive :=32);
    port(Instruction : in std_logic_vector(nbits -1 downto 0);
         Data       : in std_logic_vector(nbits -1 downto 0);
         clk        : in std_logic;
         reset      : in std_logic;
         PCF        : out std_logic_vector(nbits -1 downto 0);
         ALUOutM    : out std_logic_vector(nbits -1 downto 0);
         WriteDataM : out std_logic_vector(nbits -1 downto 0);
         MemWriteM  : out std_logic);
    end component;

    for mips0: mips use entity work.mips;

    signal erro : boolean := false;
     constant clk_period : time := 10 ns;
     signal writedata, aluout  : std_logic_vector(31 downto 0);
     signal pc, data, instr : std_logic_vector(31 downto 0);
     signal clk : std_logic := '0';
     signal reset, memwrite : std_logic;


    begin
       mips0: mips port map(instr, data, clk, reset, pc, aluout, writedata, memwrite);

        process -- controle de clock
        begin
            clk <= not clk;
            wait for 10 ns;
        end process;

       process(clk)  begin
           instr <= "00100000000100000000000000000001";
       end process;

       process -- termina a execucao 
       begin
          wait for 140 ns;
          erro <= true;
       end process;

       assert not erro report "FIM" severity failure;
end behaviour;
