library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    Port ( in0 : in STD_LOGIC;
           clk : in STD_LOGIC;
           out0 : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is

signal counter : std_logic_vector(21 downto 0);

begin
debouncer : process(clk)
begin

if(rising_edge(clk)) then
    if(in0 = '0') then
        counter <= (others => '0');
        out0 <= '0';
    elsif(in0 = '1') then
        counter <= std_logic_vector(unsigned(counter) +1);
        if(unsigned(counter)> 2499999) then
            out0 <= '1';

        else
            out0 <= '0';
        end if;
        if(unsigned(counter) > 2499999+2) then
            counter <= std_logic_vector(unsigned(counter)-1);
        end if;
    end if;
end if;
end process;



end Behavioral;
