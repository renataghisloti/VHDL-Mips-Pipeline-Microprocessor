library ieee;
use ieee.std_logic_1164.all;

Entity signextension is
    Port (A : in std_logic_vector(15 downto 0);
          Y : out std_logic_vector(31 downto 0));
    End;

Architecture behave of signextension is
    begin
        Y <= X"0000" & A when A(15)='0' else X"ffff" & A;
    end;
