library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
port(
			i0,i1: in std_logic;
			s: in bit;
			op: out std_logic
			);
end mux;

architecture Behavioral of mux is

begin
process(s,i0,i1)
begin
	if(s='0') then op<=i0;
	else op<=i1;
	end if;
end process;
end Behavioral;