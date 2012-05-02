library ieee;
use ieee.std_logic_1164.all;

-- Auxiliar register 1 - IF stage to ID stage

Entity regaux1 is
    Generic(W : integer);
    Port (instruction : in std_logic_vector(W-1 downto 0);
          pcplus4     : in std_logic_vector(W-1 downto 0);
          clk         : in std_logic;
          instr_out   : out std_logic_vector(W-1 downto 0);
          pc_out      : out std_logic_vector(W-1 downto 0));
    End;

Architecture behave of regaux1 is
    begin
        process(clk)
        begin
            if( clk'event and clk = '1') then
                instr_out <= instruction;
                pc_out <= pcplus4;
            end if;
        end process;
    end;
