-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2016.4
-- Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity matmul_hw is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    a_Addr_A : OUT STD_LOGIC_VECTOR (31 downto 0);
    a_EN_A : OUT STD_LOGIC;
    a_WEN_A : OUT STD_LOGIC_VECTOR (3 downto 0);
    a_Din_A : OUT STD_LOGIC_VECTOR (31 downto 0);
    a_Dout_A : IN STD_LOGIC_VECTOR (31 downto 0);
    a_Clk_A : OUT STD_LOGIC;
    a_Rst_A : OUT STD_LOGIC;
    b_Addr_A : OUT STD_LOGIC_VECTOR (31 downto 0);
    b_EN_A : OUT STD_LOGIC;
    b_WEN_A : OUT STD_LOGIC_VECTOR (3 downto 0);
    b_Din_A : OUT STD_LOGIC_VECTOR (31 downto 0);
    b_Dout_A : IN STD_LOGIC_VECTOR (31 downto 0);
    b_Clk_A : OUT STD_LOGIC;
    b_Rst_A : OUT STD_LOGIC;
    c_Addr_A : OUT STD_LOGIC_VECTOR (31 downto 0);
    c_EN_A : OUT STD_LOGIC;
    c_WEN_A : OUT STD_LOGIC_VECTOR (3 downto 0);
    c_Din_A : OUT STD_LOGIC_VECTOR (31 downto 0);
    c_Dout_A : IN STD_LOGIC_VECTOR (31 downto 0);
    c_Clk_A : OUT STD_LOGIC;
    c_Rst_A : OUT STD_LOGIC );
end;


