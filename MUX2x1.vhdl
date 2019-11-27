library ieee;
use ieee.std_logic_1164.all;

entity MUX2x1 is
  port(
    A   : in  std_logic;
    B   : in  std_logic;
    SEL : in  std_logic;
    S   : out std_logic
  );
end entity;

architecture comp of MUX2x1 is
  begin
    S <= (not(SEL) and A) or (SEL and B);
end architecture;
