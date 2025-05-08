----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 01:29:47 PM
-- Design Name: 
-- Module Name: mux_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity mux_tb is
end mux_tb;

architecture Behavioral of mux_tb is

    component mux is
        Port (
            inputs : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            output : out std_logic
         );
    end component;

    -- Testbench signals
    signal inputs : std_logic_vector(3 downto 0) := "0000";
    signal sel : std_logic_vector(1 downto 0) := "00";
    signal output : std_logic;

begin

    sel_gen: process begin
        wait for 10 ns;
        sel <= "00";
        wait for 10 ns;
        sel <= "01";
        wait for 10 ns;
        sel <= "10";
        wait for 10 ns;
        sel <= "11";
    end process;

    inputs_gen : process begin
        wait for 2 ns;
        inputs <= std_logic_vector(unsigned(inputs) + 1);
    end process;

    DUT : mux port map (
        inputs => inputs,
        sel => sel,
        output => output
    );

end Behavioral;
