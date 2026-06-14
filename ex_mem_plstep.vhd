----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/19/2018 07:26:41 PM
-- Design Name: 
-- Module Name: ex_mem_plstep - Behavioral
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

entity ex_mem_plstep is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           we : in STD_LOGIC;
           
           in_alu_c : in STD_LOGIC_VECTOR (31 downto 0);
           in_mem_data: in STD_LOGIC_VECTOR (31 downto 0);
           in_we_reg : in STD_LOGIC;
           in_w_addr : in STD_LOGIC_VECTOR (4 downto 0);
           in_we_mem: in std_logic;
           in_sel_mem: in std_logic;
           
           out_we_reg : out STD_LOGIC;
           out_w_addr : out STD_LOGIC_VECTOR (4 downto 0);
           out_alu_c : out STD_LOGIC_VECTOR (31 downto 0);
           out_mem_data : out STD_LOGIC_VECTOR (31 downto 0);
           out_we_mem: out std_logic;
           out_sel_mem: out std_logic
           );
end ex_mem_plstep;

architecture Behavioral of ex_mem_plstep is

signal alu_c : std_logic_vector(31 downto 0) := (others => '0');
signal mem_data : std_logic_vector(31 downto 0) := (others => '0');
signal we_reg : std_logic := '0';
signal w_addr : std_logic_vector(4 downto 0) := (others => '0');
signal we_mem : std_logic := '0';
signal sel_mem : std_logic := '0';

begin

process(clk)
begin
    if clk'event and clk = '1'then
        if rst = '1'then
        
            alu_c <= (others => '0');
            mem_data <= (others => '0');
            we_reg <= '0';
            w_addr <= (others => '0');
            we_mem <= '0';
            sel_mem <= '0';
            
            
        elsif en = '1' then
            if we = '1' then
            
                 alu_c <= in_alu_c;
                 mem_data <= in_mem_data;
                 we_reg <= in_we_reg;
                 w_addr <= in_w_addr;
                 we_mem <= in_we_mem;
                 sel_mem <= in_sel_mem;
                 
            else
            
                alu_c <=  alu_c ;
                mem_data<=  mem_data;
                we_reg <= we_reg ;
                w_addr <= w_addr ;
                we_mem <= we_mem ;
                sel_mem <= sel_mem ;
                
            end if;
        end if;
    end if;
end process;

out_alu_c <=  alu_c ;
out_mem_data <=  mem_data ;
out_we_reg <= we_reg ;
out_w_addr <= w_addr ;
out_we_mem <= we_mem ;
out_sel_mem <= sel_mem ;
end Behavioral;
