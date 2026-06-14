----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2018 03:21:12 PM
-- Design Name: 
-- Module Name: instr_decode - Behavioral
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

entity instr_decode is
    Port ( instruction : in STD_LOGIC_VECTOR (31 downto 0);
           src_reg_0 : out STD_LOGIC_VECTOR (4 downto 0);
           src_reg_1 : out STD_LOGIC_VECTOR (4 downto 0);
           dest_reg : out STD_LOGIC_VECTOR (4 downto 0);
           imm : out STD_LOGIC_VECTOR (31 downto 0);
           shift : out STD_LOGIC_VECTOR (4 downto 0);
           alu_ctrl : out STD_LOGIC_VECTOR (3 downto 0);
           we_regfile: out std_logic;
           opc: out std_logic_vector(5 downto 0);
           we_mem: out std_logic;
           sel_mem: out std_logic;
           branch: out std_logic;
           b_target: out std_logic_vector(31 downto 0);
           op_type: out std_logic_vector(1 downto 0));
end instr_decode;

architecture Behavioral of instr_decode is

alias opcode : std_logic_vector(5 downto 0) is instruction(31 downto 26);
alias rs : std_logic_vector(4 downto 0) is instruction(25 downto 21);
alias rt : std_logic_vector(4 downto 0)  is instruction(20 downto 16);
alias rd :   std_logic_vector(4 downto 0) is instruction(15 downto 11);
alias immediate:    std_logic_vector(15 downto 0) is instruction(15 downto 0);
alias shamt:    std_logic_vector(4 downto 0) is instruction(10 downto 6);
alias funct:    std_logic_vector(5 downto 0) is instruction(5 downto 0);

begin

instr_decode:process(instruction)
begin
    case opcode is
    -- R - TYPE
    when "000000" => 
                     case funct is 
                     when "100100" => alu_ctrl <= "0000"; --AND
                     when "100000" => alu_ctrl <= "0010"; --ADD
                     when "100101" => alu_ctrl <= "0001"; --OR
                     when "100110" => alu_ctrl <= "0101"; --XOR
                     when "100010" => alu_ctrl <= "0110"; --SUB
                     when "101010" => alu_ctrl <= "0111"; --SLT
                     when "100111" => alu_ctrl <= "1100"; --NOR
                     when "000000" => alu_ctrl <= "0000"; --NOP
                     when others => alu_ctrl <= (others => '0');
                     end case;
                     src_reg_0 <= rs;
                     src_reg_1 <= rt;
                     dest_reg <= rd;
                     shift <= shamt;
                     we_regfile <= '1';
                     we_mem <= '0';
                     sel_mem <= '0';
                     branch <= '0';
                     op_type <= "00";
    -- I - TYPE
    --ADDI
    when "001000" =>
                       src_reg_0 <= rs;
                       src_reg_1 <= (others => '0');
                       dest_reg <= rt;
                       alu_ctrl <= "0010"; --ADD
                       shift <= shamt;
                       we_regfile <= '1';
                       we_mem <= '0';
                       sel_mem <= '0';
                       branch <= '0';
                       op_type <= "01";
                      --write_to_io_port <= '0';
        -- LUI
    when "001111" =>
                      src_reg_0 <= (others => '0');
                      src_reg_1 <= (others => '0');
                      dest_reg <= rt;
                      we_regfile <= '1';
                      alu_ctrl <= "0100"; --LUI
                      shift <= shamt;
                      we_mem <= '0';
                      sel_mem <= '0';
                      branch <= '0';
                      op_type <= "01";
         -- SW
    when "101011" =>
                      src_reg_0 <= rs; --base
                      src_reg_1 <=  rt; -- datenquell register
                      dest_reg <= rd; -- don't care
                      alu_ctrl <= "0010"; --ADD
                      shift <= shamt;
                      we_regfile <= '0';
                      we_mem <= '1';
                      sel_mem <= '0';
                      branch <= '0';
                      op_type <= "01";
    -- LW
     when "100011" =>
                      src_reg_0 <= rs; -- base
                      src_reg_1 <= (others => '0'); -- don't care
                      dest_reg  <= rt; -- daten ziel register
                      alu_ctrl <= "0010"; --ADD
                      shift <= shamt;
                      we_regfile <= '1';
                      we_mem <= '0';
                      --  propagate a signal to MUX at WB stage, that selects the data_mem instead of alu_c
                      sel_mem <= '1';
                      branch <= '0';
                      op_type <= "01";
      --              write_to_io_port <= '0'; 
   -- BEQ
     when "000100" =>
                      src_reg_0 <= rs;
                      src_reg_1 <= rt;
                      dest_reg  <= rd; 
                      shift <= shamt;
                      we_regfile <= '0';
                      alu_ctrl <= "0110"; --SUB
                      we_mem <= '0';
                      sel_mem <= '0';
                      branch <= '1';
                      op_type <= "01";
  --                    write_to_io_port <= '0';              
    when others =>       
                    -- default
                    alu_ctrl <= (others => '0');
                    src_reg_0 <= (others => '0');
                    src_reg_1 <= (others => '0');
                    dest_reg <= (others => '0');
                    shift <= (others => '0');
                    we_regfile <= '0';
                    we_mem <= '0';
                    sel_mem <= '0';
                    branch <= '0';
                    op_type <= "00";
    end case;
end process;
opc <= opcode;
imm <= std_logic_vector( resize(signed(immediate),32) );
b_target <= std_logic_vector(resize(unsigned(immediate),32) sll 2 );
end Behavioral;
