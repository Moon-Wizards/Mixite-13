/datum/species/hydrakin
	name = "Hydrakin"
	plural_form = "Hydrakin"
	id = SPECIES_HYDRAKIN
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_HYDRAKIN_THERMAL,
		TRAIT_COLD_BLOODED
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID

	sexes = TRUE
	meat = /obj/item/food/meat/slab/spider

	species_language_holder = /datum/language_holder/hydrakin

	mutanttongue = /obj/item/organ/tongue/hydrakin
	mutanteyes = /obj/item/organ/eyes/hydrakin
	mutantlungs = /obj/item/organ/lungs/hydrakin
	mutantliver = /obj/item/organ/liver/hydrakin

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/hydrakin,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/hydrakin,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/hydrakin,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/hydrakin,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/hydrakin,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/hydrakin,
	)

	COOLDOWN_DECLARE(cryo_sleep)

	coldmod = 0.6
	heatmod = 1.2
	bodytemp_normal = 245
	bodytemp_heat_damage_limit = 313
	bodytemp_cold_damage_limit = 50

	var/datum/action/innate/hydrakin_radiate/hydrakin_radiate

/datum/species/hydrakin/randomize_features()
	var/list/features = ..()
	features[FEATURE_MUTANT_COLOR] = "#e9e9e9"
	return features

/datum/scream_type/hydrakin
	name = "Hydrakin Scream"
	scream_sounds = list(
		'modular_zmixite/modules/hydrakin/sounds/hydrakin-scream-1.ogg',
		'modular_zmixite/modules/hydrakin/sounds/hydrakin-scream-2.ogg',
		'modular_zmixite/modules/hydrakin/sounds/hydrakin-scream-3.ogg',
		'modular_zmixite/modules/hydrakin/sounds/hydrakin-scream-4.ogg'
		)

/datum/laugh_type/hydrakin
	name = "Hydrakin Laugh"
	laugh_sounds = list('modular_zmixite/modules/hydrakin/sounds/hydrakin-laugh-1.ogg')

/datum/species/hydrakin/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	RegisterSignal(human_who_gained_species, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	if(ishuman(human_who_gained_species))
		hydrakin_radiate = new
		hydrakin_radiate.Grant(human_who_gained_species)

/datum/species/hydrakin/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load, regenerate_icons)
	. = ..()
	UnregisterSignal(C, COMSIG_LIVING_LIFE)
	if(hydrakin_radiate)
		hydrakin_radiate.Remove(C)

/datum/species/hydrakin/proc/on_life(mob/living/carbon/human/human, seconds_per_tick)
	SIGNAL_HANDLER
	if(human.stat == SOFT_CRIT || human.stat == HARD_CRIT)
		human.adjust_bodytemperature(5)
	human.adjust_bodytemperature(1)

/datum/action/innate/hydrakin_radiate
	name = "Radiate Heat"
	desc = "Actively radiate heat away from your body."
	button_icon = 'modular_zmixite/modules/hydrakin/icons/actions.dmi'
	button_icon_state = "radiate"
	check_flags = AB_CHECK_INCAPACITATED | AB_CHECK_CONSCIOUS
	overlay_icon_state = "bg_alien_border"

/datum/action/innate/hydrakin_radiate/Activate(mob/living/carbon/human/user = usr)
	. = ..()
	if(DOING_INTERACTION(owner, "radiating_heat"))
		return
	if(do_after(user, 2 SECONDS, timed_action_flags = IGNORE_USER_LOC_CHANGE, interaction_key = "radiating_heat"))
		user.adjust_bodytemperature(-1 * (user.bodytemperature / 3))
		user.visible_message(span_notice("[user] begins to radiate heat."))
		var/static/list/hydrakin_flaps = list(
		'modular_zmixite/modules/hydrakin/sounds/hydrakin-flap1.ogg',
		'modular_zmixite/modules/hydrakin/sounds/hydrakin-flap2.ogg',
		)
		playsound(user, pick(hydrakin_flaps), 50)

/datum/species/hydrakin/get_species_description()
	return "Hydrakin are avian creatures with an odd appearance and an extreme tolerance for cold."

/datum/species/hydrakin/get_species_lore()
	return list(
		"Fluffy, exceptionally warm, and notoriously noisy, these birds originate from a desolate iceworld far beyond the normal limits of habitable space. Their home planet is locked in perpetual ice storms, dimly lit, and surrounded by liquid oxygen oceans beneath a freon-heavy atmosphere, once thought entirely lifeless."
	)

/datum/species/hydrakin/prepare_human_for_preview(mob/living/carbon/human/hydrakin)
	hydrakin.set_eye_color("#e9e9e9", "#e9e9e9")
	hydrakin.dna.features[FEATURE_MUTANT_COLOR] = "#a0a0a0"
	regenerate_organs(hydrakin, src, visual_only = TRUE)
	hydrakin.update_body(is_creating = TRUE)

/datum/species/hydrakin/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = FA_ICON_WIND,
			SPECIES_PERK_NAME = "Adaptive Biology",
			SPECIES_PERK_DESC = "Hydrakin have unique lungs adapted to their unusual homeworld, \
			allowing them to breathe (and benefit) from most gasses.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "eye",
			SPECIES_PERK_NAME = "Abnormal Ocular Biology",
			SPECIES_PERK_DESC = "Hydrakin cannot equip any kind of eyewear, requiring \
			alternatives like welding helmets or implants.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "bed",
			SPECIES_PERK_NAME = "Cryogenic",
			SPECIES_PERK_DESC = "Hydrakin are naturally immune to the effects of N2O, however, \
			Cryoxadone will put them to sleep if their body temperature is below freezing.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "Cold Adapted",
			SPECIES_PERK_DESC = "Hydrakin have terrible heat regulation along with being cold-blooded, and must radiate their heat manually. \
			They can just about handle typical station atmosphere, but will have trouble in any insulated wear. \
			Their thermal regulation fails completely when they are critically injured, leading to dangerous temperatures.",
		),
	)

	return to_add

/mob/living/carbon/human/species/hydrakin
	race = /datum/species/hydrakin
