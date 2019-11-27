library ieee;
use ieee.std_logic_1164.all;

entity REGPC is
  port(
    INPUT     : in  std_logic_vector(7 downto 0);
    RESET     : in  std_logic;
    CLOCK     : in  std_logic;
    OUTPUT    : out std_logic_vector(7 downto 0);
    LOAD      : in  std_logic
  );
end entity;

architecture comp of REGPC is
  component REG8 is
    port(
      J     : in  std_logic_vector(7 downto 0);
      RESET : in  std_logic;
      CLOCK : in  std_logic;
      Q     : out std_logic_vector(7 downto 0);
      LOAD  : in  std_logic
    );
  end component;
begin
  R_PC : REG8
  port map(INPUT, RESET, CLOCK, OUTPUT, LOAD);
end architecture;
