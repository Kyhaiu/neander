library ieee;
use ieee.std_logic_1164.all;

entity UC is
  Port(
    sNOP    : in std_logic;
    sLDA    : in std_logic;
    sSTA    : in std_logic;
    sADD    : in std_logic;
    sE      : in std_logic;
    sOU     : in std_logic;
    sNAO    : in std_logic;
    sJMP    : in std_logic;
    sJN     : in std_logic;
    sJZ     : in std_logic;
    sHLT    : in std_logic;
    CLOCK  : in std_logic;
    RESET  : in std_logic;
    FLAG_N : in std_logic;
    FLAG_Z : in std_logic;
    c_AC_FLAGS : out std_logic;
    SEL_OP_ULA : out std_logic_vector(2 downto 0);
    SEL_PC     : out std_logic;
    c_PC       : out std_logic;
    SEL_MUX    : out std_logic;
    c_REM      : out std_logic;
    c_RDM      : out std_logic;
    BLOQUEIOS  : out std_logic;
    r_NOT_W    : out std_logic;
    c_RI       : out std_logic
  );
end entity;

architecture comp of UC is
  component CONT07 is
    port(
      CLOCK  : in std_logic;
      CLEAR  : in std_logic;
      PAUSE  : in std_logic;
      PRESET : in std_logic;
      NUM    : out std_logic_vector(2 downto 0)
    );
  end component;
  component NOP is
    port(
      INPUT  : in  std_logic_vector(2 downto 0);
      OUTPUT : out std_logic_vector(11 downto 0)
    );
  end component;
  component LDA is
    port(
      INPUT  : in  std_logic_vector(2 downto 0);
      OUTPUT : out std_logic_vector(11 downto 0)
    );
  end component;

  signal S_NOP, S_OUT, S_LDA : std_logic_vector(11 downto 0);
  signal CONT         : std_logic_vector(2 downto 0);
  signal PAUSE        : std_logic;

begin
  D_COUNTER : CONT07
    port map(CLOCK, RESET, PAUSE, '1', CONT);

  D_NOP : NOP
    port map(CONT, S_NOP);

  D_LDA : LDA
    port map(CONT, S_LDA);

  S_OUT       <= S_NOP when sNOP = '1'  else (others => 'Z');
  S_OUT       <= S_LDA when sLDA = '1'  else (others => 'Z');

  c_AC_FLAGS    <= S_OUT(11);
  SEL_OP_ULA(2) <= S_OUT(10);
  SEL_OP_ULA(1) <= S_OUT(9);
  SEL_OP_ULA(0) <= S_OUT(8);
  SEL_PC        <= S_OUT(7);
  c_PC          <= S_OUT(6);
  SEL_MUX       <= S_OUT(5);
  c_REM         <= S_OUT(4);
  c_RDM         <= S_OUT(3);
  BLOQUEIOS     <= S_OUT(2);
  r_NOT_W       <= S_OUT(1);
  c_RI          <= S_OUT(0);

end architecture;
