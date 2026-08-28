#define TRANSFORM_TRAITS list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTHEAT, TRAIT_RESISTCOLD, TRAIT_XRAY_HEARING)
#define DESTROYED_MASS_TRAITS list(TRAIT_INCAPACITATED, TRAIT_UI_BLOCKED, TRAIT_IMMOBILIZED)
#define SUIT_TRANSFORMATION_DURATION (1.2 SECONDS)

// Bubber-style "undying" override for Proteans
// Nova's default makes proteans truly DEAD inside the suit (owner.death() -> ghost)
// This keeps the mob alive while brain.dead represents the mass state

// This is mainly because Proteans are allowed to remember what happened to them right up to their death, since they don't really die.
// The counter to that is to put a pen inside the Protean to reset its memory, but in reality the Protean is still alive.

/obj/item/organ/brain/protean/on_life(seconds_per_tick, times_fired)
	. = ..()
	if(dead)
		return

	handle_refactory(owner.get_organ_slot(ORGAN_SLOT_STOMACH))
	handle_orchestrator(owner.get_organ_slot(ORGAN_SLOT_HEART))

	if(owner.stat >= HARD_CRIT)
		alive_retreat()

/obj/item/organ/brain/protean/on_owner_death(mob/living/source, gibbed)
	if(dead)
		return

	// Some things (lava, chasms, etc.) call death() directly and bypass on_life()
	// Let death() finish, then restore the mob before handling the death state
	retreat_timer_id = addtimer(CALLBACK(src, PROC_REF(emergency_retreat)), 0, TIMER_STOPPABLE)


/obj/item/organ/brain/protean/proc/alive_retreat()
	set waitfor = FALSE

	if(dead)
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(owner)
	if(!suit || owner.loc == suit)
		return

	dead = TRUE
	owner.add_traits(DESTROYED_MASS_TRAITS, PROTEAN_TRAIT)

	to_chat(owner, span_red("Your fragile refactory withers away with your mass reduced to scraps. Someone will have to help you."))
	qdel(owner.get_organ_slot(ORGAN_SLOT_STOMACH))

	// The real dead state is brain.dead, not the mob stat
	owner.revive(HEAL_DAMAGE | HEAL_BODY | HEAL_ORGANS, force_grab_ghost = TRUE)
	owner.stat = STABLE

	var/atom/current_loc = owner.loc

	owner.visible_message(span_warning("[owner] retreats into [suit]!"))
	owner.extinguish_mob()
	owner.invisibility = 101

	new /obj/effect/temp_visual/protean_to_suit(current_loc, owner.dir)

	owner.add_traits(TRANSFORM_TRAITS, PROTEAN_TRAIT)
	owner.remove_status_effect(/datum/status_effect/protean_low_power_mode/low_power)

	if(HAS_TRAIT(suit, TRAIT_NODROP))
		REMOVE_TRAIT(suit, TRAIT_NODROP, "protean")

	owner.transferItemToLoc(suit, current_loc, force = TRUE)
	owner.forceMove(suit)

	if(!HAS_TRAIT(owner, TRAIT_DNR) && !HAS_TRAIT(owner, TRAIT_SUICIDED))
		suit.set_distress_signal(TRUE)

	sleep(SUIT_TRANSFORMATION_DURATION)

	owner.invisibility = initial(owner.invisibility)


/obj/item/organ/brain/protean/emergency_retreat()
	set waitfor = FALSE

	if(dead)
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(owner)
	if(!suit || owner.loc == suit)
		return

	if(owner.stat == DEAD)
		owner.revive(HEAL_DAMAGE | HEAL_ORGANS, force_grab_ghost = TRUE)

	alive_retreat()


/obj/item/organ/brain/protean/revive()
	if(!dead)
		return

	dead = FALSE
	owner.remove_traits(DESTROYED_MASS_TRAITS, PROTEAN_TRAIT)

	playsound(owner, 'sound/machines/ping.ogg', 30)
	to_chat(owner, span_warning("You have regained all your mass!"))

	var/obj/item/mod/control/pre_equipped/protean/suit = get_protean_modsuit(owner)
	suit?.set_distress_signal(FALSE)

	owner.revive(HEAL_DAMAGE | HEAL_ORGANS, force_grab_ghost = TRUE)
	owner.stat = STABLE

	if(istype(owner.loc, /obj/item/mod/control/pre_equipped/protean))
		owner.Stun(INFINITY, TRUE)


/obj/item/organ/brain/protean/revive_timer()
	balloon_alert_to_viewers("repairing")

	if(IS_CHANGELING(owner))
		revive_timer_id = addtimer(CALLBACK(src, PROC_REF(revive)), 40 SECONDS, TIMER_STOPPABLE)
	else
		revive_timer_id = addtimer(CALLBACK(src, PROC_REF(revive)), 5 MINUTES, TIMER_STOPPABLE)

#undef TRANSFORM_TRAITS
#undef DESTROYED_MASS_TRAITS
#undef SUIT_TRANSFORMATION_DURATION
