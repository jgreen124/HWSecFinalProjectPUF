library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ro_array is
    Port (
        en : in std_logic;
        ro_array_out : out std_logic_vector(31 downto 0)
     );
end ro_array;

architecture Behavioral of ro_array is

    component ro
        port(
            en : in  std_logic;
            ro_out : out std_logic
        );
    end component;

begin

    gen_ro_array : for i in 0 to 31 generate
        ro_inst : ro
            port map (
                en => en,
                ro_out => ro_array_out(i)
            );
    end generate;

end Behavioral;
