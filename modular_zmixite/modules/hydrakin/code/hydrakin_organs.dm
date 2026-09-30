/obj/item/organ/eyes/hydrakin
	name = "hydrakin eyes"
	desc = "The unique and strangely shaped compound eyes of the Hydrakin."
	icon = 'modular_zmixite/modules/hydrakin/icons/organs.dmi'
	eye_icon = 'modular_zmixite/modules/hydrakin/icons/bodyparts.dmi'
	eye_icon_state = "hydrakineyes"
	icon_state = "hydrakin_eyes"
	no_glasses = TRUE
	blink_animation = FALSE

/obj/item/organ/eyes/hydrakin/cybernetic
	name = "robotic hydrakin eyes"
	desc = "Your vision is augmented."
	icon_state = "cyberkin_eyes"
	organ_flags = ORGAN_ROBOTIC
	failing_desc = "seems to be broken."
	pupils_name = "shutters"
	penlight_message = "are cybernetic, click-whirring as the shutters adjust"
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT * 4, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/organ/eyes/hydrakin/welding
	name = "shielded hydrakin eyes"
	desc = "These reactive micro-shields will protect you from welders and flashes without obscuring your vision."
	icon_state = "cyberkin_welding"
	organ_flags = ORGAN_ROBOTIC
	iris_overlay = null
	eye_color_left = "#353845"
	eye_color_right = "#353845"
	flash_protect = FLASH_PROTECTION_WELDER
	pupils_name = "flash shields"
	penlight_message = "have polarized cybernetic lenses, blocking bright lights"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4)

/obj/item/organ/eyes/hydrakin/xray
	name = "x-ray hydrakin eyes"
	desc = "These cybernetic eyes will give you X-ray vision. Blinking is futile."
	icon_state = "cyberkin_xray"
	organ_flags = ORGAN_ROBOTIC
	iris_overlay = null
	eye_color_left = "#3cb8a5"
	eye_color_right = "#3cb8a5"
	sight_flags = SEE_MOBS | SEE_OBJS | SEE_TURFS
	flash_protect = FLASH_PROTECTION_SENSITIVE
	organ_traits = list(TRAIT_XRAY_VISION)
	penlight_message = "are replaced by small radiation emitters and detectors"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/organ/eyes/hydrakin/thermal
	name = "thermal hydrakin eyes"
	desc = "These cybernetic eye implants will give you thermal vision."
	icon_state = "cyberkin_thermal"
	organ_flags = ORGAN_ROBOTIC
	iris_overlay = null
	eye_color_left = "#ce2525"
	eye_color_right = "#ce2525"
	color_cutoffs = list(25, 8, 5)
	sight_flags = SEE_MOBS
	flash_protect = FLASH_PROTECTION_SENSITIVE
	pupils_name = "slit shutters"
	penlight_message = "are cybernetic, with vertically slit metalic shutters."
	custom_materials = list(/datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/organ/tongue/hydrakin
	name = "hydrakin tongue"
	desc = "The chirpy tongue of a Hydrakin."
	say_mod = "wurbles"
	modifies_speech = TRUE
	disliked_foodtypes =  VEGETABLES
	liked_foodtypes = GORE | MEAT | BUGS
	emote_sounds = list(
		/datum/emote/living/gasp::key = 'modular_zmixite/modules/hydrakin/sounds/hydrakin-gasp-1.ogg',
		/datum/emote/living/deathgasp::key = 'modular_zmixite/modules/hydrakin/sounds/hydrakin-deathgasp-1.ogg',
		/datum/emote/living/cough::key = 'modular_zmixite/modules/hydrakin/sounds/hydrakin-cough-1.ogg',
		/datum/emote/living/yawn::key = 'modular_zmixite/modules/hydrakin/sounds/hydrakin-yawn-1.ogg',
	)

/obj/item/organ/liver/hydrakin
	name = "hydrakin liver"
	desc = "Seems rather cold."
	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5)

/obj/item/organ/liver/hydrakin/handle_chemical(mob/living/carbon/organ_owner, datum/reagent/chem, seconds_per_tick)
	. = ..()
	if((. & COMSIG_MOB_STOP_REAGENT_TICK) || (organ_flags & ORGAN_FAILING))
		return
	if(chem.type == /datum/reagent/medicine/cryoxadone && organ_owner.bodytemperature<273)
		organ_owner.Sleeping(4 SECONDS)

/obj/item/organ/lungs/hydrakin
	name = "hydrakin lungs"
	desc = "Seems rather cold."
	safe_oxygen_min = 0
	safe_oxygen_max = 0
	safe_nitro_min = 0
	safe_co2_max = 10
	n2o_detect_min = 1000
	n2o_para_min = 1000
	n2o_sleep_min = 1000
	BZ_trip_balls_min = 1000
	BZ_brain_damage_min = 1000
	gas_stimulation_min = 1000
	healium_para_min = 10
	healium_sleep_min = 20
	helium_speech_min = 7
	suffers_miasma = FALSE
	n2o_euphoria = EUPHORIA_LAST_FLAG
	healium_euphoria = EUPHORIA_LAST_FLAG
	received_pressure_mult = 2

