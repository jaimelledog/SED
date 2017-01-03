----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:25:21 12/29/2016 
-- Design Name: 
-- Module Name:    conversor_numeracion - Dataflow 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conversor_numeracion is
    Port ( data_in : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           data_out : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end conversor_numeracion;

architecture Dataflow of conversor_numeracion is

begin
with data_in select
	data_out <= "0000" when "1001",
					"0011" when "1000",
					"0011" when "0111",
					"0110" when "0110",
					"0110" when "0101",
					"1001" when "0100",
					"1001" when "0011",
					"1100" when "0010",
					"1100" when "0001",
					"1111" when "0000",
					"0001" when others;
end architecture Dataflow;

