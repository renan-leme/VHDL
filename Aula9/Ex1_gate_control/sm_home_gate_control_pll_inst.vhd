sm_home_gate_control_pll_inst : sm_home_gate_control_pll PORT MAP (
		areset	 => areset_sig,
		inclk0	 => inclk0_sig,
		c0	 => c0_sig,
		locked	 => locked_sig
	);
