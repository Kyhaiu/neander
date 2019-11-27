library ieee;
use ieee.std_logic_1164.all;

entity AND8 is
  port(
    A      : in  std_logic_vector(7 downto 0);
    B      : in  std_logic_vector(7 downto 0);
    OUTPUT : out std_logic_vector(7 downto 0)
  );
end entity;

architecture comp of AND8 is
  begin
    OUTPUT(0) <= A(0) and B(0);
    OUTPUT(1) <= A(1) and B(1);
    OUTPUT(2) <= A(2) and B(2);
    OUTPUT(3) <= A(3) and B(3);
    OUTPUT(4) <= A(4) and B(4);
    OUTPUT(5) <= A(5) and B(5);
    OUTPUT(6) <= A(6) and B(6);
    OUTPUT(7) <= A(7) and B(7);
end architecture;
