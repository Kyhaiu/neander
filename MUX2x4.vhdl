library ieee;
use ieee.std_logic_1164.all;

entity MUX2x4 is
  port(
    A   : in  std_logic_vector(3 downto 0);
    B   : in  std_logic_vector(3 downto 0);
    SEL : in  std_logic;
    S   : out std_logic_vector(3 downto 0)
  );
end entity;

architecture comp of MUX2x4 is
  component MUX2x1 is
    port(
      A   : in std_logic;
      B   : in std_logic;
      SEL : in std_logic;
      S   : out std_logic
    );
  end component;
  begin
    GEN_1 :
    for i in 0 to 3 generate
      mux : MUX2x1
      port map(A(i), B(i), SEL, S(i));
    end generate;
end architecture;
