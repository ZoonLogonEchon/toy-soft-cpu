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

entity tb_instr_mem is
end tb_instr_mem;

architecture Behavioral of tb_instr_mem is
constant takt  : time := 20 ns;

signal clk: std_logic;
signal rst: std_logic;
signal en : std_logic;
signal ld : std_logic;
signal counter_out: std_logic_vector(31 downto 0);
signal counter_in: std_logic_vector(31 downto 0);


--signal wea:  std_logic; --write enable a port
--signal web:  std_logic; --write enable b port
signal addr:  std_logic_vector (7 downto 0);--addr for a port
signal di:  std_logic_vector (31 downto 0); --data in a port
signal do: std_logic_vector (31 downto 0);--data out a port
--signal dob: std_logic_vector (31 downto 0);--data out b port

begin

pcounter : entity work.pcounter
port map(
clk =>clk,
rst => rst,
en => en,
ld => ld,
counter_in => counter_in,
counter_out => counter_out
);

uut: entity work.instr_mem
port map(
clk => clk,
en => '1',
we => '0',
addr => counter_out(9 downto 2),
di => di,
do => do--,
--dob => dob
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
rst <= '1';
wait for takt;
ld <= '0';
en <= '1';
wait for takt;
rst <= '0';
--addra <= counter_out(9 downto 2);
--wait for takt;

--addra <= x"0F";
wait for takt*10;
wait;
end process;


end Behavioral;
