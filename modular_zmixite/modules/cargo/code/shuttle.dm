/obj/docking_port/mobile/supply/canMove()
	. = ..()
	if(!.)
		return FALSE

	if(is_station_level(z))
		return check_blacklist(shuttle_areas)

	return TRUE

/obj/docking_port/mobile/supply/check_blacklist(areaInstances)
	for(var/area/shuttle_area as anything in areaInstances)
		for(var/list/zlevel_turfs as anything in shuttle_area.get_zlevel_turf_lists())
			for(var/turf/shuttle_turf as anything in zlevel_turfs)
				for(var/atom/passenger in shuttle_turf.get_all_contents())
					if(ismob(passenger))
						var/mob/mob = passenger
						if(ACCESS_CARGO in mob.get_access())
							continue
						else
							return FALSE

					if((is_type_in_typecache(passenger, GLOB.blacklisted_cargo_types) || HAS_TRAIT(passenger, TRAIT_BANNED_FROM_CARGO_SHUTTLE)) && !istype(passenger, /obj/docking_port))
						return FALSE
	return TRUE

/obj/docking_port/mobile/supply/return_blacklisted_things_home(list/area/areas_to_check, obj/docking_port/stationary/home)
	var/list/stuff_to_send_home = list()
	for(var/area/shuttle_area as anything in areas_to_check)
		for (var/list/zlevel_turfs as anything in shuttle_area.get_zlevel_turf_lists())
			for(var/turf/shuttle_turf as anything in zlevel_turfs)
				for(var/atom/passenger in shuttle_turf.get_all_contents())
					if(ismob(passenger))
						continue // droppodding random mobs sounds like a horrendous idea.

					if((is_type_in_typecache(passenger, GLOB.blacklisted_cargo_types) || HAS_TRAIT(passenger, TRAIT_BANNED_FROM_CARGO_SHUTTLE)) && !istype(passenger, /obj/docking_port))
						stuff_to_send_home += passenger

	if(!length(stuff_to_send_home))
		return FALSE

	podspawn(list(
		"target" = get_turf(home),
		"path" = /obj/structure/closet/supplypod/centcompod,
		"spawn" = stuff_to_send_home,
	))

	return stuff_to_send_home

/obj/docking_port/mobile/supply/sell()
	return

/obj/docking_port/mobile/supply/proc/get_purchase_turfs()
	var/list/empty_turfs = list()
	for(var/area/shuttle/shuttle_area as anything in shuttle_areas)
		for(var/turf/open/floor/shuttle_turf in shuttle_area.get_turfs_from_all_zlevels())
			if(shuttle_turf.is_blocked_turf())
				continue
			empty_turfs += shuttle_turf
	return empty_turfs
