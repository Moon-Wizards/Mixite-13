/obj/machinery/atmos_shield_gen/active/preset

/obj/machinery/atmos_shield_gen/active/preset/RefreshParts()
	var/prev_range = max_range
	. = ..()
	var/datum/stock_part/capacitor/capacitor = locate() in component_parts
	active_power_usage = initial(active_power_usage) / capacitor.tier // 0.25kw per tile at tier 4
	max_range = prev_range

/obj/machinery/atmos_shield_gen/active/preset/attack_hand()
	return ITEM_INTERACT_FAILURE

/obj/machinery/atmos_shield_gen/active/preset/attack_hand_secondary()
	return ITEM_INTERACT_FAILURE

obj/machinery/atmos_shield_gen/active/preset/screwdriver_act()
	return ITEM_INTERACT_FAILURE

/obj/machinery/atmos_shield_gen/active/preset/crowbar_act()
	return ITEM_INTERACT_FAILURE

/obj/machinery/atmos_shield_gen/active/preset/wrench_act()
	return ITEM_INTERACT_FAILURE
