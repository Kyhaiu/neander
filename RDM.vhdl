library ieee;
use ieee.std_logic_1164.all;

entity RDM is
  port(
    A_I       : in  std_logic_vector(7 downto 0);
    load_RDM  : in  std_logic;
    reset_RDM : in  std_logic;
    CLK       : in  std_logic;
    A_O       : out std_logic_vector(7 downto 0)
  );
end entity;

architecture comp of RDM is
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
    noname : REG8
    port map(A_I, reset_RDM, CLK, A_O, load_RDM);
end architecture;
