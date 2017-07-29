
--------------------------------------------------------------------------------
-- A parameterized, memory bank using true dual-port, dual-clock block RAMs
-- to implement n memory banks.
-- The ceil(log[2](N)) addr bits are used to select banks.
--
-- Author: Andreas Toftegaard Kristensen
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.HWA_PACKAGE_MATMUL.all;

entity recon_matrix is
	port (
	    clk     : in  std_logic;
	    rst 	: in std_logic;

	    -- Patmos side
	    p_we    : in  std_logic;
	    p_addr  : in  std_logic_vector(ADDR_WIDTH - 1 downto 0);
	    p_dout  : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
	    p_din   : out std_logic_vector(DATA_WIDTH - 1 downto 0);

		ap_start_in : in std_logic;
		ap_reset_in : in std_logic;
		ap_ready_out 	: out std_logic;
		ap_idle_out 	: out std_logic;
		ap_done_out 	: out std_logic		    
     
	);
end recon_matrix;

architecture rtl of recon_matrix is
	
	component n_bank is
		port (
		    clk     : in  std_logic;

		    -- Patmos side
		    p_we    : in  std_logic;
		    p_addr  : in  std_logic_vector(ADDR_WIDTH - 1 downto 0); 
		    p_dout  : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
		    p_din   : out std_logic_vector(DATA_WIDTH - 1 downto 0);  

		    -- HwA side
	        bram_m : in bank_master_a;
	        bram_s : out bank_slave_a       
		);
	end component;  
	
	component matmul_hw is
		port (
			ap_rst 		=> hwa_rst,
			ap_start 	=> ap_start_in,
			ap_done 	=> ap_done_out,
			ap_idle 	=> ap_idle_out,
			ap_ready 	=> ap_ready_out,
			
		    a_0_Addr_A 	: out std_logic_vector (31 downto 0);
		    a_0_EN_A 		: out std_logic;
		    a_0_WEN_A 	: out std_logic_vector (3 downto 0);
		    a_0_Din_A 	: out std_logic_vector (31 downto 0);
		    a_0_Dout_A 	: in std_logic_vector (31 downto 0);
		    a_0_Clk_A 	: out std_logic;
		    a_0_Rst_A 	: out std_logic;
		    
		    a_1_Addr_A 	: out std_logic_vector (31 downto 0);
            a_1_EN_A         : out std_logic;
            a_1_WEN_A     : out std_logic_vector (3 downto 0);
            a_1_Din_A     : out std_logic_vector (31 downto 0);
            a_1_Dout_A     : in std_logic_vector (31 downto 0);
            a_1_Clk_A     : out std_logic;
            a_1_Rst_A     : out std_logic;		    

		    a_2_Addr_A 	: out std_logic_vector (31 downto 0);
            a_2_EN_A         : out std_logic;
            a_2_WEN_A     : out std_logic_vector (3 downto 0);
            a_2_Din_A     : out std_logic_vector (31 downto 0);
            a_2_Dout_A     : in std_logic_vector (31 downto 0);
            a_2_Clk_A     : out std_logic;
            a_2_Rst_A     : out std_logic;		

		    a_3_Addr_A 	: out std_logic_vector (31 downto 0);
            a_3_EN_A         : out std_logic;
            a_3_WEN_A     : out std_logic_vector (3 downto 0);
            a_3_Din_A     : out std_logic_vector (31 downto 0);
            a_3_Dout_A     : in std_logic_vector (31 downto 0);
            a_3_Clk_A     : out std_logic;
            a_3_Rst_A     : out std_logic;		             
		    
		    b_0_Addr_A 	: out std_logic_vector (31 downto 0);
		    b_0_EN_A 		: out std_logic;
		    b_0_WEN_A 	: out std_logic_vector (3 downto 0);
		    b_0_Din_A 	: out std_logic_vector (31 downto 0);
		    b_0_Dout_A 	: in std_logic_vector (31 downto 0);
		    b_0_Clk_A 	: out std_logic;
		    b_0_Rst_A 	: out std_logic;
		    
		    b_1_Addr_A 	: out std_logic_vector (31 downto 0);
            b_1_EN_A         : out std_logic;
            b_1_WEN_A     : out std_logic_vector (3 downto 0);
            b_1_Din_A     : out std_logic_vector (31 downto 0);
            b_1_Dout_A     : in std_logic_vector (31 downto 0);
            b_1_Clk_A     : out std_logic;
            b_1_Rst_A     : out std_logic;		    

		    b_2_Addr_A 	: out std_logic_vector (31 downto 0);
            b_2_EN_A         : out std_logic;
            b_2_WEN_A     : out std_logic_vector (3 downto 0);
            b_2_Din_A     : out std_logic_vector (31 downto 0);
            b_2_Dout_A     : in std_logic_vector (31 downto 0);
            b_2_Clk_A     : out std_logic;
            b_2_Rst_A     : out std_logic;	         

		    b_3_Addr_A 	: out std_logic_vector (31 downto 0);
            b_3_EN_A         : out std_logic;
            b_3_WEN_A     : out std_logic_vector (3 downto 0);
            b_3_Din_A     : out std_logic_vector (31 downto 0);
            b_3_Dout_A     : in std_logic_vector (31 downto 0);
            b_3_Clk_A     : out std_logic;
            b_3_Rst_A     : out std_logic;	               
		    
		    c_Addr_A 	: out std_logic_vector (31 downto 0);
			c_EN_A 		: out std_logic;
		    c_WEN_A 	: out std_logic_vector (3 downto 0);
		    c_Din_A 	: out std_logic_vector (31 downto 0);
		    c_Dout_A 	: in std_logic_vector (31 downto 0);
		    c_Clk_A 	: out std_logic;
		    c_Rst_A 	: out std_logic
		    );
	end component; 	

    signal bram_m_i 	: bank_master_a;
    signal bram_s_i		: bank_slave_a;	
    signal hwa_addr_i 	: hwa_addr_a;	
    
	signal hwa_rst : std_logic;   

	--signal p_we_i  : std_logic;
	--signal p_addr_i  : std_logic_vector(ADDR_WIDTH - 1 downto 0);
	--signal p_dout_i  : std_logic_vector(DATA_WIDTH - 1 downto 0);
	--signal p_din_i  : std_logic_vector(DATA_WIDTH - 1 downto 0);


	--------------------------------------
	-- 	ATTRIBUTE FIELDS FOR SIGNALS 	--
	--------------------------------------

	-- SIGNALS THAT SHOULD NOT BE TOUCHED

	attribute dont_touch : string;  

	attribute dont_touch of hwa_addr_i 	: signal is "true";		

