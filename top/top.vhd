----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:36:46 12/30/2016 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is--esta entidad relaciona todas las anteriores y las encapsula
    Port ( clk : in  STD_LOGIC;--entrada de reloj
           botones_out : out  STD_LOGIC_VECTOR(3 DOWNTO 0);--salida para comprobar qué botón está pulsado
           leds_piso_out : out  STD_LOGIC_VECTOR(3 DOWNTO 0);--salida para encender los leds de los pisos
           pulsos_motor_out : out  STD_LOGIC;--salida para mandar los pulsos a los leds de giro
           sentido_motor_out : out  STD_LOGIC;--salida que especifica el sentido de los leds de giro
           detector_llamada_in : in  STD_LOGIC);--se pone a 0 si botones_out coincide con el botón pulsado
end top;

architecture Behavioral of top is

COMPONENT clk_gen
PORT(
	clk : in STD_LOGIC;
	clk_mod : out STD_LOGIC;
	divide_value : in integer
);
END COMPONENT;

COMPONENT detector_botones
PORT(
	clk : in STD_LOGIC;
	secuencia_bot : out STD_LOGIC_VECTOR(3 DOWNTO 0);
	detector_llamada : in STD_LOGIC;
	piso_llamado : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
	man_fin : in STD_LOGIC
);
END COMPONENT;

COMPONENT logica_pisos
PORT(
	man_fin : in STD_LOGIC;
	piso_llamado : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
	piso_ok : out STD_LOGIC_VECTOR(3 DOWNTO 0);
	subir : out STD_LOGIC
);
END COMPONENT;

COMPONENT leds
PORT(
	clk : in STD_LOGIC;
	subir : in STD_LOGIC;
	piso_origen : in STD_LOGIC_VECTOR(3 DOWNTO 0);
	piso_destino : in STD_LOGIC_VECTOR(3 DOWNTO 0);
	man_fin : out STD_LOGIC;
	leds_piso : out STD_LOGIC_VECTOR(3 DOWNTO 0);
	pulsos_motor : out STD_LOGIC
);
END COMPONENT;

signal clk_mod_bot : STD_LOGIC;
signal clk_mod_leds : STD_LOGIC;
signal man_fin_aux : STD_LOGIC;
signal subir_aux : STD_LOGIC;
signal piso_llamado_aux : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal piso_ok_aux : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal piso_origen_aux : STD_LOGIC_VECTOR(3 DOWNTO 0);


begin

inst_clk_bot : clk_gen port map(
	clk=>clk,
	clk_mod=>clk_mod_bot,
	divide_value=>100
);

inst_clk_leds : clk_gen port map(
	clk=>clk,
	clk_mod=>clk_mod_leds,
	divide_value=>50000000
);

inst_det_bot : detector_botones port map(
	clk=>clk_mod_bot,
	secuencia_bot=>botones_out(3 DOWNTO 0),
	detector_llamada=>detector_llamada_in,
	piso_llamado=>piso_llamado_aux(3 DOWNTO 0),
	man_fin=>man_fin_aux
	);

inst_log_pis : logica_pisos port map(
	man_fin=>man_fin_aux,
	piso_llamado=>piso_llamado_aux(3 DOWNTO 0),
	piso_ok=>piso_ok_aux(3 DOWNTO 0),
	subir=>subir_aux
);

inst_leds : leds port map(
	clk=>clk_mod_leds,
	subir=>subir_aux,
	piso_origen=>piso_origen_aux(3 DOWNTO 0),
	piso_destino=>piso_ok_aux(3 DOWNTO 0),
	man_fin=>man_fin_aux,
	leds_piso=>leds_piso_out(3 DOWNTO 0),
	pulsos_motor=>pulsos_motor_out
);

end Behavioral;

