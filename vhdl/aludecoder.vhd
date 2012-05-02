library ieee;
use ieee.std_logic_1164.all;

-- Alu Decoder

Entity aludecoder is
    Port (funct      : in std_logic_vector(5 downto 0);
          aluop      : in std_logic_vector(1 downto 0);
          alucontrol : out std_logic_vector(2 downto 0));
    End;

Architecture behave of aludecoder is
    begin
        process
        begin
        case aluop is
            when "00" => alucontrol <= "010"; -- add
            when "01" => alucontrol <= "110"; -- sub
            when others => case funct is      -- R-type
                when "100000" => alucontrol <= "010";
                when "100010" => alucontrol <= "110";
                when "100100" => alucontrol <= "000";
                when "100101" => alucontrol <= "001";
                when "101010" => alucontrol <= "111";
                when "100110" => alucontrol <= "100"; -- xor
                when "101011" => alucontrol <= "111"; -- sltu
                when "100001" => alucontrol <= "000"; -- addu
                when "100011" => alucontrol <= "110"; -- subu

                when others => alucontrol <= "---";
            end case;
    end case;
    end process;

end;
