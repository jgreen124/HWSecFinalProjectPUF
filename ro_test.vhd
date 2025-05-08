library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.MATH_REAL.ALL;

entity ro_test is
  generic (
    seed1_init : positive := 1;
    seed2_init : positive := 2
  );
  port (
    en     : in std_logic;
    ro_out : out std_logic
  );
end ro_test;

architecture Behavioral of ro_test is
  signal w : std_logic_vector(1 to 9);
begin
  process
    variable seed1 : positive := seed1_init;
    variable seed2 : positive := seed2_init;
    variable rand  : real;
    variable delay : time;
  begin
    wait until en = '1';
    w(1) <= '1';
    wait for 1 ns;

    while true loop
      for i in 2 to 9 loop
        uniform(seed1, seed2, rand);
        delay := integer(5.0 + rand * 15.0) * 1 ns;
        w(i) <= not w(i - 1) after delay;
        wait for delay;
      end loop;
      uniform(seed1, seed2, rand);
      delay := integer(5.0 + rand * 15.0) * 1 ns;
      w(1) <= not w(9) after delay;
      wait for delay;
    end loop;
  end process;

  ro_out <= w(9);
end Behavioral;
