/datum/controller/subsystem/automapper
	/// The paths to our TOML files
	var/list/config_files = list(
		"_maps/nova/automapper/automapper_config.toml",
		"_maps/mixite/automapper/automapper_config.toml",
	)
	/// Our loaded TOML files
	var/list/loaded_configs = list()

/datum/controller/subsystem/automapper/Initialize()
	for(var/config_path in config_files)
		var/config = rustg_read_toml_file(config_path)
		if(!config)
			CRASH("Could not read automapper config [config_path]")

		loaded_configs += list(config)

	return SS_INIT_SUCCESS

/datum/controller/subsystem/automapper/preload_templates_from_toml(map_names)
	if(!islist(map_names))
		map_names = list(map_names)

	for(var/config in loaded_configs)
		for(var/template in config["templates"])
			var/selected_template = config["templates"][template]
			var/required_map = selected_template["required_map"]

			var/requires_builtin = \
				required_map == AUTOMAPPER_MAP_BUILTIN \
				&& ((SSmapping.current_map.map_file in map_names) \
				|| SSmapping.current_map.map_file == map_names)

			if(!requires_builtin && !(required_map in map_names))
				continue

			var/list/coordinates = selected_template["coordinates"]
			if(LAZYLEN(coordinates) != 3)
				CRASH("Invalid coordinates for automap template [template]!")

			var/desired_z = SSmapping.levels_by_trait(selected_template["trait_name"])[coordinates[3]]
			var/turf/load_turf = locate(coordinates[1], coordinates[2], desired_z)
			var/map_file = selected_template["directory"] + pick(selected_template["map_files"])

			if(!fexists(map_file))
				CRASH("[template] could not find map file [map_file]!")

			var/datum/map_template/automap_template/map = new(map_file, template, required_map, load_turf)
			preloaded_map_templates += map

/datum/controller/subsystem/automapper/proc/load_templates_for_ruin(datum/map_template/ruin/ruin, turf/central_turf)
	var/list/path_parts = splittext(ruin.mappath, "/")
	var/required_map = path_parts[path_parts.len]
	var/turf/ruin_origin = locate(central_turf.x - round(ruin.width / 2), central_turf.y - round(ruin.height / 2), central_turf.z)
	if(!ruin_origin)
		return

	for(var/config in loaded_configs)
		for(var/template in config["templates"])
			var/selected_template = config["templates"][template]
			if(selected_template["required_map"] != required_map)
				continue

			var/list/coordinates = selected_template["coordinates"]
			if(LAZYLEN(coordinates) != 3)
				CRASH("Invalid coordinates for automap template [template]!")

			var/map_file = selected_template["directory"] + pick(selected_template["map_files"])
			if(!fexists(map_file))
				CRASH("[template] could not find map file [map_file]!")

			var/turf/load_turf = locate(ruin_origin.x + coordinates[1] - 1, ruin_origin.y + coordinates[2] - 1, ruin_origin.z + coordinates[3] - 1)
			if(!load_turf)
				CRASH("[template] has invalid coordinates for ruin [required_map]!")

			var/datum/map_template/automap_template/map = new(map_file, template, required_map, load_turf)
			var/list/objects_to_delete = list()
			for(var/turf/affected_turf as anything in map.get_affected_turfs(load_turf, FALSE))
				if(SSautomapper.has_turf_noop(map, affected_turf.x - load_turf.x, affected_turf.y - load_turf.y))
					continue
				affected_turf.lighting_clear_overlay()
				for(var/atom/affected_atom as anything in affected_turf.get_all_contents())
					if(istype(affected_atom, /obj))
						objects_to_delete += affected_atom

			var/previous_initialized_value = SSatoms.initialized
			SSatoms.initialized = INITIALIZATION_INNEW_MAPLOAD
			var/load_result = map.load(load_turf, FALSE)
			SSatoms.initialized = previous_initialized_value
			if(load_result)
				for(var/obj/object_to_delete as anything in objects_to_delete)
					if(QDELETED(object_to_delete))
						continue
					qdel(object_to_delete, TRUE)
				add_startup_message("Loaded [template] for [required_map] at [load_turf.x], [load_turf.y], [load_turf.z]!")
				log_world("AUTOMAPPER: Successfully loaded [template] for [required_map] at [load_turf.x], [load_turf.y], [load_turf.z]!")

/datum/map_template/ruin/load_reserved(turf/central_turf, clear_below)
	. = ..()
	SSautomapper.load_templates_for_ruin(src, central_turf)
