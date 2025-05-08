----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 01:47:25 PM
-- Design Name: 
-- Module Name: ring_oscillator_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ring_oscillator_tb is
end ring_oscillator_tb;

architecture Behavioral of ring_oscillator_tb is

    component ro is
        Port (
            en : in std_logic;
            ro_out : out std_logic
        );
    end component;

    -- Testbench signals
    signal en : std_logic := '0';
    signal ro_out : std_logic := '0';

begin

    en_gen : process begin
        wait for 16 ns;
        en <= '0';
        wait for 16 ns;
        en <= '1';
        wait for 100 ns;
    end process;

    DUT : ro port map (
        en => en,
        ro_out => ro_out
    );

end Behavioral;
