all:*.vhdl
	ghdl -a $^
tb_neander:tb_neander.vhdl
	ghdl -r tb_neander --wave=wv_result.ghw  --stop-time=140ns

neander:all tb_neander
