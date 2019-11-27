library ieee;
use ieee.std_logic_1164.all;

entity OR8 is
  port(
    A      : in  std_logic_vector(7 downto 0);
    B      : in  std_logic_vector(7 downto 0);
    OUTPUT : out std_logic_vector(7 downto 0)
  );
end entity;

architecture comp of OR8 is
  begin
    OUTPUT(0) <= A(0) or B(0);
    OUTPUT(1) <= A(1) or B(1);
    OUTPUT(2) <= A(2) or B(2);
    OUTPUT(3) <= A(3) or B(3);
    OUTPUT(4) <= A(4) or B(4);
    OUTPUT(5) <= A(5) or B(5);
    OUTPUT(6) <= A(6) or B(6);
    OUTPUT(7) <= A(7) or B(7);
end architecture;
