library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity rf is
Generic(W : natural := 32);
port(A1  : in std_logic_vector(4 downto 0);
     A2  : in std_logic_vector(4 downto 0);
     A3  : in std_logic_vector(4 downto 0);
     WD3 : in std_logic_vector(W-1 downto 0);
     clk : in std_logic;
     We3 : in std_logic;
     RD1 : out std_logic_vector(W-1 downto 0);
     RD2 : out std_logic_vector(W-1 downto 0));
End rf;


Architecture RTL of rf is

    type ffd_vector is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal ffd : ffd_vector;

    begin
        process (A1, A2, A3, clk)

            Variable Aux1 : integer;
            Variable Aux2 : integer;
            Variable Aux3 : integer;

        begin
            Aux1 := to_integer(unsigned(A1));
            Aux2 := to_integer(unsigned(A2));
            Aux3 := to_integer(unsigned(A3));

            if A1'event then
                if Aux1 = 0 then
                    RD1 <= "00000000000000000000000000000000";
                else
                    RD1 <= ffd(Aux1);
                end if;
            end if;
            if A2'event then
                if Aux2 = 0 then 
                    RD2 <= "00000000000000000000000000000000";
                else
                    RD2 <= ffd(Aux2);
                end if;
            end if;
            if clk'event and clk = '1' then 
                if We3 = '1' then
                    ffd(Aux3) <= WD3;
                end if;
            end if;
        end process;
    end RTL;
