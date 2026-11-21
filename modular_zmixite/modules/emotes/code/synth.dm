/datum/emote
	/// Message displayed if the user is a Synthetic Humanoid.  Originally robot+message was just a blanket term for synthetics, cyborgs and pAIs.
	var/message_synthetic = ""

/datum/emote/living/sigh_exasperated
	message_AI = "simulates an exasperated sigh."
	message_robot = "simulates an exasperated sigh."

/datum/emote/living/sigh
	message_AI = "simulates a sigh."
	message_robot = "simulates a sigh."

/datum/emote/living/laugh
	message_AI = "synthesizes a laugh."
	message_robot = "synthesizes a laugh."

/datum/emote/living/chuckle
	message_AI = "synthesizes a chuckle."
	message_robot = "synthesizes a chuckle."

/datum/emote/living/carbon/cry
	message_AI = "makes a crying sound."
	message_robot = "makes a crying sound."

/datum/emote/silicon/sclick
	key = "sclick"
	message = "clicks loudly."
	emote_type = EMOTE_AUDIBLE
	vary = FALSE
	sound = 'modular_zmixite/modules/emotes/sound/synth/click.ogg'
	cooldown = 2 SECONDS

/datum/emote/silicon/notification
	key = "notif"
	message = "pings excitedly!"
	emote_type = EMOTE_AUDIBLE
	vary = FALSE
	sound = 'modular_zmixite/modules/emotes/sound/synth/notif.ogg'
	cooldown = 2 SECONDS

/datum/emote/silicon/dialupmodem
	key = "dialup"
	message = "emits a nostalgic buzz."
	emote_type = EMOTE_AUDIBLE
	vary = FALSE
	sound = 'modular_zmixite/modules/emotes/sound/synth/dialup.ogg'
	cooldown = 2 SECONDS

/datum/emote/silicon/winsound
	key = "victory"
	message = "plays a victorious tune!"
	emote_type = EMOTE_AUDIBLE
	vary = FALSE
	sound = 'modular_zmixite/modules/emotes/sound/synth/victory.ogg'
	cooldown = 2 SECONDS
