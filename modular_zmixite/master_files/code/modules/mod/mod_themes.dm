/datum/mod_theme/interdyne
	name = "modified interdyne"
	desc = "A custom-engineered modular suit, found in the hands of bio-terrorists and chemical weapons specialists."
	extended_desc = "A heavily modified older design of the Interdyne Special Rescue Team MODsuit. This one has had modifications applied that are ruled illegal in most sectors.\
	However, calling this an \"improvised\" piece of equipment would be an insult to the manufacturer, it has been very carefully modified, likely using advanced\
	industrial machinery. There are various actuators in the legs, and chemical synthesis units linked directly into the user's bloodstream, constantly dripping a steady\
	supply of muscle stimulants. Some say those wearing these suits have their cruelty from the constant stimulant dosage."
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_deployed = 0
allowed_suit_storage = list(
		/obj/item/assembly/flash,
		/obj/item/healthanalyzer,
		/obj/item/melee/baton,
		/obj/item/melee/baton/telescopic,
		/obj/item/melee/energy/sword,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/restraints/handcuffs,
		/obj/item/sensor_device,
		/obj/item/shield/energy,
		/obj/item/stack/medical,
		/obj/item/storage/bag/bio,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/pill_bottle,
		/obj/item/gun
	)
//Inf-0 Lore and shit was fucked up, consistency type shit, gun added to stowable shits
/datum/mod_theme/interdyne/nerfed
	name = "interdyne SRT"
	desc = "An Interdyne Specialist Rescue Team suit. If you're uninsured, better take a step back. or twelve."
	extended_desc = "The Specialist Rescue Team, or SRT, of the Interdyne Pharmaceutical Corporation, is the company's only private military branch.\
	They are tasked with the retrieval and treatment of high-value clients and executives in life-threatening situations.\
	The people wearing these suits dive boots-first into hell the moment the wrong person's heart stops.\
	However, premium service brings premium costs, only the richest of scumbags can afford it. They are not here for you, they are here for their client. And if you get in their way,\
	They will not hesitate to spread your brain across the steel walls, as every second matters to them."
	armor_type = /datum/armor/mod_theme_interdyne/nerfed
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	complexity_max = 0
	siemens_coefficient = 0
	slowdown_deployed = 0
	inbuilt_modules = list(
		/obj/item/mod/module/quick_carry/advanced,
		/obj/item/mod/module/welding/nosprite/unremovable
		/obj/item/mod/module/defibrillator/unremovable,
		/obj/item/mod/module/injector/unremovable,
		/obj/item/mod/module/surgical_processor/preloaded/unremovable,
		/obj/item/mod/module/storage/large_capacity/unremovable,
		/obj/item/mod/module/tether/unremovable,
		/obj/item/mod/module/rad_protection/unremovable,
		/obj/item/mod/module/thread_ripper/unremovable,
	)
	allowed_suit_storage = list(
		/obj/item/assembly/flash,
		/obj/item/healthanalyzer,
		/obj/item/gun
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/restraints/handcuffs,
		/obj/item/sensor_device,
		/obj/item/shield/energy,
		/obj/item/stack/medical,
		/obj/item/storage/bag/bio,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/pill_bottle,
	)
//Inf-0 Added gun to MOD suitslot-storage options because well, trauma team DOES shoot people if they gotta
/datum/armor/mod_theme_interdyne/nerfed
	melee = 5
	bullet = 5
	laser = 5
	energy = 5
	bomb = 10
	bio = 100
	fire = 100
	acid = 100
	wound = 5
//Inf-0 Before, it had the same armor values as the default medical MOD, which is lowk ass, so i made it fire-and-acidproof, left everything else untouched.
//Inf-0 so still pretty much useless in direct combat :3
