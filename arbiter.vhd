library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity arbiter is
    Port (
        clk             : in std_logic;
        en              : in std_logic;
        input1          : in std_logic;
        input2          : in std_logic;
        time_difference : out std_logic_vector(15 downto 0)
    );
end arbiter;

architecture Behavioral of arbiter is

    constant TARGET_EDGES : unsigned(15 downto 0) := x"FFFF";

    type state_type is (IDLE, MEASURING, DONE);
    signal state : state_type := IDLE;

    signal edge_count1, edge_count2 : unsigned(15 downto 0) := (others => '0');
    signal timer1, timer2 : unsigned(31 downto 0) := (others => '0');
    signal prev1, prev2 : std_logic := '0';
    signal done1, done2 : std_logic := '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then

            case state is

                when IDLE =>
                    if en = '1' then
                        edge_count1 <= (others => '0');
                        edge_count2 <= (others => '0');
                        timer1      <= (others => '0');
                        timer2      <= (others => '0');
                        prev1       <= '0';
                        prev2       <= '0';
                        done1       <= '0';
                        done2       <= '0';
                        time_difference <= (others => '0');
                        state <= MEASURING;
                    end if;

                when MEASURING =>
                    if done1 = '0' then
                        if input1 = '1' and prev1 = '0' then
                            edge_count1 <= edge_count1 + 1;
                        end if;
                        if edge_count1 < TARGET_EDGES then
                            timer1 <= timer1 + 1;
                        else
                            done1 <= '1';
                        end if;
                    end if;

                    if done2 = '0' then
                        if input2 = '1' and prev2 = '0' then
                            edge_count2 <= edge_count2 + 1;
                        end if;
                        if edge_count2 < TARGET_EDGES then
                            timer2 <= timer2 + 1;
                        else
                            done2 <= '1';
                        end if;
                    end if;

                    prev1 <= input1;
                    prev2 <= input2;

                    if done1 = '1' and done2 = '1' then
                        if timer1 > timer2 then
                            time_difference <= std_logic_vector(resize(timer1 - timer2, 16));
                        else
                            time_difference <= std_logic_vector(resize(timer2 - timer1, 16));
                        end if;
                        state <= DONE;
                    end if;

                when DONE =>
                    if en = '0' then
                        state <= IDLE;
                    end if;

            end case;
        end if;
    end process;

end Behavioral;
