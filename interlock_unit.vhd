----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2018 12:10:08 PM
-- Design Name: 
-- Module Name: interlock_unit - Behavioral
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

entity interlock_unit is
    Port ( 
            ex_sel_mem : in STD_LOGIC;
            mem_sel_mem : in STD_LOGIC;
            src_0 : in std_logic_vector(4 downto 0);
            src_1 : in std_logic_vector(4 downto 0);
            ex_ld_dest: in std_logic_vector(4 downto 0);
            mem_ld_dest: in std_logic_vector(4 downto 0);
            not_stall : out std_logic);
end interlock_unit;

architecture Behavioral of interlock_unit is

begin

lock: process(src_0,src_1,ex_ld_dest,ex_sel_mem,mem_ld_dest,mem_sel_mem)
begin
    if((src_0 = ex_ld_dest or src_1 = ex_ld_dest) and ex_sel_mem = '1')then
        not_stall <= '0';
    elsif ((src_0 = mem_ld_dest or src_1 = mem_ld_dest) and mem_sel_mem = '1') then
        not_stall <= '0';
    else
        not_stall <= '1';
    end if;
end process;

end Behavioral;
