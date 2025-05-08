library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity puf_test is
    Port (
        clk        : in  std_logic; -- 100 MHz clock
        led_toggle : in  std_logic; -- Toggles LEDs between PUF output, Mux1 select, Mux2 select
        en         : in  std_logic; -- PUF Enable
        en_mux1    : in  std_logic; -- MUX1 Select Enable
        en_mux2    : in  std_logic; -- MUX2 Select Enable
        challenge  : in  std_logic_vector(3 downto 0); -- 4-bit challenge input
        led        : out std_logic_vector(3 downto 0) -- 4-bit LED output
    );
end puf_test;

architecture Behavioral of puf_test is

    signal led_toggle_deb_raw, en_deb_raw, en_mux1_deb_raw, en_mux2_deb_raw : std_logic;
    signal led_toggle_deb, en_deb, en_mux1_deb, en_mux2_deb : std_logic;
    signal en_deb_reg : std_logic := '0';

    signal ro1, ro2 : std_logic;
    signal diff : std_logic_vector(15 downto 0);

    signal mux1_last_sel, mux2_last_sel : std_logic_vector(3 downto 0) := (others => '0');

    signal mode_state : integer range 0 to 2 := 0;

    signal toggle_prev : std_logic := '0';
    signal en_prev     : std_logic := '0';

    component debounce is
        Port (
            in0  : in  std_logic;
            clk  : in  std_logic;
            out0 : out std_logic
        );
    end component;

    component ro_mux_array_test is
        Port (
            en      : in  std_logic;
            sel     : in  std_logic_vector(3 downto 0);
            en1     : in  std_logic;
            en2     : in  std_logic;
            output1 : out std_logic;
            output2 : out std_logic
        );
    end component;

    component arbiter is
        Port (
            clk             : in  std_logic;
            en              : in  std_logic;
            input1          : in  std_logic;
            input2          : in  std_logic;
            time_difference : out std_logic_vector(15 downto 0)
        );
    end component;

begin

    debounce_toggle  : debounce port map (in0 => led_toggle, clk => clk, out0 => led_toggle_deb_raw);
    debounce_en      : debounce port map (in0 => en,         clk => clk, out0 => en_deb_raw);
    debounce_en_mux1 : debounce port map (in0 => en_mux1,    clk => clk, out0 => en_mux1_deb_raw);
    debounce_en_mux2 : debounce port map (in0 => en_mux2,    clk => clk, out0 => en_mux2_deb_raw);

    process(clk)
    begin
        if rising_edge(clk) then
            led_toggle_deb <= led_toggle_deb_raw;
            en_deb         <= en_deb_raw;
            en_mux1_deb    <= en_mux1_deb_raw;
            en_mux2_deb    <= en_mux2_deb_raw;
            en_deb_reg     <= en_deb;
        end if;
    end process;

    ro_mux_inst : ro_mux_array_test
        port map (
            en      => en_deb_reg,
            sel     => challenge,
            en1     => en_mux1_deb,
            en2     => en_mux2_deb,
            output1 => ro1,
            output2 => ro2
        );

    arb_inst : arbiter
        port map (
            clk             => clk,
            en              => en_deb,
            input1          => ro1,
            input2          => ro2,
            time_difference => diff
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if led_toggle_deb = '1' and toggle_prev = '0' then
                if mode_state = 2 then
                    mode_state <= 0;
                else
                    mode_state <= mode_state + 1;
                end if;
            end if;
            toggle_prev <= led_toggle_deb;

            if en_deb = '1' and en_prev = '0' then
                mode_state <= 0;
            end if;
            en_prev <= en_deb;

            if en_mux1_deb = '1' then
                mux1_last_sel <= challenge;
            end if;
            if en_mux2_deb = '1' then
                mux2_last_sel <= challenge;
            end if;

            case mode_state is
                when 0 => led <= diff(3 downto 0);
                when 1 => led <= mux1_last_sel;
                when 2 => led <= mux2_last_sel;
                when others => led <= (others => '0');
            end case;
        end if;
    end process;

end Behavioral;