begin


	n_bank_inst_0 : n_bank port map(
	    clk     => clk,

	    -- Patmos side
	    p_we    => p_we,
	    p_addr  => p_addr, 
	    p_dout  => p_dout,
	    p_din   => p_din,

	    -- HwA Side
        bram_m 	=> bram_m_i,
        bram_s  => bram_s_i
	);
		
	matrixmul_inst_0 : matmul_hw port map(
		ap_clk 		=> clk,
		ap_rst 		=> hwa_rst,
		ap_start 	=> hwACtrl_ap_start_out,
		ap_done 	=> hwACtrl_ap_done_in,
		ap_idle 	=> hwACtrl_ap_idle_in,
		ap_ready 	=> hwACtrl_ap_ready_in,

		a_0_Addr_A 	=> hwa_addr_i(0).addr,
		a_0_EN_A  	=> open,
		a_0_WEN_A	    => bram_m_i(0).wr,
		a_0_Din_A  	=> bram_m_i(0).din,
		a_0_Dout_A 	=> bram_s_i(0).dout,
		a_0_Clk_A 	=> open,
		a_0_Rst_A 	=> open,
		
		a_1_Addr_A 	=> hwa_addr_i(1).addr,
        a_1_EN_A      => open,
        a_1_WEN_A        => bram_m_i(1).wr,
        a_1_Din_A      => bram_m_i(1).din,
        a_1_Dout_A     => bram_s_i(1).dout,
        a_1_Clk_A     => open,
        a_1_Rst_A     => open,	

		a_2_Addr_A 	=> hwa_addr_i(2).addr,
        a_2_EN_A      => open,
        a_2_WEN_A        => bram_m_i(2).wr,
        a_2_Din_A      => bram_m_i(2).din,
        a_2_Dout_A     => bram_s_i(2).dout,
        a_2_Clk_A     => open,
        a_2_Rst_A     => open,		

		a_3_Addr_A 	=> hwa_addr_i(3).addr,
        a_3_EN_A      => open,
        a_3_WEN_A        => bram_m_i(3).wr,
        a_3_Din_A      => bram_m_i(3).din,
        a_3_Dout_A     => bram_s_i(3).dout,
        a_3_Clk_A     => open,
        a_3_Rst_A     => open,		                	

		b_0_Addr_A 	=> hwa_addr_i(4).addr,
		b_0_EN_A  	=> open,
		b_0_WEN_A 	=> bram_m_i(4).wr,
		b_0_Din_A  	=> bram_m_i(4).din,
		b_0_Dout_A 	=> bram_s_i(4).dout,
		b_0_Clk_A 	=> open,
		b_0_Rst_A 	=> open,
		
		b_1_Addr_A 	=> hwa_addr_i(5).addr,
        b_1_EN_A      => open,
        b_1_WEN_A     => bram_m_i(5).wr,
        b_1_Din_A      => bram_m_i(5).din,
        b_1_Dout_A     => bram_s_i(5).dout,
        b_1_Clk_A     => open,
        b_1_Rst_A     => open,	

		b_2_Addr_A 	=> hwa_addr_i(6).addr,
		b_2_EN_A  	=> open,
		b_2_WEN_A 	=> bram_m_i(6).wr,
		b_2_Din_A  	=> bram_m_i(6).din,
		b_2_Dout_A 	=> bram_s_i(6).dout,
		b_2_Clk_A 	=> open,
		b_2_Rst_A 	=> open,
		
		b_3_Addr_A 	=> hwa_addr_i(7).addr,
        b_3_EN_A      => open,
        b_3_WEN_A     => bram_m_i(7).wr,
        b_3_Din_A      => bram_m_i(7).din,
        b_3_Dout_A     => bram_s_i(7).dout,
        b_3_Clk_A     => open,
        b_3_Rst_A     => open,	        	

		c_Addr_A 	=> hwa_addr_i(8).addr,
		c_EN_A  	=> open,
		c_WEN_A 	=> bram_m_i(8).wr,
		c_Din_A  	=> bram_m_i(8).din,
		c_Dout_A 	=> bram_s_i(8).dout,
		c_Clk_A 	=> open,
		c_Rst_A 	=> open		
	);		

	hwa_rst <= ap_reset_in or rst;		

	addr_map: for i in (NBANKS-1) downto 0 generate
	    	bram_m_i(i).addr <= hwa_addr_i(i).addr(ADDR_WIDTH - 1 downto 0);
    end generate;	


end rtl;

