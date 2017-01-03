----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:12 01/03/2017 
-- Design Name: 
-- Module Name:    clk_gen - Behavioral 
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

entity clk_gen is
port(   clk : in std_logic;--reloj de alta frecuencia entrante
        clk_mod : out std_logic;--reloj de baja frecuencia saliente
        divide_value : in integer--resultado de dividir la frecuencia de clk entre la de clk_mod
        );
end clk_gen;

architecture Behavioral of clk_gen is

signal counter,divide : integer := 0;

begin

divide <= divide_value;

process(clk) 
begin
    if( rising_edge(clk) ) then
        if(counter < divide/2-1) then
            counter <= counter + 1;
            clk_mod <= '0';
        elsif(counter < divide-1) then
            counter <= counter + 1;
            clk_mod <= '1';
        else
            clk_mod <= '0';
            counter <= 0;
        end if; 
    end if;
end process;    

end Behavioral;