architecture behav of matmul_hw is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "matmul_hw,hls_ip_2016_4,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=1,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7a100tcsg324-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=8.263000,HLS_SYN_LAT=87,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=5,HLS_SYN_FF=652,HLS_SYN_LUT=659}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (5 downto 0) := "000001";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (5 downto 0) := "000010";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (5 downto 0) := "000100";
    constant ap_ST_fsm_pp0_stage2 : STD_LOGIC_VECTOR (5 downto 0) := "001000";
    constant ap_ST_fsm_pp0_stage3 : STD_LOGIC_VECTOR (5 downto 0) := "010000";
    constant ap_ST_fsm_state28 : STD_LOGIC_VECTOR (5 downto 0) := "100000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv5_0 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv4_F : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    constant ap_const_lv5_10 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv5_1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_const_lv3_1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_const_lv3_4 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv59_0 : STD_LOGIC_VECTOR (58 downto 0) := "00000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv4_4 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_const_lv5_2 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_const_lv61_1 : STD_LOGIC_VECTOR (60 downto 0) := "0000000000000000000000000000000000000000000000000000000000001";
    constant ap_const_lv5_3 : STD_LOGIC_VECTOR (4 downto 0) := "00011";
    constant ap_const_lv5_C : STD_LOGIC_VECTOR (4 downto 0) := "01100";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (5 downto 0) := "000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal indvar_flatten_reg_166 : STD_LOGIC_VECTOR (4 downto 0);
    signal i_reg_177 : STD_LOGIC_VECTOR (2 downto 0);
    signal j_reg_188 : STD_LOGIC_VECTOR (2 downto 0);
    signal exitcond_flatten_fu_210_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal exitcond_flatten_reg_367 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_pipeline_reg_pp0_iter1_exitcond_flatten_reg_367 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_pipeline_reg_pp0_iter2_exitcond_flatten_reg_367 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_pipeline_reg_pp0_iter3_exitcond_flatten_reg_367 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_pipeline_reg_pp0_iter4_exitcond_flatten_reg_367 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_pipeline_reg_pp0_iter5_exitcond_flatten_reg_367 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_pipeline_reg_pp0_iter6_exitcond_flatten_reg_367 : STD_LOGIC_VECTOR (0 downto 0);
    signal indvar_flatten_next_fu_216_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal indvar_flatten_next_reg_371 : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal j_mid2_fu_234_p3 : STD_LOGIC_VECTOR (2 downto 0);
    signal j_mid2_reg_376 : STD_LOGIC_VECTOR (2 downto 0);
    signal tmp_mid2_v_fu_242_p3 : STD_LOGIC_VECTOR (2 downto 0);
    signal tmp_mid2_v_reg_385 : STD_LOGIC_VECTOR (2 downto 0);
    signal tmp_fu_250_p3 : STD_LOGIC_VECTOR (4 downto 0);
    signal tmp_reg_390 : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_CS_fsm_pp0_stage1 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_pp0_stage1 : signal is "none";
    signal ap_CS_fsm_pp0_stage2 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_pp0_stage2 : signal is "none";
    signal ap_CS_fsm_pp0_stage3 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_pp0_stage3 : signal is "none";
    signal tmp_14_fu_352_p2 : STD_LOGIC_VECTOR (5 downto 0);
    signal tmp_14_reg_458 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_pipeline_reg_pp0_iter1_tmp_14_reg_458 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_pipeline_reg_pp0_iter2_tmp_14_reg_458 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_pipeline_reg_pp0_iter3_tmp_14_reg_458 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_pipeline_reg_pp0_iter4_tmp_14_reg_458 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_pipeline_reg_pp0_iter5_tmp_14_reg_458 : STD_LOGIC_VECTOR (5 downto 0);
    signal j_1_fu_358_p2 : STD_LOGIC_VECTOR (2 downto 0);
    signal j_1_reg_473 : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_fu_204_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_6_reg_478 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal tmp_6_1_reg_493 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_pipeline_reg_pp0_iter2_tmp_6_1_reg_493 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_6_2_reg_498 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_pipeline_reg_pp0_iter2_tmp_6_2_reg_498 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_pipeline_reg_pp0_iter3_tmp_6_2_reg_498 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_6_3_reg_503 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_pipeline_reg_pp0_iter2_tmp_6_3_reg_503 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_pipeline_reg_pp0_iter3_tmp_6_3_reg_503 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_pipeline_reg_pp0_iter4_tmp_6_3_reg_503 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_199_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal tmp_s_reg_508 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal tmp_1_1_reg_513 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal tmp_1_2_reg_518 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter4 : STD_LOGIC := '0';
    signal tmp_1_3_reg_523 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_enable_reg_pp0_iter6 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter5 : STD_LOGIC := '0';
    signal indvar_flatten_phi_fu_170_p4 : STD_LOGIC_VECTOR (4 downto 0);
    signal i_phi_fu_181_p4 : STD_LOGIC_VECTOR (2 downto 0);
    signal j_phi_fu_192_p4 : STD_LOGIC_VECTOR (2 downto 0);
    signal tmp_3_fu_258_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_2_fu_263_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_5_fu_273_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_11_cast_fu_291_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_8_fu_301_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_12_fu_310_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_10_fu_326_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_13_cast_fu_347_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_14_cast_fu_363_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal a_Addr_A_orig : STD_LOGIC_VECTOR (31 downto 0);
    signal b_Addr_A_orig : STD_LOGIC_VECTOR (31 downto 0);
    signal c_Addr_A_orig : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_199_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_199_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal exitcond_fu_228_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_1_fu_222_p2 : STD_LOGIC_VECTOR (2 downto 0);
    signal tmp_4_fu_268_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal tmp_2_cast_fu_282_p1 : STD_LOGIC_VECTOR (3 downto 0);
    signal tmp_11_fu_285_p2 : STD_LOGIC_VECTOR (3 downto 0);
    signal tmp_7_fu_296_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal tmp_9_fu_321_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal tmp_2_cast3_fu_338_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal tmp_13_fu_341_p2 : STD_LOGIC_VECTOR (4 downto 0);
    signal tmp_2_cast4_fu_335_p1 : STD_LOGIC_VECTOR (5 downto 0);
    signal tmp_3_cast_fu_318_p1 : STD_LOGIC_VECTOR (5 downto 0);
    signal ap_CS_fsm_state28 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_state28 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (5 downto 0);

    component matmul_hw_fadd_32bkb IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;


    component matmul_hw_fmul_32cud IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (31 downto 0) );
    end component;



