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
	var/list/buy_region = get_cargo_marker_region("nt_buy")
	if(!length(buy_region))
		return list()

	var/list/empty_turfs = list()
	var/list/pad_turfs = list()
	for(var/turf/open/floor/pad_turf as anything in buy_region)
		pad_turfs += pad_turf
		var/occupied = FALSE
		for(var/atom/movable/occupant in pad_turf.contents)
			if(occupant.anchored || istype(occupant, /obj/effect/landmark/cargo_marker))
				continue
			occupied = TRUE
			break

		if(!occupied)
			empty_turfs += pad_turf

	return length(empty_turfs) ? empty_turfs : pad_turfs

/obj/docking_port/mobile/supply/buy()
	. = ..()

	// random chance chance to get somethingz from the entire cargo catalog, the ATS employees messed up!
	if(anyprob(1) || (HAS_TRAIT(SSstation, STATION_TRAIT_ATS) ? anyprob(1) : FALSE))
		var/datum/supply_pack/pack = SSshuttle.supply_packs[pick(SSshuttle.supply_packs)]
		var/a_msg = "Randomly dropped in [pack.name]([pack.group]) in a cargo shipment."

		investigate_log(a_msg, INVESTIGATE_CARGO)
		log_admin(a_msg)

		var/storage = pack.crate_type
		if(pack.storage_override)
			storage = pack.storage_override
		if(pack.order_flags & ORDER_GOODY)
			storage = /obj/item/storage/briefcase/empty

		var/obj/structure/closet/crate = pack.generate(pick(get_purchase_turfs()), crate_override = storage)
		crate.name += " - #[rand(1, 9000)]"
		do_sparks(1, FALSE, crate)
