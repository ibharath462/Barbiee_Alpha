library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regf is
  port(
        i_clk,i_en,i_we,ird_f: in std_logic;
        ira_en,irb_en,ird_en: in std_logic_vector(1 downto 0);
        ora_d,orb_d: out std_logic_vector(7 downto 0);
        ird_d: in std_logic_vector(7 downto 0)
      );
end entity;

architecture behav of regf is
type store_t is array (0 to 3) of std_logic_vector(7 downto 0);
signal regs: store_t := (others => X"00");
begin
  process(i_clk)
    begin
      if(rising_edge(i_clk) and i_en='1') then
        if(ira_en/="UU") then
          ora_d<=regs(to_integer(unsigned(ira_en)));
        end if;
        if(irb_en/="UU") then
          orb_d<=regs(to_integer(unsigned(irb_en)));
        end if;
        if(i_we='1') then
          if(ird_f='1' and ird_en/="UU") then
            regs(to_integer(unsigned(ird_en)))<=ird_d;
          elsif(ird_f='0' and ird_en/="UU") then
            regs(to_integer(unsigned(ird_en)))<=regs(to_integer(unsigned(ird_en))) or ird_d;
         end if;
       end if;
      end if;
    end process;
end behav;
