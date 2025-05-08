library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ro is
  Port ( 
     en: in std_logic;
     ro_out: out std_logic
  );
end ro;

architecture Behavioral of ro is
    signal w1, w2, w3, w4, w5, w6, w7, w8, w9: std_logic;

    attribute dont_touch: string;
    attribute dont_touch of w1, w2, w3, w4, w5, w6, w7, w8, w9: signal is "true";

begin

    w1 <= en and not w9;
    w2 <= not w1 after 10 ns;
    w3 <= not w2 after 10 ns;
    w4 <= not w3 after 10 ns;
    w5 <= not w4 after 10 ns;
    w6 <= not w5 after 10 ns;
    w7 <= not w6 after 10 ns;
    w8 <= not w7 after 10 ns;
    w9 <= not w8 after 10 ns;
    ro_out <= w9 after 10 ns;

end Behavioral;
