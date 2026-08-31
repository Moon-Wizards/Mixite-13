/obj/item/organ/wings
	/// Stamina damage taken per second while actively flying.
	var/stamina_drain = 5

/obj/item/organ/wings/on_life(seconds_per_tick)
	. = ..()
	if(handle_flight(owner))
		owner.adjust_stamina_loss(stamina_drain * seconds_per_tick)
