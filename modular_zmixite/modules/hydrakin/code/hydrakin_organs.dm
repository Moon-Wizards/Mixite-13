/obj/item/organ/eyes/hydrakin
	name = "hydrakin eyes"
	desc = "The unique eyes of the Hydrakin."
	icon = 'modular_zmixite/modules/arachnids/icons/organs.dmi'
	eye_icon = 'modular_zmixite/modules/hydrakin/icons/bodyparts.dmi'
	eye_icon_state = "hydrakineyes"
	icon_state = "arachnid_eyeballs"
	no_glasses = TRUE
	blink_animation = FALSE

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

		//Breath damage
	//These thresholds are checked against what amounts to total_mix_pressure * (gas_type_mols/total_mols)
	safe_oxygen_min = 0 // Minimum safe partial pressure of O2, in kPa
	safe_oxygen_max = 0
	safe_nitro_min = 0
	safe_co2_max = 10 // Yes it's an arbitrary value who cares?
	//safe_plasma_min = 0
	///How much breath partial pressure is a safe amount of plasma. 0 means that we are immune to plasma.
	//safe_plasma_max = 1000
	n2o_detect_min = 1000 //Minimum n2o for effects
	n2o_para_min = 1000 //Sleeping agent
	n2o_sleep_min = 1000 //Sleeping agent
	BZ_trip_balls_min = 1000 //BZ gas
	BZ_brain_damage_min = 1000 //Give people some room to play around without killing the station
	gas_stimulation_min = 1000 // For, Pluoxium, Nitrium and Freon
	///Minimum amount of healium to make you unconscious for 4 seconds
	healium_para_min = 10
	///Minimum amount of healium to knock you down for good
	healium_sleep_min = 20
	///Minimum amount of helium to affect speech
	helium_speech_min = 7
	///Whether these lungs react negatively to miasma
	suffers_miasma = FALSE
	// Vars for N2O/healium induced euphoria, stun, and sleep.
	n2o_euphoria = EUPHORIA_LAST_FLAG
	healium_euphoria = EUPHORIA_LAST_FLAG

	/// All incoming breaths will have their pressure multiplied against this. Higher values allow more air to be breathed at once,
	/// while lower values can cause suffocation in low pressure environments.
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