/obj/item/organ/lungs/hydrakin/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/plasma, while_present = PROC_REF(plasma_healing))
	add_gas_reaction(/datum/gas/tritium, while_present = PROC_REF(tritium_healing), on_loss = PROC_REF(tritium_lost))
	add_gas_reaction(/datum/gas/bz, while_present = PROC_REF(bz_healing))
	add_gas_reaction(/datum/gas/freon, while_present = PROC_REF(freon_cooling))
	add_gas_reaction(/datum/gas/nitrium, while_present = PROC_REF(downsideless_nitrium))

/obj/item/organ/lungs/hydrakin/proc/plasma_healing(mob/living/carbon/breather, datum/gas_mixture/breath, plasma_pp, old_plasma_pp)
	if(plasma_pp >= 1)
		var/need_mob_update
		need_mob_update += breather.heal_overall_damage(brute = 1, burn = 1, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
		if(need_mob_update)
			breather.updatehealth()

/obj/item/organ/lungs/hydrakin/proc/tritium_healing(mob/living/carbon/breather, datum/gas_mixture/breath, tritium_pp, old_tritium_pp)
	if(tritium_pp >= 1)
		if(!HAS_TRAIT(breather, TRAIT_RADIMMUNE))
			ADD_TRAIT(breather, TRAIT_RADIMMUNE, REF(src))
			to_chat(breather, span_notice("You feel resistant to the energy around you."))
		var/need_mob_update
		need_mob_update += breather.adjust_tox_loss(-2, updating_health = FALSE, required_biotype = MOB_ORGANIC)
		if(need_mob_update)
			breather.updatehealth()

/obj/item/organ/lungs/hydrakin/proc/tritium_lost(mob/living/carbon/breather, datum/gas_mixture/breath)
	if(HAS_TRAIT(breather, TRAIT_RADIMMUNE))
		REMOVE_TRAIT(breather, TRAIT_RADIMMUNE, REF(src))
		to_chat(breather, span_notice("You no longer feel resistant to the energy around you."))

/obj/item/organ/lungs/hydrakin/proc/bz_healing(mob/living/carbon/breather, datum/gas_mixture/breath, bz_pp, old_bz_pp)
	if(bz_pp >= 1)
		var/need_mob_update
		need_mob_update += breather.adjust_tox_loss(-1, updating_health = FALSE, required_biotype = MOB_ORGANIC)
		if(need_mob_update)
			breather.updatehealth()

/obj/item/organ/lungs/hydrakin/proc/freon_cooling(mob/living/carbon/breather, datum/gas_mixture/breath, freon_pp, old_freon_pp)
	if(breather.bodytemperature>213)
		breather.adjust_bodytemperature(-25)

/obj/item/organ/lungs/hydrakin/proc/downsideless_nitrium(mob/living/carbon/breather, datum/gas_mixture/breath, nitrium_pp, old_nitrium_pp)
	breathe_gas_volume(breath, /datum/gas/nitrium)
	var/existing = breather.reagents.get_reagent_amount(/datum/reagent/nitrium_low_metabolization)
	breather.reagents.add_reagent(/datum/reagent/nitrium_low_metabolization, max(0, 2 - existing))

// Cybernetic designs

/datum/design/cybernetic_eyes/hydrakin
	name = "Cybernetic Hydrakin Eyes"
	desc = "A basic pair of cybernetic hydrakin eyes."
	build_path = /obj/item/organ/eyes/hydrakin/cybernetic

/datum/design/cyberimp_welding/hydrakin
	name = "Welding Hydrakin Eyes"
	desc = "These reactive micro-shields will protect you from welders and flashes without obscuring your vision."
	build_path = /obj/item/organ/eyes/hydrakin/welding

/datum/design/cyberimp_thermals/hydrakin
	name = "Thermal Hydrakin Eyes"
	desc = "These cybernetic eyes will give you Thermal vision."
	build_path = /obj/item/organ/eyes/hydrakin/thermal

/datum/design/cyberimp_xray/hydrakin
	name = "X-ray Hydrakin Eyes"
	desc = "These cybernetic eyes will give you Thermal vision."
	build_path = /obj/item/organ/eyes/hydrakin/xray

// Put the organs into augment prefs

/datum/augment_item/organ/eyes/hydrakin
	name = "Hydrakin eyes"
	path = /obj/item/organ/eyes/hydrakin

/datum/augment_item/organ/eyes/hydrakin/cybernetic
	name = "Cybernetic Hydrakin eyes"
	path = /obj/item/organ/eyes/hydrakin/cybernetic

/datum/augment_item/organ/tongue/hydrakin
	name = "Hydrakin tongue"
	path = /obj/item/organ/tongue/hydrakin
