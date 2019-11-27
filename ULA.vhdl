library ieee;
use ieee.std_logic_1164.all;

entity ULA is
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
end entity;

architecture comp of ULA is
  component AND8 is
    port(
      A      : in  std_logic_vector(7 downto 0);
      B      : in  std_logic_vector(7 downto 0);
      OUTPUT : out std_logic_vector(7 downto 0)
    );
  end component;

  component OR8 is
    port(
      A      : in  std_logic_vector(7 downto 0);
      B      : in  std_logic_vector(7 downto 0);
      OUTPUT : out std_logic_vector(7 downto 0)
    );
  end component;

  component full_Add_8bits is
    port(
      wordA  : in  std_logic_vector(7 downto 0);
      wordB  : in  std_logic_vector(7 downto 0);
      wordS : out std_logic_vector(7 downto 0);
      carryOUT   : out std_logic
    );
  end component;

  component NOT8 is
    port(
      A      : in  std_logic_vector(7 downto 0);
      OUTPUT : out std_logic_vector(7 downto 0)
    );
  end component;

  signal X_not, X_add, X_or, X_and  : std_logic_vector(7 downto 0);
  signal Y_add, Y_or, Y_and, sS_out : std_logic_vector(7 downto 0);
  signal OP                         : std_logic_vector(4 downto 0);
  signal S_not, S_add, S_or, S_and  : std_logic_vector(7 downto 0);
  signal digitalWorks4Sucks, sZ, sN : std_logic;
  signal s_OUT                      : std_logic_vector(7 downto 0);

  begin
    X_not <= X;
    X_add <= X;
    X_or  <= X;
    X_and <= X;
    Y_add <= Y;
    Y_or  <= Y;
    Y_and <= Y;

    OP(0) <= '1' when sel_OP = "000" else '0';
    OP(1) <= '1' when sel_OP = "001" else '0';
    OP(2) <= '1' when sel_OP = "010" else '0';
    OP(3) <= '1' when sel_OP = "011" else '0';
    OP(4) <= '1' when sel_OP = "100" else '0';

    sS_out <= Y     when OP(0) = '1' else "ZZZZZZZZ";
    sS_out <= S_and when OP(1) = '1' else "ZZZZZZZZ";
    sS_out <= S_or  when OP(2) = '1' else "ZZZZZZZZ";
    sS_out <= S_add when OP(3) = '1' else "ZZZZZZZZ";
    sS_out <= S_not when OP(4) = '1' else "ZZZZZZZZ";

    D_AND : AND8
      port map(X_and, Y_and, S_and);
    D_OR : OR8
      port map(X_or, Y_or, S_or);
    D_ADD : full_Add_8bits
      port map(X_add, Y_add, S_add, digitalWorks4Sucks);
    D_NOT : NOT8
      port map(X_not, S_not);

    OUTPUT <= s_OUT;

    FLAG_N <= '1' when s_OUT(7) = '1' else '0';
    FLAG_Z <= '1' when s_OUT    = "00000000" else '0';

end architecture;
