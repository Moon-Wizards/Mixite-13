/// Mirrors the filter's gas path so reagents only move when gas does, splitting them between the
/// side and main outputs in the same ratio as the filtered and passed gas.
/obj/machinery/atmospherics/components/trinary/filter/process_atmos_reagents(seconds_per_tick)
	if(!on || !(nodes[1] && nodes[2] && nodes[3]) || !is_operational)
		return FALSE
	var/datum/gas_mixture/air1 = airs[1]
	if(!air1 || air1.temperature <= 0)
		return FALSE
	var/datum/gas_mixture/air2 = airs[2]
	var/datum/gas_mixture/air3 = airs[3]
	if(!air2 || !air3)
		return FALSE
	// Same output checks as the gas path, so liquids never appear on a blocked line
	var/side_output_full = air2.return_pressure() >= MAX_OUTPUT_PRESSURE
	var/main_output_full = air3.return_pressure() >= MAX_OUTPUT_PRESSURE
	if(side_output_full && main_output_full)
		return FALSE
	var/datum/pipeline/input = parents[1]
	var/datum/pipeline/side = parents[2]
	var/datum/pipeline/main_output = parents[3]
	if(!input?.reagents?.total_volume)
		return FALSE
	var/transfer_ratio = min(1, transfer_rate / max(air1.volume, 1))
	if(transfer_ratio <= 0)
		return FALSE
	// No gas means the gas path moves nothing, so nothing can carry the reagents.
	var/input_moles = air1.total_moles()
	if(input_moles <= 0)
		return FALSE
	// remove_ratio() samples the input proportionally, so the filtered share of the moved gas
	// equals the filtered share of the whole input mix.
	var/filtered_ratio = 0
	if(filter_type.len)
		var/filtered_moles = 0
		for(var/gas in air1.moles & filter_type)
			filtered_moles += air1.moles[gas]
		filtered_ratio = clamp(filtered_moles / input_moles, 0, 1)
	var/total = input.reagents.total_volume
	var/amount = 0
	if(!side_output_full && filtered_ratio > 0 && side?.reagents)
		amount += input.reagents.trans_to(side.reagents, total * filtered_ratio * transfer_ratio, no_react = TRUE)
	if(!main_output_full && filtered_ratio < 1 && main_output?.reagents)
		amount += input.reagents.trans_to(main_output.reagents, total * (1 - filtered_ratio) * transfer_ratio, no_react = TRUE)
	return amount

/// Mirrors the mixer's gas path so reagents leave each intake in the same proportion as the gas pulled from it.
/obj/machinery/atmospherics/components/trinary/mixer/process_atmos_reagents(seconds_per_tick)
	if(!on || !(nodes[1] && nodes[2] && nodes[3]) || !is_operational)
		return FALSE
	var/datum/gas_mixture/air1 = airs[1]
	var/datum/gas_mixture/air2 = airs[2]
	var/datum/gas_mixture/air3 = airs[3]
	if(!air1 || !air2 || !air3)
		return FALSE
	var/output_starting_pressure = air3.return_pressure()
	if(output_starting_pressure >= target_pressure)
		return FALSE
	var/general_transfer = (target_pressure - output_starting_pressure) * air3.volume / R_IDEAL_GAS_EQUATION
	var/combined_heat_capacity = air1.heat_capacity() + air2.heat_capacity()
	var/equalized_temperature = combined_heat_capacity ? (air1.thermal_energy() + air2.thermal_energy()) / combined_heat_capacity : 0
	if(!equalized_temperature)
		return FALSE
	var/transfer_moles1 = (node1_concentration * general_transfer) / equalized_temperature
	var/transfer_moles2 = (node2_concentration * general_transfer) / equalized_temperature
	var/air1_moles = air1.total_moles()
	var/air2_moles = air2.total_moles()
	if(!node2_concentration)
		if(air1.temperature <= 0)
			return FALSE
		transfer_moles1 = min(transfer_moles1, air1_moles)
		transfer_moles2 = 0
	else if(!node1_concentration)
		if(air2.temperature <= 0)
			return FALSE
		transfer_moles2 = min(transfer_moles2, air2_moles)
		transfer_moles1 = 0
	else
		if(air1.temperature <= 0 || air2.temperature <= 0)
			return FALSE
		if(transfer_moles1 <= 0 || transfer_moles2 <= 0)
			return FALSE
		if(air1_moles < transfer_moles1 || air2_moles < transfer_moles2)
			var/ratio = min(air1_moles / transfer_moles1, air2_moles / transfer_moles2)
			transfer_moles1 *= ratio
			transfer_moles2 *= ratio
	var/datum/pipeline/input1 = parents[1]
	var/datum/pipeline/input2 = parents[2]
	var/datum/pipeline/output = parents[3]
	if(!output?.reagents)
		return FALSE
	var/amount = 0
	if(transfer_moles1 > 0 && air1_moles > 0 && input1?.reagents?.total_volume)
		amount += input1.reagents.trans_to(output.reagents, input1.reagents.total_volume * transfer_moles1 / air1_moles, no_react = TRUE)
	if(transfer_moles2 > 0 && air2_moles > 0 && input2?.reagents?.total_volume)
		amount += input2.reagents.trans_to(output.reagents, input2.reagents.total_volume * transfer_moles2 / air2_moles, no_react = TRUE)
	return amount
