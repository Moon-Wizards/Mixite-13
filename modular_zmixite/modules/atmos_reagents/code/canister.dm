/// Releases canister reagents into holding tank or onto the turf.
/obj/machinery/portable_atmospherics/canister/proc/release_reagents()
	if(!valve_open || !reagents?.total_volume)
		return
	if(holding)
		if(holding.reagents)
			reagents.trans_to(holding.reagents, reagents.total_volume, no_react = TRUE)
		return
	var/turf/spill_turf = get_turf(src)
	if(spill_turf)
		spill_turf.add_liquid_from_reagents(reagents, TRUE)
		reagents.clear_reagents()
