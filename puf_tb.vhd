library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity puf_tb is
end puf_tb;

architecture Behavioral of puf_tb is

    component puf is
        Port (
            clk        : in  std_logic;
            led_toggle : in  std_logic;
            en         : in  std_logic;
            en_mux1    : in  std_logic;
            en_mux2    : in  std_logic;
            challenge  : in  std_logic_vector(3 downto 0);
            led        : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk        : std_logic := '0';
    signal led_toggle : std_logic := '0';
    signal en         : std_logic := '0';
    signal en_mux1    : std_logic := '0';
    signal en_mux2    : std_logic := '0';
    signal challenge  : std_logic_vector(3 downto 0) := (others => '0');
    signal led        : std_logic_vector(3 downto 0);

    constant DEBOUNCE_TIME : time := 30 ms;  -- Shortened for simulation

begin

    -- Instantiate DUT
    DUT : puf
        port map (
            clk        => clk,
            led_toggle => led_toggle,
            en         => en,
            en_mux1    => en_mux1,
            en_mux2    => en_mux2,
            challenge  => challenge,
            led        => led
        );

    -- 100 MHz clock
    clk_gen : process
    begin
        while true loop
            clk <= '0'; wait for 4 ns;
            clk <= '1'; wait for 4 ns;
        end loop;
    end process;

    -- Stimulus Process
    stim_proc : process
        type challenge_array is array (natural range <>) of std_logic_vector(3 downto 0);
        constant mux1_vals : challenge_array := (
            "0001", "0010", "0011", "0100"
        );
        constant mux2_vals : challenge_array := (
            "1000", "1001", "1010", "1011"
        );
    begin
        wait for 100 ns;

        for i in 0 to mux1_vals'length - 1 loop
            -- Program MUX1
            challenge <= mux1_vals(i);
            wait for 10 ns;
            en_mux1 <= '1';
            wait for 10 ns;
            en <= '1';
            wait for DEBOUNCE_TIME;
            en_mux1 <= '0';
            wait for 10 ns;
            en <= '0';

            -- Program MUX2
            challenge <= mux2_vals(i);
            wait for 10 ns;
            en_mux2 <= '1';
            wait for 10 ns;
            en <= '1';
            wait for DEBOUNCE_TIME;
            en_mux2 <= '0';
            wait for 10 ns;
            en <= '0';

            wait for 500 ns; -- time to observe LED output
        end loop;

        wait;
    end process;

end Behavioral;
