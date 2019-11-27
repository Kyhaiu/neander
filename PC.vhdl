library ieee;
use ieee.std_logic_1164.all;

entity PC is
  port(
    INPUT       : in  std_logic_vector(7 downto 0);
    RESET       : in  std_logic;
    CLOCK       : in  std_logic;
    OUTPUT      : out std_logic_vector(7 downto 0);
    LOAD_REG_PC : in  std_logic;
    SEL_PC      : in  std_logic
  );
end entity;

architecture comp of PC is
  component REGPC is
    port(
      INPUT     : in  std_logic_vector(7 downto 0);
      RESET     : in  std_logic;
      CLOCK     : in  std_logic;
      OUTPUT    : out std_logic_vector(7 downto 0);
      LOAD      : in  std_logic
    );
  end component;
  component full_Add_8bits is
    port(
      wordA     : in  std_logic_vector(7 downto 0);
      wordB     : in  std_logic_vector(7 downto 0);
      wordS     : out std_logic_vector(7 downto 0);
      carryOUT  : out std_logic
    );
  end component;

  signal from_add : std_logic_vector(7 downto 0);
  signal from_reg : std_logic_vector(7 downto 0);
  signal to_reg   : std_logic_vector(7 downto 0);
  signal digitalworks4sucks : std_logic;

  begin
    D_FA : full_Add_8bits
      port map("00000001", from_reg, from_add, digitalworks4sucks);
    D_PC : REGPC
      port map(to_reg, RESET, CLOCK, from_reg, LOAD_REG_PC);

    to_reg <= from_add when SEL_PC = '0' else INPUT;
    OUTPUT <= from_reg;
end architecture;
