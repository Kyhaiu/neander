-- neander asynchronous simple ram memory
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;

entity as_ram is
	port(
		addr  : in    std_logic_vector(7 downto 0);
		data  : inout std_logic_vector(7 downto 0);
		rnotw : in    std_logic;
		notcs : in    std_logic
	);
end entity as_ram;

architecture behavior of as_ram is
	type ram_type is array (0 to 255) of std_logic_vector(7 downto 0);
	signal ram : ram_type;
	signal data_out : std_logic_vector(7 downto 0);
begin
	
	rampW : process(rnotw, notcs, addr, data)
	type binary_file is file of character;
	file load_file : binary_file open read_mode is "neanderram.mem";
	variable char : character;
	begin
		if (notcs = '1' and notcs'event) then
			-- init ram
			read(load_file, char); -- 0x03 '.'
			read(load_file, char); -- 0x4E 'N'
			read(load_file, char); -- 0x44 'D'
			read(load_file, char); -- 0x52 'R'
			for i in 0 to 255 loop
				if not endfile(load_file) then
						read(load_file, char);
						ram(i) <= std_logic_vector(to_unsigned(character'pos(char),8));
						read(load_file, char);	-- 0x00 orindo de alinhamento 16bits	
				end if; -- if not endfile(load_file) then
			end loop; -- for i in 0 to 255
        else
		    if (notcs = '0' and rnotw = '0') then
			    -- Write
			    ram(to_integer(unsigned(addr))) <= data;
		    end if; -- notcs == '0'
		end if; -- notcs = '1'
	end process rampW;

	data <= data_out when (notcs = '0' and rnotw = '1')
		  else (others => 'Z');

	rampR : process(rnotw, notcs, addr, data)
	begin
		if (notcs = '0' and rnotw = '1') then
				-- Read
				data_out <= ram(to_integer(unsigned(addr)));
		end if; -- notcs = '0' and rnotw = '1'
	end process rampR;
end architecture behavior;
