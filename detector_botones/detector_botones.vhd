----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:00:24 12/28/2016 
-- Design Name: 
-- Module Name:    detector_botones - Behavioral 
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

entity detector_botones is
    Port ( clk : in  STD_LOGIC;
           secuencia_bot : out  STD_LOGIC_VECTOR(3 DOWNTO 0);--secuencia de todos los pisos para comprobar qué botón se ha pulsado
           detector_llamada : in  STD_LOGIC;--devuelve 0 si secuencia_bot coincide con el botón pulsado
           piso_llamado : out  STD_LOGIC_VECTOR(3 DOWNTO 0);--salida con el número de piso llamado
			  man_fin : in STD_LOGIC);
end detector_botones;

architecture Behavioral of detector_botones is

COMPONENT counter4bits
PORT(
	clk : in STD_LOGIC;
	add : in STD_LOGIC;
	data : in STD_LOGIC_VECTOR (3 DOWNTO 0);
	cuenta : out STD_LOGIC_VECTOR (3 DOWNTO 0)
);
END COMPONENT;

begin
	inst_counter4bits: counter4bits port map(
		clk=>clk,
		add=>'1',
		data=>"0000",--empieza en 0
		cuenta=>secuencia_bot(3 DOWNTO 0)
	);
	process begin
		if man_fin='0' then
		
		elsif detector_llamada='0' then
			piso_llamado<=secuencia_bot;
		end if;
	end process;
end Behavioral;

