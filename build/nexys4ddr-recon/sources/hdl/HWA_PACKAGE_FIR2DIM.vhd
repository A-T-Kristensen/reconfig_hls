--------------------------------------------------------------------------------
-- Package for the hardware accelerators
-- this package specifies the information required for the memory banks
-- used in the currently active design (synthesis or simulation)
--
-- Author: Andreas Toftegaard Kristensen (s144026@student.dtu.dk)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";

package HWA_PACKAGE_FIR2DIM is

    -- Constants used for the memory (BRAM) between Patmos and the HwA

    -- Number of banks used by the currently active design.
    constant NBANKS  : integer := 2; 

    -- The number of entries for each the memory banks 
    constant MEM_SIZE : integer := 4096;

	-- Constants used for the memory (BRAM) between Patmos and the HwA

    -- 32-bit
    constant DATA_WIDTH : integer := 32; 
    constant WEN_LENGTH : integer := 4;
    
    -- 64-bit (minver, we need a rewrite of the local files, and we 
    -- need to add data_width only for HwA side, since Patmos is always 32-bit.
    --constant DATA_WIDTH : integer := 64; 
    --constant WEN_LENGTH : integer := 8;    
	-- Patmos has a 16-bit local address space    
    constant ADDR_WIDTH    : integer := 16; 

    -- Number of bits used to select between banks from Patmos
    constant ADDR_SELECT_BITS : integer := integer(ceil(log2(real(NBANKS)))); 

    -- Number of bits used to select between banks from Patmos
    constant ADDR_SIZE_BRAM : integer := integer(ceil(log2(real(MEM_SIZE)))) - 2;     

	-- The actual number of address bits used by each of the BRAMs
    constant ADDR_BITS: integer := integer(ceil(log2(real(MEM_SIZE)))); 

    -- Record definitions
    type bank_master is record
        wr   : std_logic_vector(WEN_LENGTH - 1 downto 0);
        addr : std_logic_vector(ADDR_BITS - 1 downto 0);
        din  : std_logic_vector(DATA_WIDTH - 1 downto 0);
    end record;    

    type bank_slave is record
        dout : std_logic_vector(DATA_WIDTH - 1 downto 0);
    end record;       

    -- Used for the hardware accelerators, since they use a 32-bit address space
    type hwa_addr is record
        addr : std_logic_vector(31 downto 0);
    end record;

    type bank_master_a	is array(NBANKS-1 downto 0) of bank_master;
    type bank_slave_a 	is array(NBANKS-1 downto 0) of bank_slave;    
    type hwa_addr_a		is array(NBANKS-1 downto 0) of hwa_addr;    


end HWA_PACKAGE_FIR2DIM;