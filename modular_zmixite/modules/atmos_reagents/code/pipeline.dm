/datum/pipeline
	/// Liquids contained within this pipeline
	var/datum/reagents/reagents
	/// Total internal volume of the pipe network, before liquids displace any gas
	var/physical_volume = 0

/obj/machinery/atmospherics/pipe/add_member(obj/machinery/atmospherics/considered_device)
	// pipes can be added before the rebuild queue gives them a parent
	if(!parent)
		SSair.add_to_rebuild_queue(src)
		return

	return ..()

/// Recalculates reagent capacity and the remaining gas volume from the network's physical volume.
/datum/pipeline/proc/update_reagent_capacity()
	if(!reagents || !air)
		return
	reagents.maximum_volume = max(physical_volume * REAGENT_VOLUME_RATIO, reagents.total_volume)
	// Liquids displace gas, so the gas volume shrinks as reagents fill the network.
	air.volume = max(physical_volume - reagents.total_volume, MINIMUM_GAS_VOLUME)

/// When reagents change, ensure the pipeline keeps processing.
/datum/pipeline/proc/on_reagents_changed(datum/reagents/holder)
	SIGNAL_HANDLER
	update_reagent_capacity()
	update = TRUE

/// Processes reagent chemistry and temperature coupling each atmos tick.
/datum/pipeline/proc/process_reagents(seconds_per_tick)
	if(!reagents || !air || !length(reagents.reagent_list))
		return
	if(QDELETED(reagents.my_atom))
		reagents.my_atom = length(members) ? members[1] : (length(other_atmos_machines) ? other_atmos_machines[1] : null)
	// Temperature coupling: gas and liquid exchange heat
	process_reagent_temperature()
	reagents.handle_reactions()
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		reagent.on_atmos_tick(src, seconds_per_tick)
	for(var/obj/machinery/atmospherics/components/component as anything in other_atmos_machines)
		component.on_atmos_reagent_tick(src, seconds_per_tick)

/// Bidirectional heat exchange between gas mixture and reagent liquid.
/datum/pipeline/proc/process_reagent_temperature()
	if(!reagents?.total_volume || !air)
		return
	var/reagent_heat_cap = reagents.total_volume * REAGENT_HEAT_CAPACITY
	var/gas_heat_cap = air.heat_capacity()
	if(reagent_heat_cap <= 0 || gas_heat_cap <= 0)
		return
	var/combined_temp = (air.temperature * gas_heat_cap + reagents.chem_temp * reagent_heat_cap) / (gas_heat_cap + reagent_heat_cap)
	air.temperature = combined_temp
	reagents.set_temperature(combined_temp)

/// Spills reagents when the pipeline is destroyed. Tries vents first, then any member.
/datum/pipeline/proc/spill_reagents()
	if(!reagents?.total_volume)
		return
	var/turf/spill_turf
	for(var/obj/machinery/atmospherics/components/component as anything in other_atmos_machines)
		if(!istype(component, /obj/machinery/atmospherics/components/unary/vent_pump) && \
			!istype(component, /obj/machinery/atmospherics/components/unary/vent_scrubber) && \
			!istype(component, /obj/machinery/atmospherics/components/unary/passive_vent))
			continue
		spill_turf = get_turf(component)
		if(spill_turf)
			break
	if(!spill_turf)
		for(var/obj/machinery/atmospherics/member as anything in members)
			spill_turf = get_turf(member)
			if(spill_turf)
				break
	if(!spill_turf)
		for(var/obj/machinery/atmospherics/member as anything in other_atmos_machines)
			spill_turf = get_turf(member)
			if(spill_turf)
				break
	if(spill_turf)
		spill_turf.add_liquid_from_reagents(reagents, TRUE)
	reagents.clear_reagents()
