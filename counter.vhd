library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  
  port(clk : in std_logic;
       op  : inout std_logic_vector(2 downto 0)
       );
  
end entity;

architecture behav of counter is

  signal t : std_logic_vector(2 downto 0) := "001";
  signal outclk : std_logic:='0';
  signal count : integer:=0;

  begin
    process(clk)
      begin
        if(rising_edge(clk)) then
          if(count=2) then
            outclk<=not(outclk);
            count<=0;
          else
            count<=count+1;
          end if;
        end if;
      end process;
    
    process(outclk)
      begin
        
        if(rising_edge(outclk)) then
          
          op <= std_logic_vector(to_unsigned(to_integer(unsigned(op))+1,3));
          
        end if;
        
    end process;
  
end behav;
