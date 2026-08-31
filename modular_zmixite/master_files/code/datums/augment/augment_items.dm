/datum/augment_item/organ/eyes/apply(mob/living/carbon/human/human_holder, character_setup = FALSE, datum/preferences/prefs)
	if(character_setup && !is_visible)
		return

	var/obj/item/organ/organ_path = path // cast this to an organ so we can get the slot from it using initial()
	var/obj/item/organ/new_organ = new path()
	new_organ.copy_traits_from(human_holder.get_organ_slot(initial(organ_path.slot)), FALSE)
	new_organ.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)
