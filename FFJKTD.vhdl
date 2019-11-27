library ieee;
use ieee.std_logic_1164.all;

entity FFJKTD is
  port (
     J     : in  std_logic;
     CL    : in  std_logic;
     PR    : in  std_logic;
     CLOCK : in  std_logic;
     Q     : out std_logic
  );
end entity;
architecture comp of FFJKTD is
  component FFJKMS is
     port (
        J     : in  std_logic;
        K     : in  std_logic;
        CL    : in  std_logic;
        PR    : in  std_logic;
        CLOCK : in  std_logic;
        Q     : out std_logic;
        NQ    : out std_logic
      );
  end component;

  signal saux : std_logic;
  begin
    fftd : FFJKMS
    port map(J, J, CL, PR, CLOCK, Q, saux);
end architecture;
