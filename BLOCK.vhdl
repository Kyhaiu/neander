library ieee;
use ieee.std_logic_1164.all;

entity BLOCKER is
  port(
    INPUT     : in std_logic_vector(7 downto 0);
    OUTPUT    : out std_logic_vector(7 downto 0);
    SEL_BLOCK : in std_logic
  );
end entity;

architecture comp of BLOCKER is
  signal to_output : std_logic_vector(7 downto 0);
  begin
    to_output <= INPUT when SEL_BLOCK = '1' else (others => 'Z');
    OUTPUT    <= to_output;
end architecture;
