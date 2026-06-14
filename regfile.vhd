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


entity regfile is
    port ( 
    r_addr_0 : in STD_LOGIC_VECTOR(4 downto 0);    
    r_addr_1 : in STD_LOGIC_VECTOR(4 downto 0);
    w_addr_0 : in STD_LOGIC_VECTOR(4 downto 0);
    r_data_0 : out STD_LOGIC_VECTOR(31 downto 0);
    r_data_1 : out STD_LOGIC_VECTOR(31 downto 0);
    w_data_0 : in STD_LOGIC_VECTOR(31 downto 0);
    w_enable: in STD_LOGIC;
    rst : in STD_LOGIC;
    clk: in STD_LOGIC);
end regfile;

architecture Behavioral of regfile is
type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
signal regs : reg_array;
begin
process(clk)
begin
    if(rising_edge(clk)) then
        if(rst = '1') then
            regs<= (others => (others => '0'));             
        elsif(w_enable = '1') then
                regs(to_integer(unsigned(w_addr_0))) <= w_data_0;
        else
                regs <= regs;
        end if;
    end if;
end process;
r_data_0 <= regs(to_integer(unsigned(r_addr_0)));
r_data_1 <= regs(to_integer(unsigned(r_addr_1)));
end Behavioral;
