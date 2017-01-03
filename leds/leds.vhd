----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:14:17 12/29/2016 
-- Design Name: 
-- Module Name:    leds - Behavioral 
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

entity leds is
	Port ( 
		clk : in  STD_LOGIC;--reloj
		subir : in STD_LOGIC;--vale 1 si sube, 0 si baja
		piso_origen : in  STD_LOGIC_VECTOR(3 DOWNTO 0):="1001";--valores pasados por logica_pisos sobre
		piso_destino : in  STD_LOGIC_VECTOR(3 DOWNTO 0):="1001";--el piso de origen y el de destino
		man_fin : out  STD_LOGIC;--vale 1 si la maniobra ha finalizado, 0 si no. Hasta que un movimiento no termina no se puede iniciar otro
		leds_piso : out  STD_LOGIC_VECTOR(3 DOWNTO 0);--leds que indican el piso en la placa
		pulsos_motor : out  STD_LOGIC);--salida de pulsos para el indicador del motor en la placa
end leds;

architecture Behavioral of leds is

COMPONENT counter4bits
PORT(
	clk : in STD_LOGIC;
	add : in STD_LOGIC;
	data : in STD_LOGIC_VECTOR(3 DOWNTO 0);
	cuenta : out STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END COMPONENT;

COMPONENT conversor_numeracion
PORT(
	data_in : in STD_LOGIC_VECTOR(3 DOWNTO 0);
	data_out : in STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END COMPONENT;


signal cuenta_aux : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal piso_movil : STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
signal piso_origen_aux : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal piso_destino_aux : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal clk_aux : STD_LOGIC:='1';

begin
	
	--contador usado para cambiar el led encendido de los pisos
	--empieza a contar en el piso de origen, y la salida es piso movil
	inst_counter4bits2 : counter4bits port map(
		clk=>clk,
		add=>subir,
		data=>piso_origen_aux(3 DOWNTO 0),
		cuenta=>piso_movil(3 DOWNTO 0)
	);
	
	--convierte el codigo del piso de origen a su correspondiente en los leds de los pisos
	inst_conversor_origen : conversor_numeracion port map(
		data_in=>piso_origen(3 DOWNTO 0),
		data_out=>piso_origen_aux(3 DOWNTO 0)
	);
	
	--convierte el codigo del piso de destino a su correspondiente en los leds de los pisos
	inst_conversor_destino : conversor_numeracion port map(
		data_in=>piso_destino(3 DOWNTO 0),
		data_out=>piso_destino_aux(3 DOWNTO 0)
	);
	
process(piso_destino,clk) begin
	if piso_movil = piso_destino_aux then
		leds_piso<=piso_destino_aux;
		man_fin<='1'; --cuando piso_movil y piso_destino_aux son iguales, acaba la maniobra y puede empezar otra
	elsif subir='1' then --condiciones si el ascensor sube
		while (piso_movil) < (piso_destino_aux) loop
			man_fin<='0';
			leds_piso<=piso_movil;
		end loop;
	elsif subir='0' then --condiciones si el ascensor baja
		while (piso_movil) > (piso_destino_aux) loop
			man_fin<='0';
			leds_piso<=piso_movil;
		end loop;
	end if;
	if piso_movil /= piso_destino_aux then
		if clk_aux = '0' then
			clk_aux <= '1';
		end if;
		if clk'event then
			clk_aux <= '0';
		end if;
	end if;
pulsos_motor<=clk_aux;
end process;

end Behavioral;

