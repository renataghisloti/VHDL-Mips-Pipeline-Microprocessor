library ieee;
use ieee.std_logic_1164.all;

Entity sl2 is
    Port (A : in std_logic_vector(31 downto 0);
          Y : out std_logic_vector(31 downto 0));
    End;

Architecture behave of sl2 is
begin
    Y <= A(29 downto 0) & "000";
    end;
