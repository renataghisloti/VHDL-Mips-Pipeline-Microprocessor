library ieee;
use ieee.std_logic_1164.all;

-- Auxiliar register 2 - ID stage to EX stage

Entity regaux2 is
    Generic(W : integer);
    Port (clk           : in std_logic;
          S_RegWriteD   : in std_logic;
          S_MemtoRegD   : in std_logic;
          S_MemWriteD   : in std_logic;
          S_BranchD     : in std_logic_vector(W-1 downto 0);
          S_ALUCOntrolD : in std_logic_vector(2 downto 0);
          S_ALUSrcD     : in std_logic;
          S_RegDstD     : in std_logic;
          RD1           : in std_logic_vector(W-1 downto 0);
          RD2           : in std_logic_vector(W-1 downto 0);
          RtE           : in std_logic_vector(4 downto 0);
          RdE           : in std_logic_vector(4 downto 0);
          SignExt       : in std_logic_vector(W-1 downto 0);
          PCPlus4       : in std_logic_vector(W-1 downto 0);
          outS_RegWriteD   : out std_logic;
          outS_MemtoRegD   : out std_logic;
          outS_MemWriteD   : out std_logic;
          outS_BranchD     : out std_logic_vector(W-1 downto 0);
          outS_ALUCOntrolD : out std_logic_vector(2 downto 0);
          outS_ALUSrcD     : out std_logic;
          outS_RegDstD     : out std_logic;
          outRD1           : out std_logic_vector(W-1 downto 0);
          outRD2           : out std_logic_vector(W-1 downto 0);
          outRtE           : out std_logic_vector(4 downto 0);
          outRdE           : out std_logic_vector(4 downto 0);
          outSignExt       : out std_logic_vector(W-1 downto 0);
          outPCPlus4       : out std_logic_vector(W-1 downto 0));
    End;

Architecture behave of regaux2 is
    begin
        process(clk)
        begin
            if( clk'event and clk = '1') then
            outS_RegWriteD <= S_RegWriteD;
            outS_MemtoRegD <= S_MemtoRegD;
            outS_MemWriteD <=S_MemWriteD;
            outS_BranchD <= S_BranchD;
            outS_ALUCOntrolD <=S_ALUCOntrolD;
            outS_ALUSrcD <=S_ALUSrcD;
            outS_RegDstD <=S_RegDstD;
            outRD1 <=RD1;
            outRD2 <=RD2;
            outRtE <= RtE;
            outRdE <= RdE;
            outSignExt <= SignExt;
            outPCPlus4 <= PCPlus4;
        end if;
        end process;
    end;
