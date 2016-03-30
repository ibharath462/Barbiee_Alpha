library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8 is
port(
			i0,i1: in std_logic_vector(7 downto 0);
			s: in bit;
			op: out std_logic_vector(7 downto 0)
			);
end mux8;

architecture Behavioral of mux8 is

begin
process(s,i0,i1)
begin
	if(s='0') then op<=i0;
	else op<=i1;
	end if;
end process;
end Behavioral;