library ieee;
use ieee.std_logic_1164.all;

entity RI is
    port(
      INPUT   : in  std_logic_vector(7 downto 0);
      RESET   : in  std_logic;
      CLOCK   : in  std_logic;
      OUTPUT  : out std_logic_vector(3 downto 0);
      LOAD_RI : in  std_logic
    );
end entity;

architecture comp of RI is
  component REG4 is
    port(
      J     : in  std_logic_vector(3 downto 0);
      RESET : in  std_logic;
      CLOCK : in  std_logic;
      Q     : out std_logic_vector(3 downto 0);
      LOAD  : in  std_logic
    );
  end component;

  signal A_4I : std_logic_vector(3 downto 0);

  begin
    A_4I(3) <= INPUT(7);
    A_4I(2) <= INPUT(6);
    A_4I(1) <= INPUT(5);
    A_4I(0) <= INPUT(4);

    D_REG4 : REG4
      port map(A_4I, RESET, CLOCK, OUTPUT, LOAD_RI);
end architecture;
