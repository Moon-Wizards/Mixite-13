/// How about we show some pride for everyone each time?
/obj/structure/sign/flag/pride
	var/random_basetype
	var/never_random = FALSE

/obj/structure/sign/flag/pride/Initialize(mapload)
	. = ..()
	if(random_basetype)
		randomise(random_basetype)

/obj/structure/sign/flag/pride/proc/randomise(base_type)
	var/list/flag_types = subtypesof(base_type)
	var/list/approved_types = list()
	for(var/obj/structure/sign/flag/pride/type_of_flag as anything in flag_types)
		if(initial(type_of_flag.icon_state) && !initial(type_of_flag.never_random))
			approved_types |= type_of_flag

	var/obj/structure/sign/flag/pride/selected = pick(approved_types)
	name = initial(selected.name)
	desc = initial(selected.desc)
	icon = initial(selected.icon)
	icon_state = initial(selected.icon_state)
	item_flag = initial(selected.item_flag)
	update_appearance()

/obj/structure/sign/flag/pride/random
	name = "random pride flag"
	icon_state = "flag_coder"
	never_random = TRUE
	random_basetype = /obj/structure/sign/flag/pride
