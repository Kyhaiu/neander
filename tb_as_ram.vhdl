library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_as_ram is
-- testbench
end entity tb_as_ram;

architecture tb_behavior of tb_as_ram is
constant relogio 	: time 	:= 10 ns;

component as_ram is
	port(
		addr  : in    std_logic_vector(7 downto 0);
		data  : inout std_logic_vector(7 downto 0);
		rnotw : in    std_logic;
		notcs : in    std_logic
	);
end component as_ram;

signal s_addr  : std_logic_vector(7 downto 0);
signal s_data  : std_logic_vector(7 downto 0);
signal s_rnotw : std_logic;
signal s_notcs : std_logic;
signal clk     : std_logic := '0';	-- clk = 0 em t0

begin

	u_ram : as_ram port map(
		s_addr, s_data, s_rnotw, s_notcs);

	tb : process
	begin
		s_notcs <= '1';		
		wait for relogio;	-- inicialização da memória ram com arquivo neanderram.mem
		s_notcs <= '0';
		wait for relogio;

		s_data <= (others => 'Z');	

		-- Read all addrs
		s_rnotw <= '1';
		for i in 0 to 255 loop
			s_addr <= std_logic_vector(to_unsigned(i,8));
			wait for relogio;
		end loop;

		-- 2600 ns
		wait for relogio * 2;	-- teste de regravação parcial
		s_rnotw <= '0';
		s_data <= "00001111";
		s_addr <= "11111110";
		wait for relogio;
		s_data <= (others => 'Z');	
		-- 2610 ns até 5170 ns
		s_rnotw <= '1';
		for i in 0 to 255 loop	-- leitura completa
			s_addr <= std_logic_vector(to_unsigned(i,8));
			wait for relogio;
		end loop;

	wait;
	end process;

	clk <= not(clk) after relogio/2; -- 5 ns
end architecture tb_behavior;
