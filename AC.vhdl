library ieee;
use ieee.std_logic_1164.all;

entity AC is
  port(
    INPUT   : in  std_logic_vector(7 downto 0);
    RESET   : in  std_logic;
    CLOCK   : in  std_logic;
    OUTPUT  : out std_logic_vector(7 downto 0);
    LOAD_AC : in  std_logic
  );
end entity;

architecture comp of AC is
  component REG8 is
    port (
      J     : in  std_logic_vector(7 downto 0);
      RESET : in  std_logic;
      CLOCK : in  std_logic;
      Q     : out std_logic_vector(7 downto 0);
      LOAD  : in  std_logic
    );
  end component;

  begin
    D_R : REG8
      port map(INPUT, RESET, CLOCK, OUTPUT, LOAD_AC);
end architecture;
