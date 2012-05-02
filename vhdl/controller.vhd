library ieee;
use ieee.std_logic_1164.all;

Entity controller is
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
    End;

Architecture behavior of controller is

    Component maindecoder is
    Port (op        : in std_logic_vector(5 downto 0);
          memtoreg  : out std_logic;
          memwrite  : out std_logic;
          branch    : out std_logic;
          alusrc    : out std_logic;
          regdst    : out std_logic;
          regwrite  : out std_logic;
          jump      : out std_logic;
          aluop     : out std_logic_vector(1 downto 0));
    End Component;
    for maindecoder0: maindecoder use entity work.maindecoder;

    Component aludecoder is
    Port (funct      : in std_logic_vector(5 downto 0);
          aluop      : in std_logic_vector(1 downto 0);
          alucontrol : out std_logic_vector(2 downto 0));
    End Component;
    for aludecoder0: aludecoder use entity work.aludecoder;

    signal myaluop: std_logic_vector(1 downto 0);
    signal mybranch: std_logic;

begin
    maindecoder0: maindecoder port map(op, memtoreg, memwrite, mybranch, alusrc, regdst, regwrite, jump, myaluop);
    aludecoder0: aludecoder port map(funct, myaluop, alucontrol);

    pcsrc <= mybranch and zero;
end;
