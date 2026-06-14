library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity cpu is
    Port (  clk : in std_logic;
            rst : in std_logic;
            dummy_out : out std_logic);
end cpu;

architecture behave of cpu is


-- INSTR FETCH STUFE ---------------------------
signal if_pc :  std_logic_vector(31 downto 0) := (others => '0');
signal if_jump_en :  std_logic:= '0';
signal if_instr : std_logic_vector(31 downto 0) := (others => '0'); 
signal we_if_id : std_logic := '1';
------------------------------------------------

-- INSTR DECODE STUFE --------------------------
signal id_mem_data : std_logic_vector(31 downto 0):= (others => '0');
signal id_alu_ctrl: std_logic_vector(3 downto 0):= (others => '0');
signal id_b_target: std_logic_vector(31 downto 0):= (others => '0');
signal id_pc :  std_logic_vector(31 downto 0) := (others => '0');
signal id_instr : std_logic_vector(31 downto 0) := (others => '0'); 
signal id_jump_addr : std_logic_vector(31 downto 0) := (others => '0');
signal id_r_data_0 : std_logic_vector(31 downto 0);
signal id_r_data_1 : std_logic_vector(31 downto 0);
signal id_we_reg: std_logic := '0';
signal id_branch: std_logic := '0';
signal id_jump_en: std_logic := '0';
signal id_w_addr: std_logic_vector(4 downto 0):= (others => '0');
signal id_src_reg_0 : std_logic_vector(4 downto 0) := (others => '0');
signal id_src_reg_1: std_logic_vector(4 downto 0)  := (others => '0');
signal id_we_mem: std_logic := '0';
signal id_sel_mem: std_logic := '0'; 
signal en_id_ex: std_logic := '1';
signal we_id_ex: std_logic := '1';
signal id_op_type: std_logic_vector(1 downto 0) := "00";

signal idex_mem_data : std_logic_vector(31 downto 0):= (others => '0');
signal idex_alu_ctrl: std_logic_vector(3 downto 0):= (others => '0');
signal idex_imm : std_logic_vector(31 downto 0) := (others => '0');
signal idex_r_data_0 : std_logic_vector(31 downto 0);
signal idex_r_data_1 : std_logic_vector(31 downto 0);
signal idex_we_reg: std_logic := '0';
signal idex_w_addr: std_logic_vector(4 downto 0):= (others => '0');
signal idex_src_reg_0 : std_logic_vector(4 downto 0) := (others => '0');
signal idex_src_reg_1: std_logic_vector(4 downto 0)  := (others => '0');
signal idex_we_mem: std_logic := '0';
signal idex_sel_mem: std_logic := '0';
signal idex_op_type: std_logic_vector(1 downto 0) := "00";
------------------------------------------------

-- EXECUTE STUFE -------------------------------
signal ex_alu_a : std_logic_vector(31 downto 0):= (others => '0');
signal ex_alu_b : std_logic_vector(31 downto 0):= (others => '0');
signal ex_alu_c : std_logic_vector(31 downto 0):= (others => '0');
signal ex_mem_data : std_logic_vector(31 downto 0):= (others => '0');
signal ex_imm : std_logic_vector(31 downto 0):= (others => '0');
signal ex_alu_ctrl : std_logic_vector(3 downto 0):= (others => '0');
signal ex_we_mem : std_logic := '0';
signal ex_sel_mem : std_logic := '0';
signal en_ex_mem: std_logic:= '1';
signal we_ex_mem: std_logic:= '1';
signal ex_we_reg: std_logic := '0';
signal ex_w_addr: std_logic_vector(4 downto 0):= (others => '0');
signal ex_src_reg_0 : std_logic_vector(4 downto 0) := (others => '0');
signal ex_src_reg_1: std_logic_vector(4 downto 0)  := (others => '0');
signal ex_op_type: std_logic_vector(1 downto 0) := "00";
-----------------------------------------------

