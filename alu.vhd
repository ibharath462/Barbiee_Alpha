library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  
  port(i_clk,i_en : in std_logic;
       ora_d,orb_d : in std_logic_vector(7 downto 0);
       aluo : in std_logic_vector(1 downto 0);
       op : out std_logic_vector(7 downto 0);
       ird_f,i_we : out std_logic
       );
  
end entity;

architecture behav of alu is 

  begin
    
    process(i_clk)
      
      begin
        
        if(rising_edge(i_clk) and i_en='1') then
          
          case aluo is
            
            when "00" => op <= std_logic_vector(unsigned(ora_d) + unsigned(orb_d));
            when "01" => op <= std_logic_vector(unsigned(ora_d) - unsigned(orb_d));
            when "10" => op <= ora_d or orb_d;
            when others => report "Error";
            
          end case;
          
          i_we <= '1';
          ird_f <= '1';
          
        end if;
      
    end process;

end architecture;