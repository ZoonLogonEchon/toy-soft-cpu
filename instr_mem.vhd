----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2018 02:31:19 PM
-- Design Name: 
-- Module Name: data_mem - Behavioral
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

entity instr_mem_bram is
Port ( 
    clk: in std_logic;
    en: in std_logic;
    we: in std_logic; --write enable 
    addr: in std_logic_vector (7 downto 0);--addr 
    di: in std_logic_vector (31 downto 0); --data in
    do: out std_logic_vector (31 downto 0) --data out 
);
end instr_mem_bram;

architecture Behavioral of instr_mem_bram is
type ram_type is array (0 to 255) of
std_logic_vector (31 downto 0);
shared variable RAM: ram_type := (
x"00000000",
x"00000000",
x"00000000",
x"3c088000",
x"ac082000",
others => (others => '0'));
begin
process (clk)
begin
    if clk'event and clk = '1' then
        if en = '1' then
            if we = '1' then
                RAM(to_integer (unsigned (addr))) := di;
            end if;
            do <= RAM (to_integer (unsigned (addr)));
        end if;
    end if;
end process;

end Behavioral;
