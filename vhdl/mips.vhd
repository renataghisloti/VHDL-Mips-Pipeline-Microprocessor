library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity mips is
    Generic(nbits : positive := 32);
    port(Instruction : in std_logic_vector(nbits -1 downto 0);
         Data       : in std_logic_vector(nbits -1 downto 0);
         clk        : in std_logic;
         reset      : in std_logic;
         PCF        : out std_logic_vector(nbits -1 downto 0);
         ALUOutM    : out std_logic_vector(nbits -1 downto 0);
         WriteDataM : out std_logic_vector(nbits -1 downto 0);
         MemWriteM  : out std_logic);
    End mips;


Architecture struct of mips is

 Component controller is
    Port (op, funct : in std_logic_vector(5 downto 0);
          zero      : in std_logic;
          memtoreg  : out std_logic;
          memwrite  : out std_logic;
          pcsrc     : out std_logic;
          alusrc    : out std_logic;
          regdst    : out std_logic;
          regwrite  : out std_logic;
          jump      : out std_logic;
          alucontrol: out std_logic_vector(2 downto 0));
 end Component;
 for cont : controller use entity work.controller;

 Component datapath is
    Port(clk        : in std_logic;
         reset      : in std_logic;
         memtoreg   : in std_logic;
         pcsrc      : in std_logic;
         alusrc     : in std_logic;
         regdst     : in std_logic;
         regwrite   : in std_logic;
         jump       : in std_logic;
         alucontrol : in std_logic_vector(2 downto 0);
         instruction: in std_logic_vector(31 downto 0);
         readdata   : in std_logic_vector(31 downto 0);
         pc         : out std_logic_vector(31 downto 0);
         aluout     : out std_logic_vector(31 downto 0);
         writedata  : out std_logic_vector(31 downto 0);
         zero       : out std_logic);
 end Component;
 for dp : datapath use entity work.datapath;

    signal mymemtoreg, myalusrc, myregdst, myregwrite, myjump, mypcsrc: std_logic;
    signal myzero: std_logic;
    signal myalucontrol : std_logic_vector(2 downto 0);

    begin
        cont: controller port map (instruction(31 downto 26), instruction(5 downto 0),
                                  myzero, mymemtoreg, memwriteM, mypcsrc, myalusrc, myregdst, myregwrite, myjump, myalucontrol);

        dp: datapath port map(clk, reset, mymemtoreg, mypcsrc, myalusrc, myregdst, myregwrite, myjump, myalucontrol,Instruction, data,
                               pcF, aluoutM, writedataM, myzero);
end struct;
