
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
use work.HWA_PACKAGE_MINVER.all;


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
	
	component minver_hwa is
		port (
			ap_clk 		: in std_logic;
			ap_rst 		: in std_logic;
			ap_start 	: in std_logic;
			ap_done 	: out std_logic;
			ap_idle 	: out std_logic;
			ap_ready 	: out std_logic;
            a_0_Addr_A : out STD_LOGIC_VECTOR (31 downto 0);
            a_0_EN_A : out STD_LOGIC;
            a_0_WEN_A : out STD_LOGIC_VECTOR (3 downto 0);
            a_0_Din_A : out STD_LOGIC_VECTOR (31 downto 0);
            a_0_Dout_A : in STD_LOGIC_VECTOR (31 downto 0);
            a_0_Clk_A : out STD_LOGIC;
            a_0_Rst_A : out STD_LOGIC;
            a_1_Addr_A : out STD_LOGIC_VECTOR (31 downto 0);
            a_1_EN_A : out STD_LOGIC;
            a_1_WEN_A : out STD_LOGIC_VECTOR (3 downto 0);
            a_1_Din_A : out STD_LOGIC_VECTOR (31 downto 0);
            a_1_Dout_A : in STD_LOGIC_VECTOR (31 downto 0);
            a_1_Clk_A : out STD_LOGIC;
            a_1_Rst_A : out STD_LOGIC;
            a_2_Addr_A : out STD_LOGIC_VECTOR (31 downto 0);
            a_2_EN_A : out STD_LOGIC;
            a_2_WEN_A : out STD_LOGIC_VECTOR (3 downto 0);
            a_2_Din_A : out STD_LOGIC_VECTOR (31 downto 0);
            a_2_Dout_A : in STD_LOGIC_VECTOR (31 downto 0);
            a_2_Clk_A : out STD_LOGIC;
            a_2_Rst_A : out STD_LOGIC;
            a_3_Addr_A : out STD_LOGIC_VECTOR (31 downto 0);
            a_3_EN_A : out STD_LOGIC;
            a_3_WEN_A : out STD_LOGIC_VECTOR (3 downto 0);
            a_3_Din_A : out STD_LOGIC_VECTOR (31 downto 0);
            a_3_Dout_A : in STD_LOGIC_VECTOR (31 downto 0);
            a_3_Clk_A : out STD_LOGIC;
            a_3_Rst_A : out STD_LOGIC            
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
		
	minver_hwa_inst_0 : minver_hwa port map(
		ap_clk 		=> clk,
		ap_rst 		=> hwa_rst,
		ap_start 	=> ap_start_in,
		ap_done 	=> ap_done_out,
		ap_idle 	=> ap_idle_out,
		ap_ready 	=> ap_ready_out,
		
		a_0_Addr_A 	=> hwa_addr_i(0).addr,
		a_0_EN_A  	=> open,
		a_0_WEN_A		=> bram_m_i(0).wr,
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
		a_2_EN_A  	=> open,
		a_2_WEN_A		=> bram_m_i(2).wr,
		a_2_Din_A  	=> bram_m_i(2).din,
		a_2_Dout_A 	=> bram_s_i(2).dout,
		a_2_Clk_A 	=> open,
		a_2_Rst_A 	=> open,
		
		a_3_Addr_A 	=> hwa_addr_i(3).addr,
        a_3_EN_A      => open,
        a_3_WEN_A        => bram_m_i(3).wr,
        a_3_Din_A      => bram_m_i(3).din,
        a_3_Dout_A     => bram_s_i(3).dout,
        a_3_Clk_A     => open,
        a_3_Rst_A     => open	
	);	
	hwa_rst <= ap_reset_in or rst;		

	addr_map: for i in (NBANKS-1) downto 0 generate
	    	bram_m_i(i).addr <= hwa_addr_i(i).addr(ADDR_WIDTH - 1 downto 0);
    end generate;	



end rtl;

