library ieee;
use ieee.std_logic_1164.all;

entity NOT8 is
  port(
    A      : in  std_logic_vector(7 downto 0);
    OUTPUT : out std_logic_vector(7 downto 0)
  );
end entity;

architecture comp of NOT8 is
  begin
    OUTPUT(0) <= not(A(0));
    OUTPUT(1) <= not(A(1));
    OUTPUT(2) <= not(A(2));
    OUTPUT(3) <= not(A(3));
    OUTPUT(4) <= not(A(4));
    OUTPUT(5) <= not(A(5));
    OUTPUT(6) <= not(A(6));
    OUTPUT(7) <= not(A(7));
end architecture;
