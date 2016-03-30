library ieee;
use ieee.std_logic_1164.all;

entity pc is
  
  port(clk,en : in std_logic);
  
end entity;

architecture behav of pc is

  component counter is
  
  port(clk : in std_logic;
       op  : inout std_logic_vector(2 downto 0)
       );
  
  end component;
  
  component memory is 

  port(ip : in std_logic_vector(2 downto 0);
       op : out std_logic_vector(7 downto 0)
       );

  end component;
  
  component integ is
  port(
        clk : in std_logic;
        en : in std_logic;
        inst : in std_logic_vector(7 downto 0)
      );
  end component;


  signal instruction : std_logic_vector(7 downto 0);
  signal t : std_logic_vector(2 downto 0);

  begin
    
    g1 : counter port map(clk,t);
    g2 : memory port map(t,instruction);
    g3 : integ port map(clk,en,instruction);

end behav;
