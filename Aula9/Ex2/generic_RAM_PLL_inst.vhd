generic_RAM_PLL_inst : generic_RAM_PLL PORT MAP (
		areset	 => areset_sig,
		inclk0	 => inclk0_sig,
		c0	 => c0_sig,
		c1	 => c1_sig,
		locked	 => locked_sig
	);