GAME_VERB(/mob, subtle_me_verb, "Subtle", null)
	VERB_ARG(message, VERB_ARG_TYPE_TEXT, VERB_ARG_SOURCE_INPUT)

	if(GLOB.say_disabled) //This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))

	QUEUE_OR_CALL_VERB_FOR(VERB_CALLBACK(src, TYPE_PROC_REF(/mob, emote), "subtle", NONE, message, TRUE), SSspeech_controller)