-- MEM STUFE ----------------------------------
signal mem_alu_c : std_logic_vector(31 downto 0):= (others => '0');
signal mem_mem_data : std_logic_vector(31 downto 0):= (others => '0');
signal mem_we_reg: std_logic := '0';
signal mem_w_addr: std_logic_vector(4 downto 0):= (others => '0');
signal mem_we_mem: std_logic := '0';
signal mem_sel_mem: std_logic := '0';
signal en_mem : std_logic := '1';
signal we_mem : std_logic := '1';


------------------------------------------------

-- WB STUFE -----------------------
signal wb_w_addr :std_logic_vector(4 downto 0):= (others => '0');
signal wb_data : std_logic_vector(31 downto 0):= (others => '0');
signal wb_sel_mem: std_logic := '0';
signal wb_we_reg : std_logic := '0'; 
signal en_mem_wb : std_logic := '1';
signal we_mem_wb : std_logic := '1';
-----------------------------------------
-- decode unit signals ------------------------------
--signal alu_ctrl: std_logic_vector(3 downto 0);
-----------------------------------------------------

-- pc signals ------------------------------------

signal pc_out :  std_logic_vector(31 downto 0) := (others => '0');

------------------------------------------------
----------------------------------------------
--------------------------------------------------
-- data_mem signals-------
signal en_data: std_logic := '1';
signal data_out : std_logic_vector(31 downto 0) := (others => '0'); 
--------------------------
-- regfile signals ------
signal w_reg_0 :   std_logic_vector(4 downto 0) := (others => '0');
signal w_data : std_logic_vector(31 downto 0) := (others => '0');
signal w_reg_en: std_logic := '1';
signal r_data_0 : std_logic_vector(31 downto 0);
signal r_data_1 : std_logic_vector(31 downto 0);
-----------------------

signal opcode : std_logic_vector(5 downto 0);
signal immediate:    std_logic_vector(31 downto 0);

-- FORWARDING SIGNALS -------------------------
signal fw_a_ctrl: std_logic_vector(1 downto 0) := "00";
signal fw_b_ctrl: std_logic_vector(1 downto 0) := "00";
-----------------------------------------------


signal alu_b : std_logic_vector(31 downto 0):= (others => '0');

signal not_stall : std_logic := '1' ;

begin


-- IF -------------------------------
pc: entity work.pcounter
port map(
    clk => clk,
    rst => rst,
    en => not_stall,
    ld => if_jump_en,
    counter_in => id_jump_addr,
    counter_out => pc_out
);

instr_mem: entity work.instr_mem_bram
port map(
    clk => clk,
    en => not_stall,
    we => '0',
    addr => pc_out(9 downto 2),
    di => (others => '0'),
    do => if_instr
);

if_pc <=  std_logic_vector(unsigned(pc_out) + 4);
-- IF/ID -------------------------------

ifid : entity work.if_id_plstep
port map(
    clk => clk,
    rst => rst,
    en => not_stall,
    we => we_if_id,
    
    in_pc => if_pc,
    in_bubble => if_jump_en,
   
    out_pc => id_pc,
    out_bubble => id_jump_en
);

-- ID ----------------------------------

select_instr: process(id_jump_en,if_instr)
begin 
    if id_jump_en = '1' then
        id_instr <= (others => '0');
    else 
        id_instr <= if_instr;
    end if;
end process;

instr_decode : entity work.instr_decode
port map (
    instruction => id_instr,
    src_reg_0 => id_src_reg_0,
    src_reg_1 => id_src_reg_1,
    we_regfile => id_we_reg, -- directl to plstep
    dest_reg => id_w_addr, -- directly to plstep
    alu_ctrl => id_alu_ctrl, -- directtly to plstep
    opc => opcode,
    imm => immediate,
    we_mem => id_we_mem,
    sel_mem => id_sel_mem,
    branch => id_branch,
    b_target => id_b_target,
    op_type => id_op_type
);



