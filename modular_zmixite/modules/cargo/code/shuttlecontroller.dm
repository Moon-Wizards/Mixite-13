#define SAFETY_WARNING "For safety and ethical reasons, the automated supply shuttle cannot transport non supply crew, \
	human remains, classified nuclear weaponry, mail, undelivered departmental order crates, syndicate bombs, \
	homing beacons, unstable eigenstates, or machinery housing any form of artificial intelligence."

/datum/computer_file/program/budgetorders
	safety_warning = SAFETY_WARNING

/obj/machinery/computer/cargo
	safety_warning = SAFETY_WARNING

/obj/machinery/shuttle_controller
	name = "\improper shuttle controller"
	desc = "Simple panel that allows you control the supply shuttle it's attached to."
	desc_controls = "Left click to send the shuttle between the docks."
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "tram"
	base_icon_state = "tram"
	density = FALSE
	use_power = IDLE_POWER_USE
	power_channel = AREA_USAGE_EQUIP
	req_one_access = list(ACCESS_CARGO)
	resistance_flags = INDESTRUCTIBLE // I doubt it's a good idea to make them craftable.
	processing_flags = NONE

	pixel_y = 0

	light_color = COLOR_BRIGHT_BLUE

	var/safety_warning = SAFETY_WARNING
	var/blockade_warning = "Bluespace instability detected. Shuttle movement impossible."

	///The name of the shuttle template being used as the cargo shuttle. 'cargo' is default and contains critical code. Don't change this unless you know what you're doing.
	var/cargo_shuttle = "cargo"
	///The docking port called when returning to the station.
	var/docking_home = "cargo_home"
	///The docking port called when leaving the station.
	var/docking_away = "cargo_away"

/obj/machinery/shuttle_controller/update_icon_state()
	. = ..()

	icon_state = "[base_icon_state]"
	if(machine_stat & (NOPOWER|BROKEN))
		icon_state += "-nopower"

/obj/machinery/shuttle_controller/update_overlays()
	. = ..()

	if(SSshuttle.supply_blocked)
		. += "[base_icon_state]-overlay-error"

	if(!(machine_stat & (NOPOWER|BROKEN)) && !panel_open)
		. += emissive_appearance(icon, "[base_icon_state]-light-mask", src, alpha = src.alpha)

/obj/machinery/shuttle_controller/update_appearance()
	. = ..()

	if(panel_open || (machine_stat & (NOPOWER|BROKEN)))
		set_light(0)
	else
		set_light(initial(light_range), light_power, light_color)

/obj/machinery/shuttle_controller/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	playsound(src, 'sound/machines/click.ogg', 60, TRUE)

	if(SSshuttle.supply.mode != SHUTTLE_IDLE)
		return
	if(!SSshuttle.supply.canMove())
		say(safety_warning)
		return
	if(SSshuttle.supply_blocked)
		say(blockade_warning)
		return

	if(SSshuttle.supply.getDockedId() == docking_home)
		user.investigate_log("sent the supply shuttle away.", INVESTIGATE_CARGO)
		SSshuttle.moveShuttle(cargo_shuttle, docking_away, TRUE)
	else
		user.investigate_log("called the supply shuttle.", INVESTIGATE_CARGO)
		SSshuttle.moveShuttle(cargo_shuttle, docking_home, TRUE)

	say("The supply shuttle is departing.")

/obj/machinery/shuttle_controller/examine(mob/user)
	. = ..()
	var/obj/docking_port/stationary/dock = SSshuttle.supply.get_docked()

	if(SSshuttle.supply.mode == SHUTTLE_IDLE)
		. += span_notice("It reports that the supply shuttle is docked at \the [dock.name].")
	else
		. += span_notice("It reports that the supply shuttle is currently in transit.")


#undef SAFETY_WARNING
