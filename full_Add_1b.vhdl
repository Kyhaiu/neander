library ieee;
use ieee.std_logic_1164.all;

entity full_Add_1b is
   port(
      wordA : in std_logic;
      wordB : in std_logic;
      carryIN : in std_logic;
      wordS : out std_logic;
      carryOUT : out std_logic 
   );
end entity full_Add_1b;

architecture operation of full_Add_1b is
   begin
      wordS <= (wordA xor wordB) xor carryIN;
      carryOUT <= (wordB and carryIN) or 
                  (wordA and carryIN) or 
                  (wordA and wordB);
end architecture operation;