regfile : entity work.regfile
port map(
    clk => clk,
    rst => rst,
    r_addr_0 => id_src_reg_0,   
    r_addr_1 => id_src_reg_1,   
    w_addr_0 => wb_w_addr, -- from MEM/WB STEP
    w_data_0 => w_data,    -- from WB 
    w_enable => wb_we_reg, -- from MEM/WB STEP
    r_data_0 => r_data_0,  -- to ID/EX STEP
    r_data_1 => r_data_1   -- to ID/EX STEP
);

fw_a_proc:  process(fw_a_ctrl,r_data_0,ex_alu_c,mem_alu_c,w_data)
begin 
    if(fw_a_ctrl = "00")then
        id_r_data_0 <= r_data_0;
    elsif fw_a_ctrl = "11" then
        id_r_data_0 <= ex_alu_c;
    elsif fw_a_ctrl = "10" then
        id_r_data_0 <= mem_alu_c;
    else
        id_r_data_0 <= w_data;
    end if;
end process;

fw_b_proc:  process(fw_b_ctrl,r_data_1,ex_alu_c,mem_alu_c,w_data)
begin 
    if(fw_b_ctrl = "00")then
        id_r_data_1 <= r_data_1;
    elsif fw_b_ctrl = "11" then
        id_r_data_1 <= ex_alu_c;
    elsif fw_b_ctrl = "10" then
        id_r_data_1 <= mem_alu_c;
    else
        id_r_data_1 <= w_data;
    end if;
end process;

-- early branch decision making -----



id_jump_addr <=  std_logic_vector(unsigned(id_pc) + unsigned(id_b_target));

branch_proc:process(id_branch,id_r_data_0,id_r_data_1)
begin
    if(id_branch = '1' and id_r_data_0 = id_r_data_1)then
        if_jump_en <= '1';
    else
        if_jump_en <= '0';
    end if;
end process;

id_mem_data <= id_r_data_1;

stall : process (not_stall,id_mem_data,id_alu_ctrl,immediate,id_r_data_0,id_r_data_1,id_we_reg,id_w_addr,id_src_reg_0,id_src_reg_1,id_sel_mem,id_op_type,id_we_mem)
begin
    if( not_stall = '0')then
        idex_mem_data   <= (others => '0');
        idex_alu_ctrl  <= (others => '0');
        idex_imm  <= (others => '0');
        idex_r_data_0 <= (others => '0');
        idex_r_data_1  <= (others => '0');
        idex_we_reg <= '0';
        idex_w_addr <= (others => '0');
        idex_src_reg_0  <= (others => '0');
        idex_src_reg_1 <= (others => '0');
        idex_we_mem <= '0';
        idex_sel_mem  <= '0';
        idex_op_type <= (others => '0');
    else
        idex_mem_data   <=   id_mem_data ;
        idex_alu_ctrl  <=   id_alu_ctrl;
        idex_imm  <=   immediate;
        idex_r_data_0 <=   id_r_data_0;
        idex_r_data_1  <=   id_r_data_1;
        idex_we_reg <=   id_we_reg;
        idex_w_addr <=   id_w_addr;
        idex_src_reg_0  <=    id_src_reg_0;
        idex_src_reg_1 <=   id_src_reg_1;
        idex_we_mem <=   id_we_mem;
        idex_sel_mem  <=   id_sel_mem;
        idex_op_type <=   id_op_type;
    end if;
end process;

-- ID/EX --------------------------------------

