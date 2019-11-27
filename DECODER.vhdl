library ieee;
use ieee.std_logic_1164.all;

entity DECODER is
  port(
    INPUT : in  std_logic_vector(3 downto 0);
    Snop  : out std_logic;
    Ssta  : out std_logic;
    Slda  : out std_logic;
    Sadd  : out std_logic;
    Sor   : out std_logic;
    Sand  : out std_logic;
    Snot  : out std_logic;
    Sjmp  : out std_logic;
    Sjn   : out std_logic;
    Sjz   : out std_logic;
    Shlt  : out std_logic
  );
end entity;

architecture comp of DECODER is
  begin
    Snop <= '1' when INPUT = "0000" else '0';
    Slda <= '1' when INPUT = "0001" else '0';
    Ssta <= '1' when INPUT = "0010" else '0';
    Sadd <= '1' when INPUT = "0011" else '0';
    Sand <= '1' when INPUT = "0100" else '0';
    Sor  <= '1' when INPUT = "0101" else '0';
    Snot <= '1' when INPUT = "0110" else '0';
    Sjmp <= '1' when INPUT = "0111" else '0';
    Sjn  <= '1' when INPUT = "1000" else '0';
    Sjz  <= '1' when INPUT = "1001" else '0';
    Shlt <= '1' when INPUT = "1010" else '0';
end architecture;
