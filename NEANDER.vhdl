library ieee;
use ieee.std_logic_1164.all;

entity NEANDER is
  port(
    CLK   : in std_logic;
    CLEAR : in std_logic
    --PANIC : in std_logic;
  );
end entity;

architecture comp of NEANDER is
  component PC is
    port(
      INPUT       : in  std_logic_vector(7 downto 0);
      RESET       : in  std_logic;
      CLOCK       : in  std_logic;
      OUTPUT      : out std_logic_vector(7 downto 0);
      LOAD_REG_PC : in  std_logic;
      SEL_PC      : in  std_logic
    );
  end component;
  component MUX2x8 is
    port(
      A   : in  std_logic_vector(7 downto 0);
      B   : in  std_logic_vector(7 downto 0);
      SEL : in  std_logic;
      S   : out std_logic_vector(7 downto 0)
    );
  end component;
  component R_E_M is
    port(
      A_I       : in  std_logic_vector(7 downto 0);
      load_REM  : in  std_logic;
      reset_REM : in  std_logic;
      CLK       : in  std_logic;
      A_O       : out std_logic_vector(7 downto 0)
    );
  end component;
  component as_ram is
  	port(
  		addr  : in    std_logic_vector(7 downto 0);
  		data  : inout std_logic_vector(7 downto 0);
  		rnotw : in    std_logic;
  		notcs : in    std_logic
  	);
  end component;
    component RDM is
      port(
        A_I       : in  std_logic_vector(7 downto 0);
        load_RDM  : in  std_logic;
        reset_RDM : in  std_logic;
        CLK       : in  std_logic;
        A_O       : out std_logic_vector(7 downto 0)
      );
    end component;
    component BLOCKER is
      port(
        INPUT     : in std_logic_vector(7 downto 0);
        OUTPUT    : out std_logic_vector(7 downto 0);
        SEL_BLOCK : in std_logic
      );
    end component;
    component RI is
        port(
          INPUT   : in  std_logic_vector(7 downto 0);
          RESET   : in  std_logic;
          CLOCK   : in  std_logic;
          OUTPUT  : out std_logic_vector(3 downto 0);
          LOAD_RI : in  std_logic
        );
    end component;
    component DECODER is
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
    end component;
    component UC is
      port(
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
    end component;
    component AC is
      port(
        INPUT   : in  std_logic_vector(7 downto 0);
        RESET   : in  std_logic;
        CLOCK   : in  std_logic;
        OUTPUT  : out std_logic_vector(7 downto 0);
        LOAD_AC : in  std_logic
      );
    end component;
    component ULA is
      port(
        X       : in  std_logic_vector(7 downto 0);
        Y       : in  std_logic_vector(7 downto 0);
        FLAG_N  : out std_logic;
        FLAG_Z  : out std_logic;
        SEL_OP  : in  std_logic_vector(2 downto 0);
        C_FLAGS : in  std_logic;
        CLOCK   : in  std_logic;
        CLEAR   : in  std_logic;
        OUTPUT  : out std_logic_vector(7 downto 0)
      );
    end component;

    signal PC_MUX     : std_logic_vector(7 downto 0);
    signal MUX_REM    : std_logic_vector(7 downto 0);
    signal REM_MEM    : std_logic_vector(7 downto 0);
    signal MEM_RDM    : std_logic_vector(7 downto 0);
    signal RDM_BLOCK  : std_logic_vector(7 downto 0);
    signal BARR       : std_logic_vector(7 downto 0);
    signal BLOCK_IR   : std_logic_vector(7 downto 0);
    signal IR_DECODER : std_logic_vector(3 downto 0);
    signal DECODER_UC : std_logic_vector(10 downto 0);
    signal ULA_AC     : std_logic_vector(7 downto 0);
    signal AC_ULA     : std_logic_vector(7 downto 0);

    signal sCLK : std_logic;
    signal sCLEAR : std_logic;

    signal FLAGS      : std_logic_vector(1 downto 0);
    signal AC_FLAGS   : std_logic;
    signal SEL_OP_ULA : std_logic_vector(2 downto 0);
    signal SEL_PC     : std_logic;
    signal c_PC       : std_logic;
    signal SEL_MUX    : std_logic;
    signal c_REM      : std_logic;
    signal c_RDM      : std_logic;
    signal c_BLOCK    : std_logic;
    signal n_cBLOCK   : std_logic;
    signal r_NOT_W    : std_logic;
    signal c_RI       : std_logic;
    signal n_CLEAR    : std_logic;

begin
    n_CLEAR <= not(sCLEAR);

    D_PC      : PC
      port map(BARR, sCLEAR, sCLK, PC_MUX, c_PC, SEL_PC);
    D_MUX     : MUX2x8
      port map(PC_MUX, BARR, SEL_MUX, MUX_REM);
    D_REM     : R_E_M
      port map(MUX_REM, c_REM, CLEAR, sCLK, REM_MEM);
    D_AS_RAM  : as_ram
      port map(REM_MEM, MEM_RDM, r_NOT_W, n_CLEAR);
    D_RDM     : RDM
      port map(MEM_RDM, c_RDM, sCLEAR, sCLK, RDM_BLOCK);
    n_cBLOCK <= not(c_BLOCK);
    D_BLOCK1  : BLOCKER
      port map(RDM_BLOCK, BARR, c_BLOCK);
    D_BLOCK2  : BLOCKER
      port map(BARR, MEM_RDM, n_cBLOCK);
    D_BLOCK3  : BLOCKER
      port map(AC_ULA, BARR, n_cBLOCK);
    D_RI      : RI
      port map(BARR, sCLEAR, sCLK, IR_DECODER, c_RI);
    D_DECODER : DECODER
      port map(IR_DECODER, DECODER_UC(0), DECODER_UC(1), DECODER_UC(2),
                           DECODER_UC(3), DECODER_UC(4), DECODER_UC(5),
                           DECODER_UC(6), DECODER_UC(7), DECODER_UC(8),
                           DECODER_UC(9), DECODER_UC(10));
    D_UC : UC
      port map(DECODER_UC(0), DECODER_UC(1), DECODER_UC(2),
               DECODER_UC(3), DECODER_UC(4), DECODER_UC(5),
               DECODER_UC(6), DECODER_UC(7), DECODER_UC(8),
               DECODER_UC(9), DECODER_UC(10), sCLK, sCLEAR,
               FLAGS(1), FLAGS(0), AC_FLAGS, SEL_OP_ULA,
               SEL_PC, c_PC, SEL_MUX, c_REM, c_RDM, c_BLOCK,
               r_NOT_W, c_RI);
    D_ULA     : ULA
      port map(BARR, AC_ULA, FLAGS(0), FLAGS(1), SEL_OP_ULA, AC_FLAGS,
               sCLK, sCLEAR, ULA_AC);
    D_AC      : AC
      port map(ULA_AC, CLEAR, sCLK, AC_ULA, AC_FLAGS);

    sCLK <= CLK;
    sCLEAR <= CLEAR;

end architecture;
