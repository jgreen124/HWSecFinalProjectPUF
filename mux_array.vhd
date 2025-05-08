library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_array is
    Port (
        inputs : in std_logic_vector(31 downto 0);
        sel : in std_logic_vector(3 downto 0);
        en1, en2 : in std_logic;
        output1, output2 : out std_logic
     );
end mux_array;

architecture Behavioral of mux_array is

    component mux is
        Port (
            inputs : in std_logic_vector(15 downto 0);
            sel : in std_logic_vector(3 downto 0);
            output : out std_logic
         );
    end component;

    signal mux1_sel, mux2_sel : std_logic_vector(3 downto 0) := (others => '0');

begin

    MUX1 : mux
        port map (
            inputs => inputs(15 downto 0),
            sel => mux1_sel,
            output => output1
        );
    MUX2 : mux
        port map (
            inputs => inputs(31 downto 16),
            sel => mux2_sel,
            output => output2
        );

    process(en1, en2, sel) begin
        if en1 = '1' then
            mux1_sel <= sel;
        elsif en2 = '1' then
            mux2_sel <= sel;
        end if;
    end process;
end Behavioral;
