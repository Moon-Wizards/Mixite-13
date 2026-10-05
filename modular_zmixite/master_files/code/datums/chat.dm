/datum/asset/spritesheet_batched/chat/create_spritesheets()
	..()

	var/datum/universal_icon/icon = uni_icon('modular_zmixite/master_files/icons/chat_donator.dmi', "mixite_logo")
	icon.scale(16, 16)
	insert_icon("nova_donator", icon)
