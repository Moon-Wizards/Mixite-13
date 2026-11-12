/// Sets up the reagent holder for a gas tank.
/obj/item/tank/proc/initialize_reagents()
	create_reagents(volume)
	reagents.my_atom = src
	RegisterSignal(reagents, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagents_changed))
	update_reagent_capacity()

/// Signal handler: reagents displace gas in the tank, so keep the gas volume in sync.
/obj/item/tank/proc/on_reagents_changed(datum/reagents/holder)
	SIGNAL_HANDLER
	update_reagent_capacity()

/// Recalculates reagent capacity and shrinks the gas volume by the reagent volume.
/obj/item/tank/proc/update_reagent_capacity()
	if(!reagents)
		return
	reagents.maximum_volume = max(volume * REAGENT_VOLUME_RATIO, reagents.total_volume)
	if(air_contents)
		air_contents.volume = max(volume - reagents.total_volume, MINIMUM_GAS_VOLUME)

/// Processes reagent chemistry and temperature coupling each tank tick.
/obj/item/tank/proc/process_reagents(seconds_per_tick)
	if(!reagents || !air_contents || !length(reagents.reagent_list))
		return
	// Temperature coupling
	process_reagent_temperature()
	reagents.handle_reactions()
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		reagent.on_atmos_tick(src, seconds_per_tick)

/// Bidirectional heat exchange between gas and reagent liquid in a tank.
/obj/item/tank/proc/process_reagent_temperature()
	if(!reagents?.total_volume || !air_contents)
		return
	var/reagent_heat_cap = reagents.total_volume * REAGENT_HEAT_CAPACITY
	var/gas_heat_cap = air_contents.heat_capacity()
	if(reagent_heat_cap <= 0 || gas_heat_cap <= 0)
		return
	var/combined_temp = (air_contents.temperature * gas_heat_cap + reagents.chem_temp * reagent_heat_cap) / (gas_heat_cap + reagent_heat_cap)
	air_contents.temperature = combined_temp
	reagents.set_temperature(combined_temp)

/// Spills reagents when a tank is destroyed. Tries holding machine first.
/obj/item/tank/proc/spill_reagents()
	if(!reagents?.total_volume)
		return
	if(istype(loc, /obj/machinery/portable_atmospherics))
		var/obj/machinery/portable_atmospherics/machine = loc
		if(machine.reagents)
			reagents.trans_to(machine.reagents, reagents.total_volume, no_react = TRUE)
			return
	var/turf/spill_turf = get_turf(src)
	if(spill_turf)
		spill_turf.add_liquid_from_reagents(reagents, TRUE)
	reagents.clear_reagents()

/obj/item/tank/examine(mob/user)
	. = ..()

	if(reagents?.total_volume)
		var/volume = reagents.total_volume
		var/max = reagents.maximum_volume
		var/fill_ratio = volume / max

		var/weight
		var/sloshy

		switch(volume)
			if(5 to 10)
				weight = "feels a little heavier"
			if(10 to 20)
				weight = "has some noticeable additional weight to it"
			if(20 to 50)
				weight = "is quite heavy"
			if(50 to INFINITY)
				weight = "is extremely heavier"

		switch(fill_ratio)
			if(0 to 0.1)
				sloshy = "a small amount of liquid sloshes around inside"
			if(0.1 to 0.3)
				sloshy = "liquid sloshes around inside"
			if(0.3 to 0.5)
				sloshy = "liquid noticeably sloshes around inside"
			if(0.5 to 0.8)
				sloshy = "liquid sloshes around quite a bit inside"
			if(0.8 to INFINITY)
				sloshy = "liquid barely has any room to move around inside"

		. += span_notice("[weight ? "It [weight], and " : "You feel how "][sloshy].")
