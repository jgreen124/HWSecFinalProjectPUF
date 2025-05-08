library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port (
        inputs : in std_logic_vector(15 downto 0) := (others => '0');
        sel : in std_logic_vector(3 downto 0) := (others => '0');
        output : out std_logic := '0'
     );
end mux;

architecture Behavioral of mux is

begin
    process(inputs, sel) begin
        case sel is
            when "0000" => output <= inputs(0);
            when "0001" => output <= inputs(1);
            when "0010" => output <= inputs(2);
            when "0011" => output <= inputs(3);
            when "0100" => output <= inputs(4);
            when "0101" => output <= inputs(5);
            when "0110" => output <= inputs(6);
            when "0111" => output <= inputs(7);
            when "1000" => output <= inputs(8);
            when "1001" => output <= inputs(9);
            when "1010" => output <= inputs(10);
            when "1011" => output <= inputs(11);
            when "1100" => output <= inputs(12);
            when "1101" => output <= inputs(13);
            when "1110" => output <= inputs(14);
            when "1111" => output <= inputs(15);
            when others => output <= inputs(0);
        end case;
    end process;

end Behavioral;
