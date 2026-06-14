----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2018 03:20:45 PM
-- Design Name: 
-- Module Name: pcounter - Behavioral
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

entity pcounter is
--  Port ( );
port(
	clk        : in  std_logic;
	rst        : in  std_logic;
	en           : in std_logic;
	ld           : in std_logic;
	counter_in : in std_logic_vector(31 downto 0);	
	counter_out : out std_logic_vector(31 downto 0)
);
end pcounter;

architecture Behavioral of pcounter is
    signal counter          : std_logic_vector(31 downto 0) := (others => '0');
begin
    set_counter: process(clk)
    begin
        if(rising_edge(clk)) then
                if(rst='1') then
                    counter <= (others => '0');
                else
                    if (en = '1') then
                        if(ld = '1')then
                            counter <= counter_in;
                        else
                            counter <= std_logic_vector(unsigned(counter) + 4 );
                        end if;
                    end if; 
                end if;
         end if;
     end process;
counter_out <= counter;
end Behavioral;
