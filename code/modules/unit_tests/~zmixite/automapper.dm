/// Checks that all automapper TOML entries actually link to a map and that every config exists.
/datum/unit_test/automapper
	var/list/config_paths = list("_maps/nova/automapper/automapper_config.toml", "_maps/mixite/automapper/automapper_config.toml")

/datum/unit_test/automapper/Run()
	for(var/config_path in config_paths)
		var/test_config = rustg_read_toml_file(config_path)

		if(!test_config)
			TEST_FAIL("Automapper could not read/find TOML config [config_path]!")
			continue

		for(var/template_name in test_config["templates"])
			var/selected_template = test_config["templates"][template_name]
			var/directory = selected_template["directory"]

			for(var/map_file in selected_template["map_files"])
				var/full_path = directory + map_file
				TEST_ASSERT(fexists(full_path), "[template_name] could not find map file [full_path]!")

			for(var/other_template_name in test_config["templates"])
				if(other_template_name == template_name)
					continue
				var/other_template = test_config["templates"][other_template_name]

				TEST_ASSERT_NOTEQUAL(selected_template["coordinates"], other_template["coordinates"], "Automap templates [template_name] and [other_template_name] have the same coordinates!")
				TEST_ASSERT_NOTEQUAL(selected_template["map_files"], other_template["map_files"], "Automap templates [template_name] and [other_template_name] use the same map files!")
