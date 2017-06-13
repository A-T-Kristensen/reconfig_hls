
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
use work.HWA_PACKAGE_FILTERBANK.all;

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
	
	component filterbank_core_hwa is
		port (
			ap_clk 		: in std_logic;
			ap_rst 		: in std_logic;
			ap_start 	: in std_logic;
			ap_done 	: out std_logic;
			ap_idle 	: out std_logic;
			ap_ready 	: out std_logic;
		    r_Addr_A 	: out std_logic_vector (31 downto 0);
		    r_EN_A 		: out std_logic;
		    r_WEN_A 	: out std_logic_vector (3 downto 0);
		    r_Din_A 	: out std_logic_vector (31 downto 0);
		    r_Dout_A 	: in std_logic_vector (31 downto 0);
		    r_Clk_A 	: out std_logic;
		    r_Rst_A 	: out std_logic;
		    y_Addr_A 	: out std_logic_vector (31 downto 0);
		    y_EN_A 		: out std_logic;
		    y_WEN_A 	: out std_logic_vector (3 downto 0);
		    y_Din_A 	: out std_logic_vector (31 downto 0);
		    y_Dout_A 	: in std_logic_vector (31 downto 0);
		    y_Clk_A 	: out std_logic;
		    y_Rst_A 	: out std_logic;
		    H_Addr_A 	: out std_logic_vector (31 downto 0);
		    H_EN_A 		: out std_logic;
		    H_WEN_A 	: out std_logic_vector (3 downto 0);
		    H_Din_A 	: out std_logic_vector (31 downto 0);
		    H_Dout_A 	: in std_logic_vector (31 downto 0);
		    H_Clk_A 	: out std_logic;
		    H_Rst_A 	: out std_logic;
		    F_Addr_A 	: out std_logic_vector (31 downto 0);
		    F_EN_A 		: out std_logic;
		    F_WEN_A 	: out std_logic_vector (3 downto 0);
		    F_Din_A 	: out std_logic_vector (31 downto 0);
		    F_Dout_A 	: in std_logic_vector (31 downto 0);
		    F_Clk_A 	: out std_logic;
		    F_Rst_A 	: out std_logic 
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
		
	filterbank_inst_0 : filterbank_core_hwa port map(
		ap_clk 		=> clk,
		ap_rst 		=> hwa_rst,
		ap_start 	=> ap_start_in,
		ap_done 	=> ap_done_out,
		ap_idle 	=> ap_idle_out,
		ap_ready 	=> ap_ready_out,

		r_Addr_A 	=> hwa_addr_i(0).addr,
		r_EN_A  	=> open,
		r_WEN_A	    => bram_m_i(0).wr,
		r_Din_A  	=> bram_m_i(0).din,
		r_Dout_A 	=> bram_s_i(0).dout,
		r_Clk_A 	=> open,
		r_Rst_A 	=> open,

		y_Addr_A 	=> hwa_addr_i(1).addr,
		y_EN_A  	=> open,
		y_WEN_A 	=> bram_m_i(1).wr,
		y_Din_A  	=> bram_m_i(1).din,
		y_Dout_A 	=> bram_s_i(1).dout,
		y_Clk_A 	=> open,
		y_Rst_A 	=> open,

		H_Addr_A 	=> hwa_addr_i(2).addr,
		H_EN_A  	=> open,
		H_WEN_A 	=> bram_m_i(2).wr,
		H_Din_A  	=> bram_m_i(2).din,
		H_Dout_A 	=> bram_s_i(2).dout,
		H_Clk_A 	=> open,
		H_Rst_A 	=> open,		

		F_Addr_A 	=> hwa_addr_i(3).addr,
		F_EN_A  	=> open,
		F_WEN_A 	=> bram_m_i(3).wr,
		F_Din_A  	=> bram_m_i(3).din,
		F_Dout_A 	=> bram_s_i(3).dout,
		F_Clk_A 	=> open,
		F_Rst_A 	=> open	
	);			

	hwa_rst <= ap_reset_in or rst;		

	addr_map: for i in (NBANKS-1) downto 0 generate
	    	bram_m_i(i).addr <= hwa_addr_i(i).addr(ADDR_WIDTH - 1 downto 0);
    end generate;	


end rtl;

