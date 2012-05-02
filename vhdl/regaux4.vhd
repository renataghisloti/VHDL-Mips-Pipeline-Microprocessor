library ieee;
use ieee.std_logic_1164.all;

-- Auxiliar register 3 - ID stage to EX stage

Entity regaux4 is
    Generic(W : integer);
    Port (clk           : in std_logic;
          S_RegWriteW   : in std_logic;
          S_MemtoRegW   : in std_logic;
          ReadDataW     : in std_logic_vector(W-1 downto 0);
          AluOutW       : in std_logic_vector(W-1 downto 0);
          WriteRegW     : in std_logic_vector(4 downto 0);
          outS_RegWriteW : out std_logic;
          outS_MemtoRegW : out std_logic;
          outReadDataW   : out std_logic_vector(W-1 downto 0);
          outAluOutW     : out std_logic_vector(W-1 downto 0);
          outWriteRegW   : out std_logic_vector(4 downto 0));
    End;

Architecture behave of regaux4 is
    begin
        process(clk)
        begin
            if( clk'event and clk = '1') then
            outS_RegWriteW <= S_RegWriteW;
            outS_MemtoRegW <= S_MemtoRegW;
            outAluOutW <= AluOutW;
            outReadDataW <= ReadDataW;
            outWriteRegW <= WriteRegW;
        end if;
        end process;
    end;
