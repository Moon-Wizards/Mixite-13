/// Meant for "shared" areas between the fractions, like the ATS and whatnot, extend in modules.
/area/shared
	name = "Shared Areas"
	icon = 'modular_zmixite/master_files/icons/area/areas_shared.dmi'
	icon_state = "unknown"
	area_flags = NOTELEPORT | LOCAL_TELEPORT
	default_gravity = STANDARD_GRAVITY
	requires_power = TRUE

	ambience_index = AMBIENCE_GENERIC
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/shared/solars
	icon = 'icons/area/areas_station.dmi'
	icon_state = "panels"
	area_flags = NO_GRAVITY
	flags_1 = NONE
	default_gravity = ZERO_GRAVITY
	requires_power = FALSE
	outdoors = TRUE

	ambience_index = AMBIENCE_SPOOKY
	sound_environment = SOUND_AREA_SPACE
