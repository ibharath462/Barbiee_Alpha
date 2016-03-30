library ieee;
use ieee.std_logic_1164.all;

entity integ is
  port(
        clk : in std_logic;
        en : in std_logic;
        inst : in std_logic_vector(7 downto 0)
      );
end entity;

architecture behav of integ is

component insdec is
  port(
        i_clk : in  STD_LOGIC;
        i_inst : in  STD_LOGIC_VECTOR (7 downto 0);
        i_en : in  STD_LOGIC;
        ora_en : out  STD_LOGIC_VECTOR (1 downto 0);
        orb_en : out  STD_LOGIC_VECTOR (1 downto 0);
        ord_en : out  STD_LOGIC_VECTOR (1 downto 0);
        ord_d : out  STD_LOGIC_VECTOR (7 downto 0);
        ord_f : out STD_LOGIC;
        o_we : out  STD_LOGIC;
        o_mux : out BIT;
        aluo : out  STD_LOGIC_VECTOR (1 downto 0)
      );
end component;

component regf is
  port(
        i_clk,i_en,i_we,ird_f: in std_logic;
        ira_en,irb_en,ird_en: in std_logic_vector(1 downto 0);
        ora_d,orb_d: out std_logic_vector(7 downto 0);
        ird_d: in std_logic_vector(7 downto 0)
      );
end component;

component alu is
  
  port(i_clk,i_en : in std_logic;
       ira_d,irb_d : in std_logic_vector(7 downto 0);
       aluo : in std_logic_vector(1 downto 0);
       ord_d : out std_logic_vector(7 downto 0);
       ord_f,o_we : out std_logic
       );
  
end component;

component mux is
port(
			i0,i1: in std_logic;
			s:  in bit;
			op: out std_logic
			);
end component;


component mux8 is
port(
			i0,i1: in std_logic_vector(7 downto 0);
			s: in bit;
			op: out std_logic_vector(7 downto 0)
			);
end component;

signal alus,sra_en,srb_en,srd_en : std_logic_vector(1 downto 0);
signal s_we_ins,srd_f_ins,s_we_alu,srd_f_alu,s_we,srd_f : std_logic;
signal s_mux : bit;
signal srd_d_ins,sra_d,srb_d,srd_d_alu,srd_d : std_logic_vector(7 downto 0);
begin
  ins: insdec port map(i_clk=>clk,
                       i_en=>en,
                       i_inst=>inst,
                       o_we=>s_we_ins,
                       ora_en=>sra_en,
                       orb_en=>srb_en,
                       ord_en=>srd_en,
                       ord_d=>srd_d_ins,
                       ord_f=>srd_f_ins,
                       aluo=>alus,
                       o_mux=>s_mux);
  reg: regf port map(
                      i_clk=>clk,
                      i_en=>en,
                      ira_en=>sra_en,
                      irb_en=>srb_en,
                      ird_en=>srd_en,
                      ora_d=>sra_d,
                      orb_d=>srb_d,
                      i_we=>s_we,
                      ird_f=>srd_f,
                      ird_d=>srd_d);
  aluu: alu port map(
                      ira_d=>sra_d,
                      irb_d=>srb_d,
                      i_clk=>clk,
                      i_en=>en,
                      ord_d=>srd_d_alu,
                      ord_f=>srd_f_alu,
                      o_we=>s_we_alu,
                      aluo=>alus);
  mux_rdd: mux8 port map(
                          i0=>srd_d_alu,
                          i1=>srd_d_ins,
                          s=>s_mux,
                          op=>srd_d);
  mux_rdf: mux port map(
                          i0=>srd_f_alu,
                          i1=>srd_f_ins,
                          s=>s_mux,
                          op=>srd_f);
  mux_we: mux port map(
                          i0=>s_we_alu,
                          i1=>s_we_ins,
                          s=>s_mux,
                          op=>s_we);                   
end behav;