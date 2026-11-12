/// Scoops liquid reagents from the turf into the connected pipeline.
/obj/machinery/atmospherics/components/unary/proc/scoop_reagents(max_amount = 10000)
	var/turf/location = get_turf(src)
	if(!location || !location.liquids || !location.liquids.total_reagents || location.liquids.immutable || max_amount <= 0)
		return
	var/datum/pipeline/pipeline = parents[1]
	if(!pipeline?.reagents)
		return
	var/room = pipeline.reagents.maximum_volume - pipeline.reagents.total_volume
	if(room <= 0)
		return
	// take_reagents_flat() returns a holder capped at 10000
	var/amount = min(location.liquids.total_reagents, room, max_amount)
	var/datum/reagents/scooped = location.liquids.take_reagents_flat(amount)
	if(!scooped)
		return
	scooped.trans_to(pipeline.reagents, scooped.total_volume, no_react = TRUE)
	qdel(scooped)

/// Spills up to max_amount reagents from the connected pipeline onto the turf.
/obj/machinery/atmospherics/components/unary/proc/spill_reagents(max_amount = 10000)
	var/turf/location = get_turf(src)
	var/datum/pipeline/pipeline = parents[1]
	if(!location || !pipeline?.reagents || max_amount <= 0)
		return
	var/amount = min(pipeline.reagents.total_volume, max_amount)
	if(amount <= 0)
		return
	var/datum/reagents/spilled = new(amount)
	pipeline.reagents.trans_to(spilled, amount, no_react = TRUE)
	location.add_liquid_from_reagents(spilled, TRUE)
	qdel(spilled)

/// Transfers a fraction of the pipeline's reagents into the given holder.
/obj/machinery/atmospherics/components/unary/proc/transfer_reagents(datum/reagents/target, fraction = 1)
	var/datum/pipeline/pipeline = parents[1]
	if(!pipeline?.reagents || !target || fraction <= 0)
		return FALSE
	return pipeline.reagents.trans_to(target, pipeline.reagents.total_volume * fraction, no_react = TRUE)

/obj/machinery/atmospherics/components/unary/portables_connector/process_atmos()
	. = ..()
	transfer_reagents(connected_device?.reagents)

/obj/machinery/atmospherics/components/unary/passive_vent/process_atmos()
	. = ..()
	var/turf/location = get_turf(src)
	var/datum/pipeline/pipeline = parents[1]
	if(!location || !pipeline?.reagents)
		return
	var/outside = location.liquids?.total_reagents || 0
	var/inside = pipeline.reagents.total_volume
	if(inside > outside)
		spill_reagents(inside - outside)
	else if(outside > inside)
		scoop_reagents(outside - inside)

/obj/machinery/atmospherics/components/unary/vent_pump/process_atmos()
	. = ..()
	if(!is_operational || !on || welded)
		return
	if(pump_direction & ATMOS_DIRECTION_SIPHONING)
		scoop_reagents()
	else if(pump_direction & ATMOS_DIRECTION_RELEASING)
		spill_reagents()

/obj/machinery/atmospherics/components/unary/vent_scrubber/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	if(scrubbing != ATMOS_DIRECTION_SIPHONING)
		var/turf/open/turf = loc
		if(istype(turf) && turf.liquids?.total_reagents)
			return FALSE

	. = ..()

/obj/machinery/atmospherics/components/unary/vent_scrubber/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	. = ..()
	if(. && scrubbing == ATMOS_DIRECTION_SIPHONING)
		scoop_reagents()
