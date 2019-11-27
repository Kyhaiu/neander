library ieee;
use ieee.std_logic_1164.all;

entity REG8 is
  port(
    J     : in  std_logic_vector(7 downto 0);
    RESET : in  std_logic;
    CLOCK : in  std_logic;
    Q     : out std_logic_vector(7 downto 0);
    LOAD  : in  std_logic
  );
end entity;

architecture comp of REG8 is
  component FFJKTD is
    port (
       J     : in  std_logic;
       CL    : in  std_logic;
       PR    : in  std_logic;
       CLOCK : in  std_logic;
       Q     : out std_logic
    );
  end component;
  component MUX2x8 is
    port(
      A   : in  std_logic_vector(7 downto 0);
      B   : in  std_logic_vector(7 downto 0);
      SEL : in  std_logic;
      S   : out std_logic_vector(7 downto 0)
    );
  end component;

  signal sQ : std_logic_vector(7 downto 0);
  signal sS : std_logic_vector(7 downto 0);
  signal sJ : std_logic_vector(7 downto 0);

  begin
    mux : MUX2x8
    port map(J, sQ, LOAD, sS);
    GEN_1 :
    for i in 0 to 7 generate
      ff : FFJKTD
      port map(sS(i), RESET, '1', CLOCK, sQ(i));
    end generate;
    Q <= sQ;
    sJ <= J;
end architecture;
