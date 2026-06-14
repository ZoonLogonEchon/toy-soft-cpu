----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/19/2018 07:26:41 PM
-- Design Name: 
-- Module Name: mem_wb_plstep - Behavioral
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

entity mem_wb_plstep is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           we : in STD_LOGIC;
           in_w_data : in STD_LOGIC_VECTOR (31 downto 0);
           in_we_reg : in STD_LOGIC;
           in_sel_mem : in STD_LOGIC;
           in_w_addr : in STD_LOGIC_VECTOR (4 downto 0);
           
           out_w_data : out STD_LOGIC_VECTOR (31 downto 0);
           out_we_reg : out STD_LOGIC;
           out_sel_mem : out STD_LOGIC;
           out_w_addr : out STD_LOGIC_VECTOR (4 downto 0));
end mem_wb_plstep;

architecture Behavioral of mem_wb_plstep is

signal w_data : std_logic_vector(31 downto 0) := (others => '0');
signal we_reg : std_logic := '0';
signal sel_mem : std_logic := '0';
signal w_addr : std_logic_vector(4 downto 0) := (others => '0');

begin

process(clk)
begin
    if clk'event and clk = '1'then
        if rst = '1'then
        
            w_data <= (others => '0');
            we_reg <= '0';
            sel_mem <= '0';
            w_addr <= (others => '0');
            
        elsif en = '1' then
            if we = '1' then
            
                 w_data <= in_w_data;
                 we_reg <= in_we_reg;
                 sel_mem <= in_sel_mem;
                 w_addr <= in_w_addr;
                 
            else
            
                w_data <=  w_data ;
                we_reg <= we_reg ;
                sel_mem <= sel_mem ;
                w_addr <= w_addr ;
                
            end if;
        end if;
    end if;
end process;

out_w_data <=  w_data;
out_we_reg <= we_reg ;
out_sel_mem <= sel_mem ;
out_w_addr <= w_addr ;

end Behavioral;
