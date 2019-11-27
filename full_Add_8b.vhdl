library ieee;
use ieee.std_logic_1164.all;

entity full_Add_8bits is
    port(
        wordA  : in  std_logic_vector(7 downto 0);
        wordB  : in  std_logic_vector(7 downto 0);
        wordS : out std_logic_vector(7 downto 0);
        carryOUT   : out std_logic
        );
end entity;

architecture comp of full_Add_8bits is
    component full_Add_1b is
        port(
            wordA  : in  std_logic;
            wordB  : in  std_logic;
            carryIN : in  std_logic;
            wordS  : out std_logic;
            carryOUT : out std_logic
            );
    end component;

    signal ts_1, ts_2, ts_3, ts_4, ts_5, ts_6, ts_7 : std_logic;

begin
    X_0 : full_Add_1b
        port map(wordA(0), wordB(0), '0', wordS(0), ts_1);

    X_1 : full_Add_1b
        port map(wordA(1), wordB(1), ts_1, wordS(1), ts_2);

    X_2 : full_Add_1b
        port map(wordA(2), wordB(2), ts_2, wordS(2), ts_3);

    X_3 : full_Add_1b
        port map(wordA(3), wordB(3), ts_3, wordS(3), ts_4);

    X_4 : full_Add_1b
        port map(wordA(4), wordB(4), ts_4, wordS(4), ts_5);

    X_5 : full_Add_1b
        port map(wordA(5), wordB(5), ts_5, wordS(5), ts_6);

    X_6 : full_Add_1b
        port map(wordA(6), wordB(6), ts_6, wordS(6), ts_7);

    X_7 : full_Add_1b
        port map(wordA(7), wordB(7), ts_7, wordS(7), carryOUT);
end architecture;
