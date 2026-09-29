/datum/looping_sound/tectonic_resonator
	start_volume = 20
	start_sound = 'modular_zmixite/modules/big_drill_engine/sounds/button_up.ogg'
	start_length = 0.3 SECONDS
	mid_sounds = list(
		'modular_zmixite/modules/big_drill_engine/sounds/pump_loop.ogg'
	)
	mid_length = 9.5 SECONDS
	end_sound = 'modular_zmixite/modules/big_drill_engine/sounds/button_down.ogg'
	end_volume = 20
	extra_range = 7
	vary = FALSE
	volume = 70
	falloff_distance = 8
	falloff_exponent = 20
	use_sound_tokens = TRUE


/obj/machinery/tectonic_resonator
	name = "T.R. Series P.I.E."
	desc = "BIG DRILL"
	icon = 'modular_zmixite/modules/big_drill_engine/icons/engine/engine.dmi'
	density = TRUE
	move_resist = INFINITY
	use_power = NO_POWER_USE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/sprite_number = 0

/obj/machinery/tectonic_resonator/safe_throw_at(atom/target, range, speed, mob/thrower, spin = TRUE, diagonals_first = FALSE, datum/callback/callback, force = MOVE_FORCE_STRONG, gentle = FALSE)
	return FALSE

/obj/machinery/tectonic_resonator/proc/get_status()
	return "off"

/obj/machinery/tectonic_resonator/update_icon_state()
	icon_state = "[get_status()]_[sprite_number]"
	return ..()

/obj/machinery/tectonic_resonator/part
	var/obj/machinery/tectonic_resonator/main/main_part

/obj/machinery/tectonic_resonator/part/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!main_part)
		return NONE
	return main_part.item_interaction(user, tool)

/obj/machinery/tectonic_resonator/part/get_status()
	if(!main_part)
		return
	return main_part.get_status()

/// Used to eat args
/obj/machinery/tectonic_resonator/part/proc/on_update_icon(obj/machinery/tectonic_resonator/source, updates, updated)
	SIGNAL_HANDLER
	return update_appearance(updates)

/obj/machinery/tectonic_resonator/main
	icon_state = "off_16"
	sprite_number = 16

	var/list/generator_parts = list()
	var/on = FALSE
	var/breaker = FALSE
	var/depletion = 0
	var/pipe_count = 0
	var/extract_rate = 0
	var/is_drilling = FALSE

	var/datum/looping_sound/tectonic_resonator/soundloop

/obj/machinery/tectonic_resonator/main/get_status()
	if(on)
		return "on"
	else
		return "off"

/obj/machinery/tectonic_resonator/main/Initialize(mapload)
	. = ..()
	soundloop = new(src, start_immediately = FALSE)
	setup_parts()
	//if(on)
	//	enable()


/obj/machinery/tectonic_resonator/main/proc/setup_parts()
	var/turf/our_turf = get_turf(src)

	var/list/spawn_turfs = CORNER_BLOCK_OFFSET(our_turf, 4, 4, 0, 0)
	var/count = 17
	for(var/turf/T in spawn_turfs)
		count--
		if(T == our_turf) // Skip our turf.
			continue
		var/obj/machinery/tectonic_resonator/part/part = new(T)
		part.sprite_number = count
		part.main_part = src
		generator_parts += part
		part.update_appearance()
		part.RegisterSignal(src, COMSIG_ATOM_UPDATED_ICON, TYPE_PROC_REF(/obj/machinery/tectonic_resonator/part, on_update_icon))

/obj/machinery/tectonic_resonator/main/proc/enable()
	soundloop.start()

/obj/machinery/tectonic_resonator/main/proc/disable()
	soundloop.stop()

/obj/machinery/tectonic_resonator/main/proc/toggle_drilling()
	var/new_state = FALSE
	if(on)
		new_state = FALSE
	else
		new_state = TRUE

	on = new_state
	update_appearance()

	if(on)
		enable()
	else
		disable()


/obj/machinery/tectonic_resonator/main/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TectonicResonator", name)
		ui.open()

/obj/machinery/tectonic_resonator/main/ui_data(mob/user)
	var/list/data = list()

	data["depletion"] = depletion
	data["pipe_count"] = pipe_count
	data["extract_rate"] = extract_rate
	data["on"] = on
	data["is_drilling"] = is_drilling

	return data

/obj/machinery/tectonic_resonator/main/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle_drilling")
			breaker = !breaker
			investigate_log("was toggled [breaker ? "<font color='green'>ON</font>" : "<font color='red'>OFF</font>"] by [key_name(usr)].", INVESTIGATE_ENGINE)
			toggle_drilling()
			. = TRUE
