---------------------------------------------------------------------------------------------------
--
-- Title       : Testbench for Two End Point Example for Ring Bus
-- Design      : Ring Bus
-- Author      : a4a881d4
-- Company     : RP7
--
---------------------------------------------------------------------------------------------------
--
-- File        : rbus2_tb.vhd
-- Generated   : 2013/9/10
-- From        : 
-- By          : 
--
---------------------------------------------------------------------------------------------------
--
-- Description : Testbench for Two End Point Example for Ring Bus
--               two end point
-- 
-- Rev: 1.0
--
---------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity RBUS2_TB is
end RBUS2_TB;

library	simio;
use simio.SIMIO_PACKAGE.all;

architecture sim of RBUS2_TB is

component RBUS2
	port(
		-- system
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		
		-- CPU bus
		wr : in std_logic;
		rd : in std_logic;
		addr : in std_logic_vector( 7 downto 0 );
		Din : in std_logic_vector( 7 downto 0 );
		Dout : out std_logic_vector( 7 downto 0 );
		cpuClk : in std_logic;
		
		-- out 
		viewAout : out std_logic_vector( 9 downto 0 ); 
		viewDout : out std_logic_vector( 127 downto 0 );
		viewenout : out std_logic 
	);
end component;

signal clk : STD_LOGIC :='0';
signal rst : STD_LOGIC :='0';

signal dspce,dspwr,wr : std_logic :='0';
signal rd : std_logic :='0';
signal addr : std_logic_vector( 7 downto 0 );
signal Din : std_logic_vector( 7 downto 0 );
signal Dout : std_logic_vector( 7 downto 0 );
signal cpuClk : std_logic :='0';
signal viewAout : std_logic_vector( 9 downto 0 ); 
signal viewDout : std_logic_vector( 127 downto 0 );
signal viewenout : std_logic :='0'; 

begin

cpu:dspemulator
	generic map( 
		DSP_INC_FILE => "V3.0/testbench/rbus2.inx",
		ABUS_WIDTH => 8,
		DBUS_WIDTH => 8 )
	port map(
		clk	=> clk,
		dspce => dspce,
        dspa => addr,
		data => din,
        wr => dspwr,
		IOstb => cpuClk
	);
	
ttu:RBUS2
	port map(
		-- system
		clk =>clk,
		rst => rst,
		
		wr => wr,
		rd => '0',
		addr => addr,
		Din => Din,
		
		cpuClk => cpuClk,
		
		-- out 
		viewAout => viewAout, 
		viewDout => viewDout,
		viewenout => viewenout 
	);	
	wr<=not ( dspwr );

	rst <= '1', '0' after 10 ns;
	clk <= not clk after 1 ns;
end sim;
	


