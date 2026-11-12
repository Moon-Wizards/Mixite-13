/// Sets up the reagent holder for a portable atmos machine.
/obj/machinery/portable_atmospherics/proc/initialize_reagents()
	if(!reagents)
		create_reagents(volume)
	reagents.my_atom = src
	RegisterSignal(reagents, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagents_changed))
	update_reagent_capacity()

/// Recalculates reagent capacity and shrinks the gas volume by the reagent volume.
/obj/machinery/portable_atmospherics/proc/update_reagent_capacity()
	if(!reagents)
		return
	reagents.maximum_volume = max(volume * REAGENT_VOLUME_RATIO, reagents.total_volume)
	if(air_contents)
		air_contents.volume = max(volume - reagents.total_volume, MINIMUM_GAS_VOLUME)

/// When reagents change, ensure the machine keeps processing.
/obj/machinery/portable_atmospherics/proc/on_reagents_changed(datum/reagents/holder)
	SIGNAL_HANDLER
	update_reagent_capacity()
	if(holder.total_volume)
		SSair.start_processing_machine(src)

/// Processes reagent chemistry and temperature coupling each atmos tick.
/obj/machinery/portable_atmospherics/proc/process_reagents(seconds_per_tick)
	if(!reagents || !air_contents || !length(reagents.reagent_list))
		return FALSE
	// Temperature coupling
	process_reagent_temperature()
	if(!suppress_reactions)
		reagents.handle_reactions()
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		reagent.on_atmos_tick(src, seconds_per_tick)
	return TRUE

/// Bidirectional heat exchange between gas and reagent liquid in a portable machine.
/obj/machinery/portable_atmospherics/proc/process_reagent_temperature()
	if(!reagents?.total_volume || !air_contents)
		return
	var/reagent_heat_cap = reagents.total_volume * REAGENT_HEAT_CAPACITY
	var/gas_heat_cap = air_contents.heat_capacity()
	if(reagent_heat_cap <= 0 || gas_heat_cap <= 0)
		return
	var/combined_temp = (air_contents.temperature * gas_heat_cap + reagents.chem_temp * reagent_heat_cap) / (gas_heat_cap + reagent_heat_cap)
	air_contents.temperature = combined_temp
	reagents.set_temperature(combined_temp)

/// Spills reagents when the portable machine is destroyed. Tries holding tank first.
/obj/machinery/portable_atmospherics/proc/spill_reagents()
	if(!reagents?.total_volume)
		return
	if(holding?.reagents)
		reagents.trans_to(holding.reagents, reagents.total_volume, no_react = TRUE)
		if(!reagents.total_volume)
			return
	var/turf/spill_turf = get_turf(src)
	if(spill_turf)
		spill_turf.add_liquid_from_reagents(reagents, TRUE)
	reagents.clear_reagents()

/// Process reagents alongside atmos for portable machines.
/obj/machinery/portable_atmospherics/process_atmos_reagents(seconds_per_tick)
	if(machine_stat & BROKEN)
		return FALSE
	return process_reagents(seconds_per_tick)

/// Portable pump: move reagents between holding tank and machine based on pump direction.
/obj/machinery/portable_atmospherics/pump/process_atmos_reagents(seconds_per_tick)
	if(!(machine_stat & BROKEN) && on && holding?.reagents)
		if(direction == PUMP_IN)
			holding.reagents.trans_to(reagents, holding.reagents.total_volume, no_react = TRUE)
		else
			reagents.trans_to(holding.reagents, reagents.total_volume, no_react = TRUE)
	return ..()

/// Pull reagents from holding tank into the machine.
/obj/machinery/portable_atmospherics/scrubber/process_atmos_reagents(seconds_per_tick)
	if(!(machine_stat & BROKEN) && on && holding?.reagents)
		holding.reagents.trans_to(reagents, holding.reagents.total_volume, no_react = TRUE)
	return ..()
