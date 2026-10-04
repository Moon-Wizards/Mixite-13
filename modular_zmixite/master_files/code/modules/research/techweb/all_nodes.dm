/datum/techweb_node/xenobiology/New()
	unlocked_designs += list(
		/datum/design/limb_disk/arachnid,
		/datum/design/limb_disk/hydrakin,
	)
	return ..()

/datum/techweb_node/adv_vision/New()
	unlocked_designs += list(
		/datum/design/cyberimp_thermals/hydrakin,
		/datum/design/cyberimp_xray/hydrakin,
	)
	return ..()

/datum/techweb_node/augmentation/New()
	unlocked_designs += list(
		/datum/design/cybernetic_eyes/hydrakin,
		/datum/design/cyberkin_head,
		/datum/design/cyberkin_chest,
		/datum/design/cyberkin_l_arm,
		/datum/design/cyberkin_r_arm,
		/datum/design/cyberkin_l_leg,
		/datum/design/cyberkin_r_leg,
	)
	return ..()

/datum/techweb_node/cyber/cyber_organs_upgraded/New()
	unlocked_designs += list(
		/datum/design/cyberimp_welding/hydrakin,
	)
	return ..()
