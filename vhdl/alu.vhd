library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

Entity alu is
Generic(W : natural := 32; Cw : natural := 3);
    port(SrcA       : in std_logic_vector(W-1 downto 0);
         SrcB       : in std_logic_vector(W-1 downto 0);
         AluControl : in std_logic_vector(Cw-1 downto 0);
         AluResult  : out std_logic_vector(W-1 downto 0);
         Zero       : out std_logic;
         Overflow   : out std_logic;
         CarryOut   : out std_logic);
End alu;


Architecture RTL of alu is

begin
        process (AluControl)

        Variable Y : std_logic_vector(W downto 0);
        Variable Aux : std_logic_vector(2 downto 0);
        Variable my_zero : std_logic_vector(W-1 downto 0);
        begin
            Y := "000000000000000000000000000000000";
            my_zero := "00000000000000000000000000000000";
            Aux := AluControl;

            case Aux is
                when "000" => Y := '0' & (SrcA AND SrcB);
                when "001" => Y := '0' & (SrcA OR SrcB);
                when "010" => Y := ('0' & SrcA) + ('0' & SrcB);
                when "100" => Y := '0' & (SrcA AND NOT SrcB);
                when "101" => Y := '0' & (SrcA OR NOT SrcB);
                when "110" => Y := '0' & (SrcA - SrcB);
                when "111" => 
                    if (SrcA < SrcB) then 
                        Y := "000000000000000000000000000000001";
                    else 
                        Y := Y; 
                    end if;
                when others => NULL;
            end case;

            -- Check if it was Zero
            if Y = 0 then
                Zero <= '1';
            else
                Zero <= '0';
            end if;

            -- Check if there was overflow
            if ((SrcA > my_zero AND SrcB > my_zero) 
                 AND (Y < ('0' & my_zero))) OR ((SrcA < my_zero AND SrcB < my_zero) AND (Y > ('0' & my_zero))) then
               Overflow <= '1';
            else
               Overflow <= '0';
            end if;

            -- Check if there was CarryOut
            if Y(32) = '1' then
                CarryOut <= '1';
            else
                CarryOut <= '0';
            end if;

            -- Final Result
            AluResult <= Y(31 downto 0);
        end process;
end RTL;
