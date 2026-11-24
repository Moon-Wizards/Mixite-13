#define SUBTLE_EMOTE_RANGE 2

/datum/emote/living/custom/subtle
	key = "subtle"
	key_third_person = "subtle"

/datum/emote/living/custom/subtle/run_emote(mob/user, params, type_override = null, intentional = FALSE)
	var/our_message = params ? params : get_custom_emote_from_user()

	if(!our_message || !emote_is_valid(user, our_message))
		return FALSE

	if(!params)
		var/user_emote_type = get_custom_emote_type_from_user()
		if(!user_emote_type)
			return FALSE
		type_override = user_emote_type

	var/running_emote_type = type_override || emote_type
	var/msg = replace_pronoun(user, select_message_type(user, our_message, intentional))
	if(!msg || !length(msg))
		return FALSE

	if(user.client)
		user.log_message(msg, LOG_EMOTE)

	var/is_visible = running_emote_type & EMOTE_VISIBLE
	var/is_audible = running_emote_type & EMOTE_AUDIBLE
	var/space = should_have_space_before_emote(html_decode(msg)[1]) ? " " : ""
	var/message_flags = EMOTE_MESSAGE|ALWAYS_SHOW_SELF_MESSAGE|get_message_flags(intentional)
	var/formatted_msg = "subtly[space][msg]"

	if(is_audible)
		user.audible_message(
			message = formatted_msg,
			deaf_message = is_visible ? span_small(span_emote("You see how <b>[user]</b> [formatted_msg]")) : null,
			hearing_distance = SUBTLE_EMOTE_RANGE,
			self_message = formatted_msg,
			audible_message_flags = message_flags,
			separation = space,
		)
	else if(is_visible)
		user.visible_message(
			message = formatted_msg,
			self_message = formatted_msg,
			vision_distance = SUBTLE_EMOTE_RANGE,
			visible_message_flags = message_flags,
			separation = space,
		)
	else
		CRASH("Subtle emote [type] has no valid emote type set!")

#undef SUBTLE_EMOTE_RANGE
