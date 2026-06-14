----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/19/2018 07:26:41 PM
-- Design Name: 
-- Module Name: if_id_plstep - Behavioral
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

entity if_id_plstep is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           we : in STD_LOGIC;
           in_pc: in std_logic_vector(31 downto 0);
           in_bubble: in std_logic;
           
           out_pc: out std_logic_vector(31 downto 0);
           out_bubble: out std_logic);
end if_id_plstep;

architecture Behavioral of if_id_plstep is

signal pc : std_logic_vector(31 downto 0) := (others => '0');
signal bubble : std_logic := '0';

begin

process(clk)
begin
    if clk'event and clk = '1'then
        if rst = '1'then
        
           pc <= (others => '0');
           bubble <=  '0';
        elsif en = '1' then
            if we = '1' then
            
                 pc <= in_pc;
                 bubble <= in_bubble;
                 
            else
            
                pc <= pc;
                bubble <= bubble;
                
            end if;
        end if;
    end if;
end process;

out_pc <= pc;
out_bubble <= bubble;

end Behavioral;
