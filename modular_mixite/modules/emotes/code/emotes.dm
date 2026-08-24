/datum/emote/living/tail_thump
	key = "tailthump"
	key_third_person = "tailthumps"
	message = "thumps their tail!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_mixite/modules/emotes/sound/tailthump.ogg' // See https://github.com/shiptest-ss13/Shiptest/pull/2159

/datum/emote/living/tail_thump/can_run_emote(mob/user, status_check, intentional, params)
	var/obj/item/organ/tail/tail = user.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(isnull(tail))
		return FALSE
	return ..()


/datum/emote/living/squeal
	key = "squeal"
	key_third_person = "squeals"
	message = "squeals!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_mixite/modules/emotes/sound/squeal.ogg' // See https://github.com/shiptest-ss13/Shiptest/pull/2159
