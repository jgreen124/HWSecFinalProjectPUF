library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ro_mux_array_test is
    Port (
        en : in std_logic;
        sel : in std_logic_vector(3 downto 0);
        en1, en2 : in std_logic;
        output1, output2 : out std_logic
     );
end ro_mux_array_test;

architecture Behavioral of ro_mux_array_test is

    signal ro_array_out : std_logic_vector(31 downto 0);

    component ro_array_test is
        Port (
            en : in std_logic;
            ro_array_out : out std_logic_vector(31 downto 0)
         );
    end component;

    component mux_array is
        Port (
            inputs : in std_logic_vector(31 downto 0);
            sel : in std_logic_vector(3 downto 0);
            en1, en2 : in std_logic;
            output1, output2 : out std_logic
         );
    end component;
begin

    ro_array_inst : ro_array_test
        port map (
            en => en,
            ro_array_out => ro_array_out
        );

    mux_array_inst : mux_array
        port map (
            inputs => ro_array_out,
            sel => sel,
            en1 => en1,
            en2 => en2,
            output1 => output1,
            output2 => output2
        );
end Behavioral;
