----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/19/2018 07:26:41 PM
-- Design Name: 
-- Module Name: id_ex_plstep - Behavioral
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

entity id_ex_plstep is
    Port ( in_alu_a : in STD_LOGIC_VECTOR (31 downto 0);
           in_alu_b : in STD_LOGIC_VECTOR (31 downto 0);
           in_mem_data : in STD_LOGIC_VECTOR (31 downto 0);
           in_alu_ctrl : in STD_LOGIC_VECTOR (3 downto 0);
           in_imm : in STD_LOGIC_VECTOR (31 downto 0);
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           in_we_mem : in std_logic;
           in_sel_mem : in std_logic;
           in_we_reg : in STD_LOGIC;
           in_w_addr : in STD_LOGIC_VECTOR (4 downto 0);
           in_src_reg_0 : in STD_LOGIC_VECTOR (4 downto 0);
           in_src_reg_1: in STD_LOGIC_VECTOR (4 downto 0);
           in_op_type: in STD_LOGIC_VECTOR (1 downto 0);
           
           out_alu_a : out STD_LOGIC_VECTOR (31 downto 0);
           out_alu_b : out STD_LOGIC_VECTOR (31 downto 0);
           out_mem_data : out STD_LOGIC_VECTOR (31 downto 0);
           out_b_target : out STD_LOGIC_VECTOR (31 downto 0);
           out_imm : out STD_LOGIC_VECTOR (31 downto 0);
           out_pc : out STD_LOGIC_VECTOR (31 downto 0);
           out_we_mem: out std_logic;
           out_sel_mem: out std_logic;
           out_branch: out std_logic;
           out_we_reg : out STD_LOGIC;
           out_w_addr : out STD_LOGIC_VECTOR (4 downto 0);
           out_src_reg_0 : out STD_LOGIC_VECTOR (4 downto 0);
           out_src_reg_1 : out STD_LOGIC_VECTOR (4 downto 0);
           out_alu_ctrl : out STD_LOGIC_VECTOR (3 downto 0);
           out_op_type: out STD_LOGIC_VECTOR (1 downto 0);
           we : in STD_LOGIC);
end id_ex_plstep;

architecture Behavioral of id_ex_plstep is

signal alu_a : std_logic_vector(31 downto 0) := (others => '0');
signal alu_b : std_logic_vector(31 downto 0) := (others => '0');
signal mem_data : std_logic_vector(31 downto 0) := (others => '0');
signal imm : std_logic_vector(31 downto 0) := (others => '0');
signal alu_ctrl : std_logic_vector(3 downto 0) := (others => '0');
signal we_reg : std_logic := '0';
signal w_addr : std_logic_vector(4 downto 0) := (others => '0');
signal src_reg_0 : std_logic_vector(4 downto 0) := (others => '0');
signal src_reg_1 : std_logic_vector(4 downto 0) := (others => '0');
signal we_mem : std_logic := '0';
signal sel_mem : std_logic := '0';
signal op_type: std_logic_vector(1 downto 0);
begin

process(clk)
begin
    if clk'event and clk = '1'then
        if rst = '1'then
        
            alu_a <= (others => '0');
            alu_b <= (others => '0');
            mem_data <= (others => '0');
            alu_ctrl <= (others => '0');
            imm <= (others => '0');
            we_reg <= '0';
            w_addr <= (others => '0');
            src_reg_0 <= (others => '0');
            src_reg_1 <= (others => '0');
            op_type <= (others => '0');
            we_mem <= '0';
            sel_mem <= '0';
            
            
        elsif en = '1' then
            if we = '1' then
            
                 alu_a <= in_alu_a;
                 alu_b <= in_alu_b ;
                 mem_data <= in_mem_data ;
                 alu_ctrl <= in_alu_ctrl;
                 imm <= in_imm;
                 we_reg <= in_we_reg;
                 w_addr <= in_w_addr;
                 src_reg_0 <= in_src_reg_0;
                 src_reg_1 <= in_src_reg_1;
                 op_type <= in_op_type;
                 we_mem <= in_we_mem;
                 sel_mem <= in_sel_mem;
            else
            
                alu_a <=  alu_a ;
                alu_b <= alu_b ;
                mem_data <= mem_data ;
                alu_ctrl <= alu_ctrl ;
                imm <= imm ;
                we_reg <= we_reg ;
                w_addr <= w_addr ;
                src_reg_0 <= src_reg_0 ;
                src_reg_1 <= src_reg_1 ;
                op_type <= op_type;
                we_mem <= we_mem;
                sel_mem <= sel_mem;
            end if;
        end if;
    end if;
end process;

out_alu_a <=  alu_a ;
out_alu_b <= alu_b ;
out_mem_data <= mem_data ;
out_alu_ctrl <= alu_ctrl ;
out_we_reg <= we_reg ;
out_w_addr <= w_addr ;
out_src_reg_0 <= src_reg_0 ;
out_src_reg_1 <= src_reg_1;
out_op_type <= op_type;
out_we_mem <= we_mem;
out_sel_mem <= sel_mem;
out_imm <= imm;

end Behavioral;
