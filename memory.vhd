library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is 

  port(ip : in std_logic_vector(2 downto 0);
       op : out std_logic_vector(7 downto 0)
       );

end entity;

architecture behav of memory is

  type reg is array (0 to 7) of std_logic_vector(7 downto 0);
  signal regs : reg := ("11001111","11101010","11010101","11111111","00100100","01110100","11001111","11101111");
  begin
    
    process(ip)
      begin
        op <= regs(to_integer(unsigned(ip)));
    end process;

end behav; 