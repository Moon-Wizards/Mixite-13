/obj/effect/landmark/cargo_marker
	name = "cargo marker"
	icon = 'modular_zmixite/modules/cargo/icons/markers.dmi'
	icon_state = "start"

	var/region_id = ""
	var/end = FALSE

// For mapping
/obj/effect/landmark/cargo_marker/end
	icon_state = "end"
	end = TRUE

/proc/get_cargo_marker_region(region_id)
	var/turf/region_start
	var/turf/region_end
	for(var/obj/effect/landmark/cargo_marker/marker in GLOB.landmarks_list)
		if(marker.region_id != region_id)
			continue

		if(marker.end)
			region_end = get_turf(marker)
		else
			region_start = get_turf(marker)

	if(!region_start || !region_end)
		CRASH("cargo marker region [region_id] is missing a start or end marker")
	if(region_start.z != region_end.z)
		CRASH("cargo marker region [region_id] has markers on different zlevels")

	return block(region_start, region_end)
