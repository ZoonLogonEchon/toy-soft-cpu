----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2018 09:55:53 AM
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    -- TODO sign flag
    --      zero flag
    Port ( ctrl : in STD_LOGIC_VECTOR (3 downto 0);
           a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           c : out STD_LOGIC_VECTOR (31 downto 0));
end alu;

architecture Behavioral of alu is
signal result : std_logic_vector(31 downto 0) := (others => '0');
begin
alu_p: process(a,b,ctrl)
begin
    case(ctrl) is
        when "0000"=> result <= a and b; -- AND
        when "0001" => result <= a or b; -- OR
        when "0010" => result <= std_logic_vector(signed(a) + signed(b)); -- ADD
        when "0100" => result(31 downto 16) <= b(15 downto 0);
                       result(15 downto 0 ) <= (others => '0'); -- LUI
        when "0101" => result <= a xor b; -- XOR
        when "0110" => result <= std_logic_vector(signed(a) - signed(b)); -- SUB
        when "0111" => if (signed(a) < signed(b)) then
                        result(0) <= '1';
                        result(31 downto 1) <= (others => '0');
                       else
                        result <= (others => '0');
                       end if; -- SLT
        when "1100" => result <= a nor b; -- NOR
        when others => result <= (others => '0'); 
    end case;
    
end process;
c <= result;
end Behavioral;
