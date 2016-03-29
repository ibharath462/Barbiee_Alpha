library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity insdec is
  port(
        i_clk : in  STD_LOGIC;
        i_inst : in  STD_LOGIC_VECTOR (7 downto 0);
        i_en : in  STD_LOGIC;
        ora_en : out  STD_LOGIC_VECTOR (1 downto 0);
        orb_en : out  STD_LOGIC_VECTOR (1 downto 0);
        ord_en : out  STD_LOGIC_VECTOR (1 downto 0);
        ord_d : out  STD_LOGIC_VECTOR (7 downto 0);
        o_we : out  STD_LOGIC;
        aluo : out  STD_LOGIC_VECTOR (1 downto 0));
end entity;
architecture behav of insdec is
signal i_data : STD_LOGIC_VECTOR (7 downto 0):=X"00";
begin
  process(i_clk)
    begin
      if((rising_edge(i_clk)) and i_en='1') then
        if(i_inst(7 downto 6)!="11")
          ora_en<=i_inst(1 downto 0);
          orb_en<=i_inst(3 downto 2);
          ord_en<=i_inst(5 downto 4);
          aluo<=i_inst(7 downto 6);
        else
          aluo<=i_inst(7 downto 6);
          ord_d<=i_inst(3 downto 0);
          o_we<='1';
          if(i_inst(4)='0') then
            ord_en<="00";
          else
            ord_en<="01";
          end if;
        end if;
      end process;
    end behav;