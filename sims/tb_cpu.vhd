----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/04/2018 03:56:59 PM
-- Design Name: 
-- Module Name: tb_cpu - Behavioral
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

entity tb_cpu is
end tb_cpu;

architecture Behavioral of tb_cpu is

constant takt  : time := 50 ns;
signal clk : std_logic;
signal rst : std_logic;
signal test_out : std_logic;
begin
generate_sim_clock: process
begin
	clk <= '1';
	wait for takt/2;
	clk <= '0';
	wait for takt/2;
end process;

uut : entity work.cpu
port map(
    clk => clk,
    rst => rst,
    dummy_out => test_out
);

stimuli: process
begin
rst <= '1';
wait for takt*2;
rst <= '0';
wait for takt*10;
wait;
end process;
end Behavioral;
