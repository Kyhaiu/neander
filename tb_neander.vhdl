library ieee;
use ieee.std_logic_1164.all;

entity tb_neander is
end entity;

architecture comp of tb_neander is
  component NEANDER is
    port(
      CLK   : in std_logic;
      CLEAR : in std_logic
    );
  end component;
  signal sRESET, sLOADPC: std_logic;
  signal sCLK : std_logic := '1';
  constant cCLK : time      := 20 ns;

begin
  D_NEANDER : NEANDER
    port map(sCLK, sRESET);

  P_hghjghj : process
    begin
      -- Clear everything and load memory
      sRESET <= '0';
      sLOADPC <= '1';
      wait for cCLK;
      -- Start processor
      sRESET <= '1';
      sLOADPC <= '0';
      wait for cCLK;
    wait;
  end process;

  tb_Clock : process
    begin
      sCLK <= not(sCLK);
        wait for cCLK/2;
    end process;
end architecture;
