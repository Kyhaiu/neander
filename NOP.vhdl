library ieee;
use ieee.std_logic_1164.all;

entity NOP is
  port(
    INPUT  : in  std_logic_vector(2 downto 0);
    OUTPUT : out std_logic_vector(11 downto 0)
  );
end entity;

architecture comp of NOP is
  signal INTERNAL_IN  : std_logic_vector(2 downto 0);
  signal INTERNAL_OUT : std_logic_vector(11 downto 0);

begin
  --REM <- PC
  --RDM <- MEM
  --PC  <- PC++
  --RI  <- RDM
    INTERNAL_IN <= INPUT;

    INTERNAL_OUT(11)  <= '0'; --cAC/FLAG
    INTERNAL_OUT(10)  <= '0'; --SEL OP ULA 2
    INTERNAL_OUT(9)  <= '0'; --SEL OP ULA 1
    INTERNAL_OUT(8)  <= '0'; --SEL OP ULA 0
    INTERNAL_OUT(7)  <= INTERNAL_IN(0) and INTERNAL_IN(1) and not(INTERNAL_IN(2)); --SEL PC
    INTERNAL_OUT(6)  <= '0'; --cPC
    INTERNAL_OUT(5)  <= INTERNAL_IN(0) and not(INTERNAL_IN(1)) and INTERNAL_IN(2); --SEL MUX
    INTERNAL_OUT(4)  <= INTERNAL_IN(0) and not(INTERNAL_IN(1)) and INTERNAL_IN(2); --cREM
    INTERNAL_OUT(3)  <= INTERNAL_IN(0) and INTERNAL_IN(1) and not(INTERNAL_IN(2)); --cRDM
    INTERNAL_OUT(2)  <= INTERNAL_IN(0) and INTERNAL_IN(1) and INTERNAL_IN(2);--BLOCK
    INTERNAL_OUT(1) <= '1'; --R NOT(W)
    INTERNAL_OUT(0) <= INTERNAL_IN(0) and INTERNAL_IN(1) and INTERNAL_IN(2); --cRI

    OUTPUT <= INTERNAL_OUT;
end architecture;
