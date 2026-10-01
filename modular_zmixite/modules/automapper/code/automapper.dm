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
