LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY test_regf IS
END test_regf;
 
ARCHITECTURE behavior OF test_regf IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
   
component regf is
  port(
        clk,en,we: in std_logic;
        ra_en,rb_en,rd_en: in std_logic_vector(1 downto 0);
        ra_d,rb_d: out std_logic_vector(7 downto 0);
        rd_d: in std_logic_vector(7 downto 0)
      );
end component;
 
   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal rd_d : std_logic_vector(7 downto 0) := (others => '0');
   signal ra_en : std_logic_vector(1 downto 0) := (others => '0');
   signal rb_en : std_logic_vector(1 downto 0) := (others => '0');
   signal rd_en : std_logic_vector(1 downto 0) := (others => '0');
   signal we : std_logic := '0';
 
  --Outputs
   signal ra_d : std_logic_vector(7 downto 0);
   signal rb_d : std_logic_vector(7 downto 0);
 
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: regf PORT MAP (
          clk => clk,
          en => en,
          ra_d => rd_d,
          rb_d=> rb_d,
          rd_d => rd_d,
          ra_en => ra_en,
          rb_en => rb_en,
          rd_en => rd_en,
          we => we
        );
 
   -- Clock process definitions
   clk_process :process
   begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;  
 
      wait for clk_period*10;
 
      -- insert stimulus here 
 
    en <= '1';
 
    -- test for writing.
    -- r0 = 0xfab5
    ra_en <= "00";
    rb_en <= "01";
    rd_en <= "00";
    rd_d <= X"FA";
    we <= '1';
      wait for clk_period;
 
    -- r2 = 0x2222
    ra_en <= "00";
    rb_en <= "01";
    rd_en <= "10";
    rd_d <= X"22";
    we <= '1';
      wait for clk_period;
 
    -- r3 = 0x3333
    ra_en <= "00";
    rb_en <= "01";
    rd_en <= "10";
    rd_d <= X"33";
    we <= '1';
      wait for clk_period;
 
    --test just reading, with no write
    ra_en <= "00";
    rb_en <= "01";
    rd_en <= "00";
    rd_d <= X"ED";
    we <= '0';
      wait for clk_period;
 
    --at this point dataA should not be 'feed'
 
    ra_en <= "01";
    rd_en <= "10";
      wait for clk_period;
 
    ra_en <= "11";
    rb_en <= "10";
      wait for clk_period;
 
    ra_en <= "00";
    rb_en <= "01";
    rd_en <= "10";
    rd_d <= X"44";
    we <= '1';
      wait for clk_period;
 
    we <= '0';
      wait for clk_period;
 
    -- nop
      wait for clk_period;
 
    ra_en <= "01";
    rb_en <= "10";
      wait for clk_period;
 
      wait;
   end process;
 
END;