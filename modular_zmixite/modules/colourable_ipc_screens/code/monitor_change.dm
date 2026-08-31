/datum/action/innate/monitor_change/Activate()
	. = ..()

	var/mob/living/carbon/human/human = owner
	var/datum/species/synthetic/synth_species = human?.dna?.species
	if(!istype(synth_species))
		return

	var/obj/item/organ/synth_screen/screen_organ = owner.get_organ_by_type(/obj/item/organ/synth_screen)
	if(!screen_organ)
		return

	var/datum/mutant_bodypart/screen = human.dna.mutant_bodyparts[FEATURE_SYNTH_SCREEN]

	var/new_colour = tgui_color_picker(usr, "Choose the screen colour:", "Screen Colour", screen.get_primary_color())
	if(!new_colour)
		return

	screen.set_primary_color(new_colour)
	human.update_body()
