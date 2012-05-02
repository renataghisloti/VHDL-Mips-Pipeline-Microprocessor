library ieee;
use ieee.std_logic_1164.all;

-- Maind Decoder

Entity maindecoder is
    Port (op        : in std_logic_vector(5 downto 0);
          memtoreg  : out std_logic;
          memwrite  : out std_logic;
          branch    : out std_logic;
          alusrc    : out std_logic;
          regdst    : out std_logic;
          regwrite : out std_logic;
          jump      : out std_logic;
          aluop     : out std_logic_vector(1 downto 0));
    End;

Architecture behave of maindecoder is
    signal Control_vector: std_logic_vector(8 downto 0);
    begin
    process (op) begin
        case op is
            when "000000" => Control_vector <= "110000010"; -- R-type
            when "100011" => Control_vector <= "101001000"; -- lw
            when "101011" => Control_vector <= "001010000"; -- sw
            when "000100" => Control_vector <= "000100001"; -- beq
            when "001000" => Control_vector <= "101000000"; -- addi
            when "000010" => Control_vector <= "000000100"; -- j
            when "000011" => Control_vector <= "100000001"; -- jal
            when "001001" => Control_vector <= "101000001"; -- subi
            when others   => Control_vector <= "---------";
        end case;
    end process;

    regwrite <= Control_vector(8);
    regdst <= Control_vector(7);
    alusrc <= Control_vector(6);
    branch <= Control_vector(5);
    memwrite <= Control_vector(4);
    memtoreg <= Control_vector(3);
    jump <= Control_vector(2);
    aluop <= Control_vector(1 downto 0);

end;
