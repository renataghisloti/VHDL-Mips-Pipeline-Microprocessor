library ieee;
use ieee.std_logic_1164.all;

-- Generic Register

Entity genericreg is
    Generic(W : integer);
    Port (d   : in std_logic_vector(W-1 downto 0);
          clk : in std_logic;
          q   : out std_logic_vector(W-1 downto 0));
End;

Architecture behave of genericreg is
    begin
        process(clk)
        begin
        if (clk'event and clk='1') then
            q <= d;
        end if;
        end process;
    end;
