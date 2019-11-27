library ieee;
use ieee.std_logic_1164.all;

entity FFJKMS is
   port (
      J     : in  std_logic;
      K     : in  std_logic;
      CL    : in  std_logic;
      PR    : in  std_logic;
      CLOCK : in  std_logic;
      Q     : out std_logic;
      NQ    : out std_logic
   );
end entity FFJKMS;
architecture comportamento of FFJKMS is
signal MJ1, MJ2, MK1, MK2, EJ1, EJ2, EK1, EK2 : std_logic;
begin

   MJ1 <= not(J and CLOCK and EK2);
   MK1 <= not(not(J) and CLOCK and EJ2);

   MJ2 <= not(MJ1 and PR and MK2);
   MK2 <= not(MK1 and CL and MJ2);

   EJ1 <= (MJ2 nand not(CLOCK));
   EK1 <= (MK2 nand not(CLOCK));

   EJ2 <= not(EJ1 and PR and EK2);
   EK2 <= not(EK1 and CL and EJ2);

   Q  <= EJ2;
   NQ <= EK2;
end architecture comportamento;
