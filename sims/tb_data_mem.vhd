----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2018 03:14:44 PM
-- Design Name: 
-- Module Name: tb_instr_mem - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_data_mem is
end tb_data_mem;

architecture Behavioral of tb_data_mem is
constant takt  : time := 20 ns;

signal clk: std_logic;

signal we:  std_logic := '1'; --write enable a port
signal addr:  std_logic_vector (7 downto 0) := (others => '0');--addr for a port
signal di:  std_logic_vector (31 downto 0):= (others => '0'); --data in a port
signal do: std_logic_vector (31 downto 0);--data out a port

begin

uut: entity work.data_mem
port map(
clk => clk,
en => '1',
we => we,
addr => addr,
di => di,
do => do
);

-- generate a (virtual) simulation clock
generate_sim_clock: process
begin
	clk <= '1';
	wait for takt/2;
	clk <= '0';
	wait for takt/2;
end process;

stimuli:process
begin

wait for takt;
di <= x"Deadbeef";
wait for takt;
addr <= x"00";
wait for takt;
we <= '0';
wait for takt;
addr <= x"0A";
wait for takt;
di <= x"Badeaffe";
wait for takt;
we <= '1';
wait for takt*2;
we <= '0';
wait for takt;
addr <= x"00"; -- do should be DEADBEEF
wait for takt*2;
addr <= x"0A"; -- do should be BADEAFFE
wait for takt*10;
wait;
end process;


end Behavioral;
