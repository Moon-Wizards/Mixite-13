/// Called each atmos tick for reagents inside a pipeline, portable, or tank.
/datum/reagent/proc/on_atmos_tick(datum/source, seconds_per_tick)
	return

/// Called each atmos tick for machines connected to a pipeline that has reagents.
/obj/machinery/atmospherics/proc/on_atmos_reagent_tick(datum/pipeline/pipeline, seconds_per_tick)
	return

/// Called by SSair alongside process_atmos. Return TRUE to prevent PROCESS_KILL.
/obj/machinery/proc/process_atmos_reagents(seconds_per_tick)
	return FALSE
