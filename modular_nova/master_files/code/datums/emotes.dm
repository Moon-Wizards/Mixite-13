/datum/emote
	manual_specific_emote_audio_cooldown = 0 SECONDS // The 2 second global emote cooldown is sufficient in most cases. Specific emote cooldowns can be applied on a per-emote basis on top of that.
	sound_volume = 25 // NOVA EDIT CHANGE - ORIGINAL: var/sound_volume = 25 - now declared upstream on /datum/emote itself
	/// What species can use this emote?
	var/list/allowed_species
	var/pref_to_check

/datum/emote/proc/check_config()
	return TRUE

// Can we play this emote to viewers?
/datum/emote/proc/pref_check_emote(mob/user, client/client, preference)
	. = TRUE
	if(isnull(pref_to_check) && isnull(preference))
		return

	var/client/user_client = client || user.client
	if(user_client && !user_client.prefs.read_preference(pref_to_check || preference))
		return FALSE
