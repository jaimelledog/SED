----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:15:09 12/28/2016 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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

entity counter4bits is
    Port ( clk : in  STD_LOGIC; --reloj
           add : in  STD_LOGIC; --si vale 1, el contador es ascendente, si vale 0 es descendente
			  data : in STD_LOGIC_VECTOR (3 DOWNTO 0); --precarga de datos para empezar a contar desde un valor concreto
           cuenta : out STD_LOGIC_VECTOR (3 DOWNTO 0) --da el valor del contador en cada instante
			  );
end counter4bits;

architecture Behavioral of counter4bits is

	signal cuenta_temp:STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	
begin

	proceso_contador: process(clk, data) begin
		if data'event then --si hay cualquier cambio en data, se carga el nuevo valor para empezar a contar desde ahí
			cuenta_temp<=data;
		end if;
		
		if add='1' then --condiciones si el contador suma
			if cuenta_temp="1111" then --condiciones para volver a empezar a contar si se rebasa el límite
				cuenta_temp<="0000";
			elsif rising_edge(clk) then
				cuenta_temp<=cuenta_temp+1;
			end if;
		elsif add='0' then --condiciones si el contador resta
			if cuenta_temp="0000" then --condiciones para volver a empezar a contar si se rebasa el límite
				cuenta_temp<="1111";
			elsif rising_edge(clk) then
				cuenta_temp<=cuenta_temp-1;
			end if;
		end if;
	end process;
	
cuenta<=cuenta_temp;

end Behavioral;