begin
    matmul_hw_fadd_32bkb_U1 : component matmul_hw_fadd_32bkb
    generic map (
        ID => 1,
        NUM_STAGE => 5,
        din0_WIDTH => 32,
        din1_WIDTH => 32,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_199_p0,
        din1 => grp_fu_199_p1,
        ce => ap_const_logic_1,
        dout => grp_fu_199_p2);

    matmul_hw_fmul_32cud_U2 : component matmul_hw_fmul_32cud
    generic map (
        ID => 1,
        NUM_STAGE => 4,
        din0_WIDTH => 32,
        din1_WIDTH => 32,
        dout_WIDTH => 32)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => a_Dout_A,
        din1 => b_Dout_A,
        ce => ap_const_logic_1,
        dout => grp_fu_204_p2);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and not((exitcond_flatten_fu_210_p2 = ap_const_lv1_0)))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif (((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0)))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage3))) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_1;
                elsif ((((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0))) or ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3) and not((exitcond_flatten_reg_367 = ap_const_lv1_0))))) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter4_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter4 <= ap_const_logic_0;
            else
                if ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)) then 
                    ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter5_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter5 <= ap_const_logic_0;
            else
                if ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)) then 
                    ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter6_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter6 <= ap_const_logic_0;
            else
                if ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)) then 
                    ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
                elsif (((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0)))) then 
                    ap_enable_reg_pp0_iter6 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_reg_177_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then 
                i_reg_177 <= tmp_mid2_v_reg_385;
            elsif (((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0)))) then 
                i_reg_177 <= ap_const_lv3_0;
            end if; 
        end if;
    end process;

    indvar_flatten_reg_166_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then 
                indvar_flatten_reg_166 <= indvar_flatten_next_reg_371;
            elsif (((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0)))) then 
                indvar_flatten_reg_166 <= ap_const_lv5_0;
            end if; 
        end if;
    end process;

    j_reg_188_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then 
                j_reg_188 <= j_1_reg_473;
            elsif (((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0)))) then 
                j_reg_188 <= ap_const_lv3_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0))) then
                ap_pipeline_reg_pp0_iter1_exitcond_flatten_reg_367 <= exitcond_flatten_reg_367;
                ap_pipeline_reg_pp0_iter2_exitcond_flatten_reg_367 <= ap_pipeline_reg_pp0_iter1_exitcond_flatten_reg_367;
                ap_pipeline_reg_pp0_iter3_exitcond_flatten_reg_367 <= ap_pipeline_reg_pp0_iter2_exitcond_flatten_reg_367;
                ap_pipeline_reg_pp0_iter4_exitcond_flatten_reg_367 <= ap_pipeline_reg_pp0_iter3_exitcond_flatten_reg_367;
                ap_pipeline_reg_pp0_iter5_exitcond_flatten_reg_367 <= ap_pipeline_reg_pp0_iter4_exitcond_flatten_reg_367;
                ap_pipeline_reg_pp0_iter6_exitcond_flatten_reg_367 <= ap_pipeline_reg_pp0_iter5_exitcond_flatten_reg_367;
                exitcond_flatten_reg_367 <= exitcond_flatten_fu_210_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3))) then
                ap_pipeline_reg_pp0_iter1_tmp_14_reg_458 <= tmp_14_reg_458;
                ap_pipeline_reg_pp0_iter2_tmp_14_reg_458 <= ap_pipeline_reg_pp0_iter1_tmp_14_reg_458;
                ap_pipeline_reg_pp0_iter2_tmp_6_3_reg_503 <= tmp_6_3_reg_503;
                ap_pipeline_reg_pp0_iter3_tmp_14_reg_458 <= ap_pipeline_reg_pp0_iter2_tmp_14_reg_458;
                ap_pipeline_reg_pp0_iter3_tmp_6_3_reg_503 <= ap_pipeline_reg_pp0_iter2_tmp_6_3_reg_503;
                ap_pipeline_reg_pp0_iter4_tmp_14_reg_458 <= ap_pipeline_reg_pp0_iter3_tmp_14_reg_458;
                ap_pipeline_reg_pp0_iter4_tmp_6_3_reg_503 <= ap_pipeline_reg_pp0_iter3_tmp_6_3_reg_503;
                ap_pipeline_reg_pp0_iter5_tmp_14_reg_458 <= ap_pipeline_reg_pp0_iter4_tmp_14_reg_458;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1))) then
                ap_pipeline_reg_pp0_iter2_tmp_6_1_reg_493 <= tmp_6_1_reg_493;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage2))) then
                ap_pipeline_reg_pp0_iter2_tmp_6_2_reg_498 <= tmp_6_2_reg_498;
                ap_pipeline_reg_pp0_iter3_tmp_6_2_reg_498 <= ap_pipeline_reg_pp0_iter2_tmp_6_2_reg_498;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter0))) then
                indvar_flatten_next_reg_371 <= indvar_flatten_next_fu_216_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_enable_reg_pp0_iter0) and (exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage3))) then
                j_1_reg_473 <= j_1_fu_358_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (exitcond_flatten_fu_210_p2 = ap_const_lv1_0))) then
                j_mid2_reg_376 <= j_mid2_fu_234_p3;
                    tmp_reg_390(4 downto 2) <= tmp_fu_250_p3(4 downto 2);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage3))) then
                tmp_14_reg_458 <= tmp_14_fu_352_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage2) and (ap_const_logic_1 = ap_enable_reg_pp0_iter3) and (ap_pipeline_reg_pp0_iter3_exitcond_flatten_reg_367 = ap_const_lv1_0))) then
                tmp_1_1_reg_513 <= grp_fu_199_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3) and (ap_const_logic_1 = ap_enable_reg_pp0_iter4) and (ap_pipeline_reg_pp0_iter4_exitcond_flatten_reg_367 = ap_const_lv1_0))) then
                tmp_1_2_reg_518 <= grp_fu_199_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter6) and (ap_pipeline_reg_pp0_iter5_exitcond_flatten_reg_367 = ap_const_lv1_0))) then
                tmp_1_3_reg_523 <= grp_fu_199_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1) and (ap_pipeline_reg_pp0_iter1_exitcond_flatten_reg_367 = ap_const_lv1_0))) then
                tmp_6_1_reg_493 <= grp_fu_204_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage2) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1) and (ap_pipeline_reg_pp0_iter1_exitcond_flatten_reg_367 = ap_const_lv1_0))) then
                tmp_6_2_reg_498 <= grp_fu_204_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1) and (ap_pipeline_reg_pp0_iter1_exitcond_flatten_reg_367 = ap_const_lv1_0))) then
                tmp_6_3_reg_503 <= grp_fu_204_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then
                tmp_6_reg_478 <= grp_fu_204_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter0) and (exitcond_flatten_fu_210_p2 = ap_const_lv1_0))) then
                tmp_mid2_v_reg_385 <= tmp_mid2_v_fu_242_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1) and (ap_const_logic_1 = ap_enable_reg_pp0_iter2) and (ap_pipeline_reg_pp0_iter2_exitcond_flatten_reg_367 = ap_const_lv1_0))) then
                tmp_s_reg_508 <= grp_fu_199_p2;
            end if;
        end if;
    end process;
    tmp_reg_390(1 downto 0) <= "00";

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, exitcond_flatten_fu_210_p2, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter6, ap_enable_reg_pp0_iter5)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (not((ap_start = ap_const_logic_0))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_pp0_stage0 => 
                if (not(((ap_const_logic_1 = ap_enable_reg_pp0_iter0) and not((exitcond_flatten_fu_210_p2 = ap_const_lv1_0)) and not((ap_const_logic_1 = ap_enable_reg_pp0_iter1))))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state28;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if (not(((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1) and (ap_const_logic_1 = ap_enable_reg_pp0_iter6) and not((ap_const_logic_1 = ap_enable_reg_pp0_iter5))))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state28;
                end if;
            when ap_ST_fsm_pp0_stage2 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage3;
            when ap_ST_fsm_pp0_stage3 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when ap_ST_fsm_state28 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXXX";
        end case;
    end process;
    a_Addr_A <= std_logic_vector(shift_left(unsigned(a_Addr_A_orig),to_integer(unsigned('0' & ap_const_lv32_2(31-1 downto 0)))));

    a_Addr_A_orig_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage2, ap_CS_fsm_pp0_stage3, tmp_3_fu_258_p1, tmp_5_fu_273_p3, tmp_8_fu_301_p3, tmp_10_fu_326_p3)
    begin
        if ((ap_const_logic_1 = ap_enable_reg_pp0_iter0)) then
            if ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)) then 
                a_Addr_A_orig <= tmp_10_fu_326_p3(32 - 1 downto 0);
            elsif ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage2)) then 
                a_Addr_A_orig <= tmp_8_fu_301_p3(32 - 1 downto 0);
            elsif ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1)) then 
                a_Addr_A_orig <= tmp_5_fu_273_p3(32 - 1 downto 0);
            elsif ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0)) then 
                a_Addr_A_orig <= tmp_3_fu_258_p1(32 - 1 downto 0);
            else 
                a_Addr_A_orig <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            a_Addr_A_orig <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;

    a_Clk_A <= ap_clk;
    a_Din_A <= ap_const_lv32_0;

    a_EN_A_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage2, ap_CS_fsm_pp0_stage3)
    begin
        if ((((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter0)) or ((ap_const_logic_1 = ap_enable_reg_pp0_iter0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage1)) or ((ap_const_logic_1 = ap_enable_reg_pp0_iter0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage2)) or ((ap_const_logic_1 = ap_enable_reg_pp0_iter0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)))) then 
            a_EN_A <= ap_const_logic_1;
        else 
            a_EN_A <= ap_const_logic_0;
        end if; 
    end process;

    a_Rst_A <= ap_rst;
    a_WEN_A <= ap_const_lv4_0;
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(1 downto 1);
    ap_CS_fsm_pp0_stage1 <= ap_CS_fsm(2 downto 2);
    ap_CS_fsm_pp0_stage2 <= ap_CS_fsm(3 downto 3);
    ap_CS_fsm_pp0_stage3 <= ap_CS_fsm(4 downto 4);
    ap_CS_fsm_state1 <= ap_CS_fsm(0 downto 0);
    ap_CS_fsm_state28 <= ap_CS_fsm(5 downto 5);

    ap_done_assign_proc : process(ap_CS_fsm_state28)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state28))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_0 = ap_start) and (ap_CS_fsm_state1 = ap_const_lv1_1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state28)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state28))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    b_Addr_A <= std_logic_vector(shift_left(unsigned(b_Addr_A_orig),to_integer(unsigned('0' & ap_const_lv32_2(31-1 downto 0)))));

    b_Addr_A_orig_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage2, ap_CS_fsm_pp0_stage3, tmp_2_fu_263_p1, tmp_11_cast_fu_291_p1, tmp_12_fu_310_p3, tmp_13_cast_fu_347_p1)
    begin
        if ((ap_const_logic_1 = ap_enable_reg_pp0_iter0)) then
            if ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)) then 
                b_Addr_A_orig <= tmp_13_cast_fu_347_p1(32 - 1 downto 0);
            elsif ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage2)) then 
                b_Addr_A_orig <= tmp_12_fu_310_p3(32 - 1 downto 0);
            elsif ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1)) then 
                b_Addr_A_orig <= tmp_11_cast_fu_291_p1(32 - 1 downto 0);
            elsif ((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0)) then 
                b_Addr_A_orig <= tmp_2_fu_263_p1(32 - 1 downto 0);
            else 
                b_Addr_A_orig <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        else 
            b_Addr_A_orig <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;

    b_Clk_A <= ap_clk;
    b_Din_A <= ap_const_lv32_0;

    b_EN_A_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage2, ap_CS_fsm_pp0_stage3)
    begin
        if ((((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter0)) or ((ap_const_logic_1 = ap_enable_reg_pp0_iter0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage1)) or ((ap_const_logic_1 = ap_enable_reg_pp0_iter0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage2)) or ((ap_const_logic_1 = ap_enable_reg_pp0_iter0) and (ap_const_lv1_1 = ap_CS_fsm_pp0_stage3)))) then 
            b_EN_A <= ap_const_logic_1;
        else 
            b_EN_A <= ap_const_logic_0;
        end if; 
    end process;

    b_Rst_A <= ap_rst;
    b_WEN_A <= ap_const_lv4_0;
    c_Addr_A <= std_logic_vector(shift_left(unsigned(c_Addr_A_orig),to_integer(unsigned('0' & ap_const_lv32_2(31-1 downto 0)))));
    c_Addr_A_orig <= tmp_14_cast_fu_363_p1(32 - 1 downto 0);
    c_Clk_A <= ap_clk;
    c_Din_A <= tmp_1_3_reg_523;

    c_EN_A_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter6)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1) and (ap_const_logic_1 = ap_enable_reg_pp0_iter6))) then 
            c_EN_A <= ap_const_logic_1;
        else 
            c_EN_A <= ap_const_logic_0;
        end if; 
    end process;

    c_Rst_A <= ap_rst;

    c_WEN_A_assign_proc : process(ap_pipeline_reg_pp0_iter6_exitcond_flatten_reg_367, ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter6)
    begin
        if ((((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1) and (ap_const_logic_1 = ap_enable_reg_pp0_iter6) and (ap_pipeline_reg_pp0_iter6_exitcond_flatten_reg_367 = ap_const_lv1_0)))) then 
            c_WEN_A <= ap_const_lv4_F;
        else 
            c_WEN_A <= ap_const_lv4_0;
        end if; 
    end process;

    exitcond_flatten_fu_210_p2 <= "1" when (indvar_flatten_phi_fu_170_p4 = ap_const_lv5_10) else "0";
    exitcond_fu_228_p2 <= "1" when (j_phi_fu_192_p4 = ap_const_lv3_4) else "0";

    grp_fu_199_p0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage2, ap_CS_fsm_pp0_stage3, tmp_6_reg_478, ap_enable_reg_pp0_iter1, tmp_s_reg_508, ap_enable_reg_pp0_iter2, tmp_1_1_reg_513, ap_enable_reg_pp0_iter3, tmp_1_2_reg_518, ap_enable_reg_pp0_iter5)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter5))) then 
            grp_fu_199_p0 <= tmp_1_2_reg_518;
        elsif (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3) and (ap_const_logic_1 = ap_enable_reg_pp0_iter3))) then 
            grp_fu_199_p0 <= tmp_1_1_reg_513;
        elsif (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage2) and (ap_const_logic_1 = ap_enable_reg_pp0_iter2))) then 
            grp_fu_199_p0 <= tmp_s_reg_508;
        elsif (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then 
            grp_fu_199_p0 <= tmp_6_reg_478;
        else 
            grp_fu_199_p0 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    grp_fu_199_p1_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage2, ap_CS_fsm_pp0_stage3, ap_enable_reg_pp0_iter1, ap_pipeline_reg_pp0_iter2_tmp_6_1_reg_493, ap_pipeline_reg_pp0_iter3_tmp_6_2_reg_498, ap_pipeline_reg_pp0_iter4_tmp_6_3_reg_503, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter5)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter5))) then 
            grp_fu_199_p1 <= ap_pipeline_reg_pp0_iter4_tmp_6_3_reg_503;
        elsif (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage3) and (ap_const_logic_1 = ap_enable_reg_pp0_iter3))) then 
            grp_fu_199_p1 <= ap_pipeline_reg_pp0_iter3_tmp_6_2_reg_498;
        elsif (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage2) and (ap_const_logic_1 = ap_enable_reg_pp0_iter2))) then 
            grp_fu_199_p1 <= ap_pipeline_reg_pp0_iter2_tmp_6_1_reg_493;
        elsif (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage1) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then 
            grp_fu_199_p1 <= ap_const_lv32_0;
        else 
            grp_fu_199_p1 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;

    i_1_fu_222_p2 <= std_logic_vector(unsigned(i_phi_fu_181_p4) + unsigned(ap_const_lv3_1));

    i_phi_fu_181_p4_assign_proc : process(i_reg_177, exitcond_flatten_reg_367, ap_CS_fsm_pp0_stage0, tmp_mid2_v_reg_385, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then 
            i_phi_fu_181_p4 <= tmp_mid2_v_reg_385;
        else 
            i_phi_fu_181_p4 <= i_reg_177;
        end if; 
    end process;

    indvar_flatten_next_fu_216_p2 <= std_logic_vector(unsigned(indvar_flatten_phi_fu_170_p4) + unsigned(ap_const_lv5_1));

    indvar_flatten_phi_fu_170_p4_assign_proc : process(indvar_flatten_reg_166, exitcond_flatten_reg_367, ap_CS_fsm_pp0_stage0, indvar_flatten_next_reg_371, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then 
            indvar_flatten_phi_fu_170_p4 <= indvar_flatten_next_reg_371;
        else 
            indvar_flatten_phi_fu_170_p4 <= indvar_flatten_reg_166;
        end if; 
    end process;

    j_1_fu_358_p2 <= std_logic_vector(unsigned(j_mid2_reg_376) + unsigned(ap_const_lv3_1));
    j_mid2_fu_234_p3 <= 
        ap_const_lv3_0 when (exitcond_fu_228_p2(0) = '1') else 
        j_phi_fu_192_p4;

    j_phi_fu_192_p4_assign_proc : process(j_reg_188, exitcond_flatten_reg_367, ap_CS_fsm_pp0_stage0, j_1_reg_473, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_pp0_stage0) and (exitcond_flatten_reg_367 = ap_const_lv1_0) and (ap_const_logic_1 = ap_enable_reg_pp0_iter1))) then 
            j_phi_fu_192_p4 <= j_1_reg_473;
        else 
            j_phi_fu_192_p4 <= j_reg_188;
        end if; 
    end process;

    tmp_10_fu_326_p3 <= (ap_const_lv59_0 & tmp_9_fu_321_p2);
    tmp_11_cast_fu_291_p1 <= std_logic_vector(resize(unsigned(tmp_11_fu_285_p2),64));
    tmp_11_fu_285_p2 <= std_logic_vector(unsigned(tmp_2_cast_fu_282_p1) + unsigned(ap_const_lv4_4));
    tmp_12_fu_310_p3 <= (ap_const_lv61_1 & j_mid2_reg_376);
    tmp_13_cast_fu_347_p1 <= std_logic_vector(resize(unsigned(tmp_13_fu_341_p2),64));
    tmp_13_fu_341_p2 <= std_logic_vector(unsigned(tmp_2_cast3_fu_338_p1) + unsigned(ap_const_lv5_C));
    tmp_14_cast_fu_363_p1 <= std_logic_vector(resize(unsigned(ap_pipeline_reg_pp0_iter5_tmp_14_reg_458),64));
    tmp_14_fu_352_p2 <= std_logic_vector(unsigned(tmp_2_cast4_fu_335_p1) + unsigned(tmp_3_cast_fu_318_p1));
    tmp_2_cast3_fu_338_p1 <= std_logic_vector(resize(unsigned(j_mid2_reg_376),5));
    tmp_2_cast4_fu_335_p1 <= std_logic_vector(resize(unsigned(j_mid2_reg_376),6));
    tmp_2_cast_fu_282_p1 <= std_logic_vector(resize(unsigned(j_mid2_reg_376),4));
    tmp_2_fu_263_p1 <= std_logic_vector(resize(unsigned(j_mid2_fu_234_p3),64));
    tmp_3_cast_fu_318_p1 <= std_logic_vector(resize(unsigned(tmp_reg_390),6));
    tmp_3_fu_258_p1 <= std_logic_vector(resize(unsigned(tmp_fu_250_p3),64));
    tmp_4_fu_268_p2 <= (tmp_reg_390 or ap_const_lv5_1);
    tmp_5_fu_273_p3 <= (ap_const_lv59_0 & tmp_4_fu_268_p2);
    tmp_7_fu_296_p2 <= (tmp_reg_390 or ap_const_lv5_2);
    tmp_8_fu_301_p3 <= (ap_const_lv59_0 & tmp_7_fu_296_p2);
    tmp_9_fu_321_p2 <= (tmp_reg_390 or ap_const_lv5_3);
    tmp_fu_250_p3 <= (tmp_mid2_v_fu_242_p3 & ap_const_lv2_0);
    tmp_mid2_v_fu_242_p3 <= 
        i_1_fu_222_p2 when (exitcond_fu_228_p2(0) = '1') else 
        i_phi_fu_181_p4;
end behav;