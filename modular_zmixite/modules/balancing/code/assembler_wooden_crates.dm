/datum/crafting_recipe/wooden_crate
	name = "Wooden Crate"
	result = /obj/structure/closet/crate/wooden
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 6,
	)
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF
	time = 5 SECONDS
	category = CAT_CONTAINERS
