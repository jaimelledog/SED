----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:47:43 12/29/2016 
-- Design Name: 
-- Module Name:    logica_pisos - Behavioral 
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

entity logica_pisos is

	generic(
		piso_actual: STD_LOGIC_VECTOR (3 DOWNTO 0):="1001"--piso en el que nos encontramos, por defecto la planta baja (codificada como 1001 por la placa)
	);
	
	Port( 
		man_fin : in STD_LOGIC;--detecta si la ultima maniobra ha terminado para poder empezar otra nueva
		piso_llamado : in  STD_LOGIC_VECTOR(3 DOWNTO 0);--entrada con el piso al que se quiere ir
		piso_ok : out  STD_LOGIC_VECTOR (3 DOWNTO 0);--salida si el piso al que se desea ir es lógico (depende de la subida o la bajada)
		subida : out STD_LOGIC--vale 1 si el ascensor sube, 0 si baja
	);
	
end logica_pisos;

architecture Behavioral of logica_pisos is
signal aux: STD_LOGIC_VECTOR (3 DOWNTO 0);
begin
	
	process(piso_llamado,man_fin) begin --comprobaciones de si las llamadas son correctas piso por piso
		--comprobación del fin de la maniobra anterior
		if man_fin='0' then
			
		--subida desde el 0
		elsif (piso_actual="1001") and ((piso_llamado="1000")or(piso_llamado="0110")or(piso_llamado="0100")or(piso_llamado="0010")or(piso_llamado="0000"))then
			aux<=piso_llamado;
			subida<='1';
		--subida desde el 1
		elsif ((piso_actual="1000")or(piso_actual="0111")) and ((piso_llamado="0110")or(piso_llamado="0100")or(piso_llamado="0010")or(piso_llamado="0000"))then
			aux<=piso_llamado;
			subida<='1';
		--subida desde el 2
		elsif ((piso_actual="0101")or(piso_actual="0110")) and ((piso_llamado="")or(piso_llamado="")or(piso_llamado="")or(piso_llamado="")or(piso_llamado=""))then
			aux<=piso_llamado;
			subida<='1';
		--subida desde el 3
		elsif ((piso_actual="0100")or(piso_actual="0011")) and ((piso_llamado="")or(piso_llamado="")or(piso_llamado="")or(piso_llamado="")or(piso_llamado=""))then
			aux<=piso_llamado;
			subida<='1';
		--subida desde el 4
		elsif ((piso_actual="0010")or(piso_actual="0001")) and ((piso_llamado="")or(piso_llamado="")or(piso_llamado="")or(piso_llamado="")or(piso_llamado=""))then
			aux<=piso_llamado;
			subida<='1';
		--bajada desde el 5
		elsif (piso_actual="0000") and ((piso_llamado="0001")or(piso_llamado="0011")or(piso_llamado="0101")or(piso_llamado="0111")or(piso_llamado="1001"))then
			aux<=piso_llamado;
			subida<='0';
		--bajada desde el 4
		elsif ((piso_actual="0001")or(piso_actual="0010")) and ((piso_llamado="0011")or(piso_llamado="0101")or(piso_llamado="0111")or(piso_llamado="1001"))then
			aux<=piso_llamado;
			subida<='0';
		--bajada desde el 3
		elsif ((piso_actual="0011")or(piso_actual="0100")) and ((piso_llamado="0101")or(piso_llamado="0111")or(piso_llamado="1001"))then
			aux<=piso_llamado;
			subida<='0';
		--bajada desde el 2
		elsif ((piso_actual="0101")or(piso_actual="0110")) and ((piso_llamado="0111")or(piso_llamado="1001"))then
			aux<=piso_llamado;
			subida<='0';
		--bajada desde el 1
		elsif ((piso_actual="0111")or(piso_actual="1000")) and (piso_llamado="1001")then
			aux<=piso_llamado;
			subida<='0';
		end if;
	end process;
piso_ok<=aux;
end Behavioral;

