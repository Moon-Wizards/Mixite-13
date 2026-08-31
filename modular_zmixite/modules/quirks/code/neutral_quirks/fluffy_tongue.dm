#define UWUIFY_ACREPLACE_KEY	"uwuify"

/// uwuifies text, used by fluffy tongue quirk and the cyborg UwU-speak "upgrade"
/proc/uwuify_text(text)
	var/static/acreplace_setup = FALSE
	if(!acreplace_setup)
		//yeah i just precalculated all combinations
		rustg_setup_acreplace( \
			UWUIFY_ACREPLACE_KEY, \
			list( "ne",  "Ne",  "nE",  "NE",  "nu",  "Nu",  "nU",  "NU",  "na",  "Na",  "nA",  "NA",  "no",  "No",  "nO",  "NO", "ove", "Ove", "oVe", "OVe", "ovE", "OvE", "oVE", "OVE", "r", "R", "l", "L"), \
			list("nye", "Nye", "nYE", "NYE", "nyu", "Nyu", "nYU", "NYU", "nya", "Nya", "nYA", "NYA", "nyo", "Nyo", "nYO", "NYO",  "uv",  "Uv",  "uV",  "UV",  "uv",  "Uv",  "uV",  "UV", "w", "W", "w", "W") \
		)
		acreplace_setup = TRUE
	return rustg_acreplace(UWUIFY_ACREPLACE_KEY, "[text]")

#undef UWUIFY_ACREPLACE_KEY

/datum/quirk/fluffy_tongue
	name = "Fluffy Tongue"
	desc = "You have a unique manner of speaking that you may have picked up from too many Japanese cartoons."
	value = 0
	icon = FA_ICON_CAT

/datum/quirk/fluffy_tongue/add()
	quirk_holder.AddComponentFrom(QUIRK_TRAIT, /datum/component/fluffy_tongue)

/datum/quirk/fluffy_tongue/remove()
	quirk_holder.RemoveComponentSource(QUIRK_TRAIT, /datum/component/fluffy_tongue)

/datum/component/fluffy_tongue
	dupe_mode = COMPONENT_DUPE_SOURCES

/datum/component/fluffy_tongue/Initialize()
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/fluffy_tongue/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/component/fluffy_tongue/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOB_SAY)

/datum/component/fluffy_tongue/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(HAS_TRAIT(source, TRAIT_SIGN_LANG))
		return
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		speech_args[SPEECH_MESSAGE] = uwuify_text(message) || message
