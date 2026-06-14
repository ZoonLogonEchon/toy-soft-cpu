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
    Port (  clk : in std_logic;
            rst : in std_logic;
            led : out std_logic);
end tb_cpu;

architecture Behavioral of tb_cpu is
begin

uut : entity work.cpu
port map(
    clk => clk,
    rst => rst,
    dummy_out => led
);
--led <= rst;
end Behavioral;
