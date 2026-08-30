----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2018 10:07:11 AM
-- Design Name: 
-- Module Name: regfile - Behavioral
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

library xil_defaultlib;


entity tb_alu is
end tb_alu;

architecture Behavioral of tb_alu is
signal ctrl : std_logic_vector(3 downto 0);
signal a: std_logic_vector(31 downto 0);
signal b: std_logic_vector(31 downto 0);
signal c: std_logic_vector(31 downto 0);
begin
uut: entity xil_defaultlib.alu
port map(
    ctrl => ctrl,
    a => a,
    b => b,
    c => c
);
stimuli : process
begin
-- AND
a(31 downto 4) <= (others => '0');
b(31 downto 4) <= (others => '0');
a(3 downto 0) <= "1010";
b(3 downto 0) <= "1100";
ctrl <= "0000";
-- c(3 downto 0 ) should be 0x8
wait for 50 ns;

-- OR
a(3 downto 0) <= "1010";
b(3 downto 0) <= "1100";
ctrl <= "0001";
-- c(3 downto 0 ) should be 0xE
wait for 50 ns;

-- ADD
a(3 downto 0) <= "1010";
b(3 downto 0) <= "1100";

ctrl <= "0010";
-- c(3 downto 0 ) should be "10110" or 0x16
wait for 50 ns;

-- LUI
b(15 downto 0) <= x"ABCD";

ctrl <= "0100";
-- c(31 downto 16 ) should be 0xABCD 0000
wait for 10 ns;
b(15 downto 0) <= x"0000";
wait for 40 ns;

-- XOR
a(3 downto 0) <= "1010";
b(3 downto 0) <= "1100";

ctrl <= "0101";
-- c(3 downto 0 ) should be "0110" or 0x6
wait for 50 ns;

-- SUB
a(3 downto 0) <= "1010";
b(3 downto 0) <= "1000";

ctrl <= "0110";
-- c(3 downto 0 ) should be "0010" or 0x2
wait for 50 ns;

-- SLT 1
a(3 downto 0) <= "1010";
b(3 downto 0) <= "1100";

ctrl <= "0111";
-- c(3 downto 0 ) should be "0001"
wait for 50 ns;

-- SLT 2
a(3 downto 0) <= "1010";
b(3 downto 0) <= "1000";

ctrl <= "0111";
-- c(3 downto 0 ) should be "0000"
wait for 50 ns;

-- NOR
a(3 downto 0) <= "1010";
b(3 downto 0) <= "1000";

ctrl <= "1100";
-- c should be 0xFFFF FFF5
wait for 50 ns;
wait;
end process;
end Behavioral;