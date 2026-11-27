/obj/item/crowbar/gordon
	name = "gordon's crowbar"
	desc = "About that beer I owed ya."

	color = "#ff0000"

/obj/item/crowbar/gordon/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!isliving(target_mob))
		return ..()

	user.visible_message(
		span_danger("[user] brutally obliterates [target_mob]!"),
		span_userdanger("You brutally obliterate [target_mob]!")
	)

	target_mob.gib()
