/datum/id_trim/job/shaft_miner
	assignment = JOB_SHAFT_MINER
	trim_state = "trim_shaftminer"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SHAFT_MINER
	minimal_access = list(
		ACCESS_AUX_BASE,
		ACCESS_CARGO,
		ACCESS_SHIPPING,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		)
	extra_access = list(
		ACCESS_BIT_DEN,
		ACCESS_MAINT_TUNNELS,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_QM,
		)
	job = /datum/job/shaft_miner
