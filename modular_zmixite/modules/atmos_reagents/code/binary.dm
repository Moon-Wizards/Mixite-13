/// Transfers a fraction of reagents from the input pipeline to the output pipeline.
/obj/machinery/atmospherics/components/binary/proc/transfer_reagents(fraction = 1)
	if(!on || !is_operational || fraction <= 0)
		return FALSE
	var/datum/pipeline/input = parents[1]
	var/datum/pipeline/output = parents[2]
	if(!input?.reagents || !output?.reagents)
		return FALSE
	return input.reagents.trans_to(output.reagents, input.reagents.total_volume * fraction, no_react = TRUE)

/// Equalizes reagent concentration between both pipelines, proportional to their volumes.
/obj/machinery/atmospherics/components/binary/proc/equalize_reagents()
	var/datum/pipeline/first = parents[1]
	var/datum/pipeline/second = parents[2]
	if(!first?.reagents || !second?.reagents)
		return
	var/first_volume = first.reagents.maximum_volume
	var/second_volume = second.reagents.maximum_volume
	if(first_volume + second_volume <= 0)
		return
	var/target = (first.reagents.total_volume + second.reagents.total_volume) * first_volume / (first_volume + second_volume)
	var/delta = first.reagents.total_volume - target
	if(delta > 0)
		first.reagents.trans_to(second.reagents, delta, no_react = TRUE)
	else if(delta < 0)
		second.reagents.trans_to(first.reagents, -delta, no_react = TRUE)

/// An open valve reconciles both networks, so equalize their liquids at the same time.
/obj/machinery/atmospherics/components/binary/valve/return_pipenets_for_reconcilation(datum/pipeline/requester)
	. = ..()
	if(on)
		equalize_reagents()

/// Liquids move with the gas while the gate is passing it.
/obj/machinery/atmospherics/components/binary/temperature_gate/process_atmos_reagents(seconds_per_tick)
	if(!is_gas_flowing)
		return FALSE
	return transfer_reagents()

/obj/machinery/atmospherics/components/binary/pressure_valve/process_atmos_reagents(seconds_per_tick)
	if(!is_gas_flowing)
		return FALSE
	return transfer_reagents()

/// Mirrors release_gas_to()'s pressure check so liquids only move when gas would.
/obj/machinery/atmospherics/components/binary/passive_gate/process_atmos_reagents(seconds_per_tick)
	var/datum/gas_mixture/input_air = airs[1]
	var/datum/pipeline/output = parents[2]
	if(!input_air || !output?.air)
		return FALSE
	if(output.air.return_pressure() >= min(target_pressure, input_air.return_pressure() - 10))
		return FALSE
	return transfer_reagents()

/obj/machinery/atmospherics/components/binary/pump/process_atmos_reagents(seconds_per_tick)
	return transfer_reagents()

/obj/machinery/atmospherics/components/binary/volume_pump/process_atmos_reagents(seconds_per_tick)
	var/datum/gas_mixture/input_air = airs[1]
	if(!input_air)
		return FALSE
	// Match the pump's gas transfer ratio so liquids move at the configured rate
	return transfer_reagents(min(1, transfer_rate / max(input_air.volume, 1)))
