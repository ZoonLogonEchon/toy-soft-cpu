----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/23/2018 10:48:03 AM
-- Design Name: 
-- Module Name: forward_unit - Behavioral
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

entity forward_unit is
    Port (  mem_stage_dest: in std_logic_vector(4 downto 0);
            wb_stage_dest: in std_logic_vector(4 downto 0);
            ex_stage_dest: in std_logic_vector(4 downto 0);
            mem_stage_we: in std_logic;
            wb_stage_we: in std_logic;
            ex_stage_we: in std_logic;
            src_0: in std_logic_vector(4 downto 0);
            src_1: in std_logic_vector(4 downto 0);
            forward_a: out std_logic_vector(1 downto 0);
            forward_b: out std_logic_vector(1 downto 0));
end forward_unit;

architecture Behavioral of forward_unit is

begin

forward_a_proc: process(src_0,ex_stage_dest,ex_stage_we ,mem_stage_dest,wb_stage_dest,mem_stage_we,wb_stage_we)
begin
    if (src_0 = ex_stage_dest and ex_stage_we = '1') then
        forward_a <= "11";
    elsif(src_0 = mem_stage_dest and mem_stage_we = '1')then
        forward_a <= "10";
    elsif (src_0 = wb_stage_dest and wb_stage_we = '1') then
        forward_a <= "01";
    else
        forward_a <= "00";
    end if;
end process;

forward_b_proc: process(src_1,ex_stage_dest,ex_stage_we,mem_stage_dest,wb_stage_dest,mem_stage_we,wb_stage_we)
begin
    if (src_1 = ex_stage_dest and ex_stage_we = '1') then 
        forward_b <= "11";
    elsif(src_1 = mem_stage_dest and mem_stage_we = '1')then
        forward_b <= "10";
    elsif (src_1 = wb_stage_dest and wb_stage_we = '1') then
        forward_b <= "01";
    else
        forward_b <= "00";
    end if;
end process;
end Behavioral;
