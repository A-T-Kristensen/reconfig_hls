-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2016.4
-- Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity scalel is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    nbl : IN STD_LOGIC_VECTOR (14 downto 0);
    shift_constant : IN STD_LOGIC_VECTOR (4 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (14 downto 0) );
end;


architecture behav of scalel is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (1 downto 0) := "10";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_6 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000110";
    constant ap_const_lv32_A : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001010";
    constant ap_const_lv32_B : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001011";
    constant ap_const_lv32_E : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001110";
    constant ap_const_lv4_1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv15_0 : STD_LOGIC_VECTOR (14 downto 0) := "000000000000000";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (1 downto 0) := "01";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ilb_table_address0 : STD_LOGIC_VECTOR (4 downto 0);
    signal ilb_table_ce0 : STD_LOGIC;
    signal ilb_table_q0 : STD_LOGIC_VECTOR (11 downto 0);
    signal tmp_reg_124 : STD_LOGIC_VECTOR (3 downto 0);
    signal tmp_s_fu_74_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC_VECTOR (0 downto 0);
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal wd1_fu_54_p4 : STD_LOGIC_VECTOR (4 downto 0);
    signal tmp_11_fu_86_p1 : STD_LOGIC_VECTOR (3 downto 0);
    signal tmp_27_fu_90_p2 : STD_LOGIC_VECTOR (3 downto 0);
    signal tmp_37_cast_fu_96_p1 : STD_LOGIC_VECTOR (21 downto 0);
    signal wd2_cast_fu_79_p1 : STD_LOGIC_VECTOR (21 downto 0);
    signal ilb_table_load_cast_fu_82_p1 : STD_LOGIC_VECTOR (21 downto 0);
    signal tmp_28_fu_100_p2 : STD_LOGIC_VECTOR (21 downto 0);
    signal wd3_fu_106_p2 : STD_LOGIC_VECTOR (21 downto 0);
    signal tmp_12_fu_112_p1 : STD_LOGIC_VECTOR (11 downto 0);
    signal tmp_29_fu_116_p3 : STD_LOGIC_VECTOR (14 downto 0);
    signal ap_return_preg : STD_LOGIC_VECTOR (14 downto 0) := "000000000000000";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (1 downto 0);

    component scalel_ilb_table IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (4 downto 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR (11 downto 0) );
    end component;



begin
    ilb_table_U : component scalel_ilb_table
    generic map (
        DataWidth => 12,
        AddressRange => 32,
        AddressWidth => 5)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => ilb_table_address0,
        ce0 => ilb_table_ce0,
        q0 => ilb_table_q0);





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


    ap_return_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_preg(3) <= '0';
                ap_return_preg(4) <= '0';
                ap_return_preg(5) <= '0';
                ap_return_preg(6) <= '0';
                ap_return_preg(7) <= '0';
                ap_return_preg(8) <= '0';
                ap_return_preg(9) <= '0';
                ap_return_preg(10) <= '0';
                ap_return_preg(11) <= '0';
                ap_return_preg(12) <= '0';
                ap_return_preg(13) <= '0';
                ap_return_preg(14) <= '0';
            else
                if (((ap_const_lv1_1 = ap_CS_fsm_state2))) then 
                                        ap_return_preg(14 downto 3) <= tmp_29_fu_116_p3(14 downto 3);
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0)))) then
                tmp_reg_124 <= nbl(14 downto 11);
            end if;
        end if;
    end process;
    ap_return_preg(2 downto 0) <= "000";

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (not((ap_start = ap_const_logic_0))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0 downto 0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1 downto 1);

    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state2)
    begin
        if ((((ap_const_logic_0 = ap_start) and (ap_CS_fsm_state1 = ap_const_lv1_1)) or ((ap_const_lv1_1 = ap_CS_fsm_state2)))) then 
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


    ap_ready_assign_proc : process(ap_CS_fsm_state2)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state2))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_return_assign_proc : process(ap_CS_fsm_state2, tmp_29_fu_116_p3, ap_return_preg)
    begin
        if (((ap_const_lv1_1 = ap_CS_fsm_state2))) then 
            ap_return <= tmp_29_fu_116_p3;
        else 
            ap_return <= ap_return_preg;
        end if; 
    end process;

    ilb_table_address0 <= tmp_s_fu_74_p1(5 - 1 downto 0);

    ilb_table_ce0_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_CS_fsm_state1 = ap_const_lv1_1) and not((ap_start = ap_const_logic_0)))) then 
            ilb_table_ce0 <= ap_const_logic_1;
        else 
            ilb_table_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    ilb_table_load_cast_fu_82_p1 <= std_logic_vector(resize(unsigned(ilb_table_q0),22));
    tmp_11_fu_86_p1 <= shift_constant(4 - 1 downto 0);
    tmp_12_fu_112_p1 <= wd3_fu_106_p2(12 - 1 downto 0);
    tmp_27_fu_90_p2 <= std_logic_vector(unsigned(ap_const_lv4_1) + unsigned(tmp_11_fu_86_p1));
    tmp_28_fu_100_p2 <= std_logic_vector(unsigned(tmp_37_cast_fu_96_p1) - unsigned(wd2_cast_fu_79_p1));
    tmp_29_fu_116_p3 <= (tmp_12_fu_112_p1 & ap_const_lv3_0);
    tmp_37_cast_fu_96_p1 <= std_logic_vector(resize(unsigned(tmp_27_fu_90_p2),22));
    tmp_s_fu_74_p1 <= std_logic_vector(resize(unsigned(wd1_fu_54_p4),64));
    wd1_fu_54_p4 <= nbl(10 downto 6);
    wd2_cast_fu_79_p1 <= std_logic_vector(resize(unsigned(tmp_reg_124),22));
    wd3_fu_106_p2 <= std_logic_vector(shift_right(unsigned(ilb_table_load_cast_fu_82_p1),to_integer(unsigned('0' & tmp_28_fu_100_p2(22-1 downto 0)))));
end behav;