library ieee;
use ieee.std_logic_1164.all;


entity CONT07 is
  port(
    CLOCK  : in std_logic;
    CLEAR  : in std_logic;
    PAUSE  : in std_logic;
    PRESET : in std_logic;
    NUM    : out std_logic_vector(2 downto 0)
  );
end entity;

architecture comp of CONT07 is
  component FFJKMS is
    port(
      J     : in  std_logic;
      K     : in  std_logic;
      CL    : in  std_logic;
      PR    : in  std_logic;
      CLOCK : in  std_logic;
      Q     : out std_logic;
      NQ    : out std_logic
    );
  end component;

  signal sJ_1, sJ_2 : std_logic_vector(2 downto 0);
      signal sK_1, sK_2 : std_logic_vector(2 downto 0);
      signal sQ, nQ      : std_logic_vector(2 downto 0);

  begin
      GEN_1 :
      for i in 0 to 2 generate
          sJ_1(i) <= (sJ_2(i) and PAUSE);
          sK_1(i) <= (sK_2(i) and PAUSE);
      end generate;

      GEN_2 :
      for i in 0 to 2 generate
          T_FF : FFJKMS
              port map(sJ_1(i), sK_1(i), CLEAR, PRESET, CLOCK, sQ(i), nQ(i));
      end generate;

      sJ_2(0) <= '1';
      sJ_2(1) <= sQ(0);
      sJ_2(2) <= sQ(0) and sQ(1);

      sK_2(0) <= '1';
      sK_2(1) <= sQ(0);
      sK_2(2) <= sQ(0) and sQ(1);

      NUM     <= sQ;
end architecture;
