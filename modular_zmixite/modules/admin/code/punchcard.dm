/// A simple-esque punchcard system for round scheduling, mainly for convenience's sake.

SUBSYSTEM_DEF(punchcard_reader)
	name = "Punchcard Reader"
	init_stage = INITSTAGE_LAST
	ss_flags = SS_NO_FIRE | SS_OK_TO_FAIL_INIT

	var/list/clock_info

/datum/controller/subsystem/punchcard_reader/Initialize()
	var/json_file = file("data/punchcard.json")

	if(!fexists(json_file))
		clock_info = list(
			"punched" = FALSE,
			"last_punchin" = null,
			"last_clockout" = null
		)

		text2file(json_encode(clock_info), json_file)
	else
		clock_info = json_decode(file2text(json_file))

	if(!islist(clock_info))
		log_world("Punchcard Reader: Failed to read data/punchcard.json.")
		return SS_INIT_FAILURE

	if(isnull(clock_info["punched"]))
		clock_info["punched"] = FALSE

	if(!("last_punchin" in clock_info))
		clock_info["last_punchin"] = null

	if(!("last_clockout" in clock_info))
		clock_info["last_clockout"] = null

	if(!is_punched())
		set_off_hours_state()
	else
		SSticker.start_immediately = FALSE

	return SS_INIT_SUCCESS


/datum/controller/subsystem/punchcard_reader/proc/is_punched()
	return !!clock_info["punched"]


/datum/controller/subsystem/punchcard_reader/proc/get_last_punchin()
	return clock_info["last_punchin"]


/datum/controller/subsystem/punchcard_reader/proc/get_last_clockout()
	return clock_info["last_clockout"]


/// Puts the server into the off-hours state.
/datum/controller/subsystem/punchcard_reader/proc/set_off_hours_state()
	SSticker.SetTimeLeft(-1)
	SSticker.start_immediately = FALSE

	var/config_server_name = CONFIG_GET(string/servername)
	var/config_server_link = CONFIG_GET(string/discord_link)
	var/server_link_set = config_server_link != "We forgot to set the server's discord link in config.txt" // The default is set wrong but what gives, it's Nova.

	if(!config_server_name)
		config_server_name = "The server"

	SStitle.set_notice("[config_server_name] is off-hours[server_link_set ? ", check the Discord server for a schedule!" : "."]")


/datum/controller/subsystem/punchcard_reader/proc/punch_in()
	if(is_punched())
		return FALSE

	clock_info["punched"] = TRUE
	clock_info["last_punchin"] = world.realtime
	save()

	SStitle.set_notice("The server has been clocked in! Vote for a map!")
	INVOKE_ASYNC(SSvote, TYPE_PROC_REF(/datum/controller/subsystem/vote, initiate_vote), /datum/vote/map_vote, vote_initiator_name = "Map Rotation", forced = TRUE)
	return TRUE


/datum/controller/subsystem/punchcard_reader/proc/punch_out()
	if(!is_punched())
		return FALSE

	clock_info["punched"] = FALSE
	clock_info["last_clockout"] = world.realtime
	save()

	SSvote.reset()
	if(SSticker.current_state <= GAME_STATE_PREGAME)
		set_off_hours_state()
		return TRUE

	var/datum/map_config/minimal_runtime = config.maplist["runtimestation_minimal"]

	if(!minimal_runtime || !SSmap_vote.set_next_map(minimal_runtime))
		log_world("Punchcard Reader: Failed to set Minimal Runtime Station as the next map.")

	send_ooc_announcement("This was the last round for tonight! Next reboot the server will be off-schedule.", "The Punchcard Reader")

	return TRUE


/datum/controller/subsystem/punchcard_reader/proc/save()
	var/json_file = file("data/punchcard.json")

	fdel(json_file)
	text2file(json_encode(clock_info), json_file)


ADMIN_VERB(clockserverin, R_ADMIN, "Punch Server In", "Server up!", ADMIN_CATEGORY_SERVER)
	if(!SSpunchcard_reader.punch_in())
		to_chat(user, span_admin("The server is already punched in!"))
		return

	var/init_by = "Server punch in by [user.holder.fakekey ? "Admin" : user.key]."

	SSticker.Reboot(init_by, "Server clocked in!", 10 MINUTES)
	message_admins("It's okay to reboot the server earlier.")

	log_admin("[key_name(user)] clocked the server in.")
	message_admins("[key_name_admin(user)] clocked the server in.")
	BLACKBOX_LOG_ADMIN_VERB("Punch Server in")


ADMIN_VERB(clockserverout, R_ADMIN, "Clock Server Out", "Server down!", ADMIN_CATEGORY_SERVER)
	if(!SSpunchcard_reader.punch_out())
		to_chat(user, span_admin("The server is already clocked out!"))
		return

	log_admin("[key_name(user)] clocked the server out.")
	message_admins("[key_name_admin(user)] clocked the server out.")
	BLACKBOX_LOG_ADMIN_VERB("Punch Server out")
