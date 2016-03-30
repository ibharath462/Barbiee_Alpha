library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  
  port(i_clk,i_en : in std_logic;
       ira_d,irb_d : in std_logic_vector(7 downto 0);
       aluo : in std_logic_vector(1 downto 0);
       ord_d : out std_logic_vector(7 downto 0);
       ord_f,o_we : out std_logic
       );
  
end entity;

architecture behav of alu is 

  begin
    
    process(i_clk)
      
      begin
        
        if(rising_edge(i_clk) and i_en='1') then
          
          case aluo is
            
            when "00" => ord_d <= std_logic_vector(unsigned(ira_d) + unsigned(irb_d));ord_f <= '1';
            when "01" => ord_d <= std_logic_vector(unsigned(ira_d) - unsigned(irb_d));ord_f <= '1';
            when "10" => ord_d <= ira_d or irb_d;ord_f <= '1';
            when others => report "Error";
            
          end case;
          
          o_we <= '1';
          
        end if;
      
    end process;

end architecture;