idex : entity work.id_ex_plstep
port map(
    clk => clk,
    rst => rst,
    en => en_id_ex,
    we => we_id_ex,
    
    in_alu_a => idex_r_data_0,
    in_alu_b => idex_r_data_1,
    in_alu_ctrl => idex_alu_ctrl,
    in_we_reg => idex_we_reg,
    in_w_addr => idex_w_addr,
    in_we_mem => idex_we_mem,
    in_mem_data => idex_mem_data,
    in_sel_mem => idex_sel_mem,
    in_src_reg_0 => idex_src_reg_0,
    in_src_reg_1 => idex_src_reg_1,
    in_imm => idex_imm,
    in_op_type => idex_op_type,
    
    out_alu_a => ex_alu_a,
    out_alu_b => ex_alu_b,
    out_alu_ctrl => ex_alu_ctrl,
    out_we_reg => ex_we_reg,
    out_w_addr => ex_w_addr,
    out_we_mem => ex_we_mem,
    out_mem_data => ex_mem_data,
    out_sel_mem => ex_sel_mem,
    out_src_reg_0 => ex_src_reg_0,
    out_src_reg_1 => ex_src_reg_1,
    out_imm => ex_imm,
    out_op_type => ex_op_type

);


forward_unit : entity work.forward_unit
port map(
    mem_stage_we => mem_we_reg,
    wb_stage_we => wb_we_reg,
    ex_stage_we => ex_we_reg,
    mem_stage_dest => mem_w_addr,
    wb_stage_dest => wb_w_addr,
    ex_stage_dest => ex_w_addr,
    src_0 => id_src_reg_0,
    src_1 => id_src_reg_1,
    forward_a => fw_a_ctrl,
    forward_b => fw_b_ctrl
);

interlock: entity work.interlock_unit
port map(
    ex_sel_mem => ex_sel_mem,
    mem_sel_mem => mem_sel_mem,
    src_0 => id_src_reg_0,
    src_1 => id_src_reg_1,
    ex_ld_dest => ex_w_addr,
    mem_ld_dest => mem_w_addr,
    not_stall => not_stall
);
-- EX -----------------------------------------

alu_b <= ex_alu_b when ex_op_type = "00" else
         ex_imm when ex_op_type = "01" else
         (others => '0');

alu : entity work.alu
port map(
    ctrl => ex_alu_ctrl,
    a => ex_alu_a,
    b => alu_b,
    c => ex_alu_c
);

-- EX/MEM --------------------------------------

exmem : entity work.ex_mem_plstep
port map(
    clk => clk,
    rst => rst,
    en => en_ex_mem,
    we => we_ex_mem,
    
    in_alu_c => ex_alu_c,
    in_we_reg => ex_we_reg,
    in_w_addr => ex_w_addr,
    in_we_mem => ex_we_mem,
    in_mem_data => ex_mem_data,
    in_sel_mem => ex_sel_mem,

    out_alu_c => mem_alu_c,
    out_we_reg => mem_we_reg,
    out_w_addr => mem_w_addr,
    out_we_mem => mem_we_mem,
    out_mem_data => mem_mem_data,
    out_sel_mem => mem_sel_mem
);

-- MEM -----------------------------------------



data_mem: entity work.data_mem_bram
port map(
    clk => clk,
    en => en_data,
    we => mem_we_mem,
    addr => mem_alu_c(9 downto 2),
    di => mem_mem_data,
    do => data_out
);

-- MEM/WB --------------------------------------

memwb: entity work.mem_wb_plstep
port map(
    clk => clk,
    rst => rst,
    en => en_mem_wb,
    we => we_mem_wb,
    
    in_w_data => mem_alu_c,
    in_we_reg  => mem_we_reg,
    in_w_addr => mem_w_addr,
    in_sel_mem => mem_sel_mem,
    
    out_w_data => wb_data,
    out_we_reg  => wb_we_reg,
    out_w_addr => wb_w_addr,
    out_sel_mem => wb_sel_mem
);

select_wb_data : process(wb_sel_mem,data_out,wb_data)
begin
    if wb_sel_mem = '1' then
        w_data <= data_out;
    else
        w_data <= wb_data;
    end if;
end process;
-- END OF PIPELINE ---------------------------------
dummy_out <= not_stall;

end behave;
