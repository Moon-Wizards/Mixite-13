// cargos loader MOD was originally a belt-mounted, unsealed specialty suit. And it was dumb as FUCK

/datum/mod_theme/loader
	name = "loader MK2"
	desc = "A sealed, back-mounted cargo MODsuit built for hauling supplies through hostile environments."
	extended_desc = "The Loader MK2 trades the original harness's speed and compactness for a sealed backpack control unit, expanded utility, and dependable EVA operation. \
		Its reinforced frame still provides the strength and powered manipulators expected from a cargo loader, while the larger control unit supports a broader selection of MOD modules."
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = NONE
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	complexity_max = DEFAULT_MAX_COMPLEXITY
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.25
	slowdown_deployed = 0.5
	inbuilt_modules = list(
		/obj/item/mod/module/hydraulic,
		/obj/item/mod/module/clamp/loader,
		/obj/item/mod/module/magnet,
	)

/datum/mod_theme/loader/New()
	. = ..()
	var/list/loader_variant = variants["loader"]
	loader_variant[/obj/item/clothing/head/mod][SEALED_CLOTHING] |= THICKMATERIAL|STOPSPRESSUREDAMAGE|HEADINTERNALS
	loader_variant[/obj/item/clothing/suit/mod][SEALED_CLOTHING] |= STOPSPRESSUREDAMAGE
	loader_variant[/obj/item/clothing/gloves/mod][SEALED_CLOTHING] |= THICKMATERIAL
	loader_variant[/obj/item/clothing/shoes/mod][SEALED_CLOTHING] |= THICKMATERIAL|STOPSPRESSUREDAMAGE

/datum/armor/mod_theme_loader
	melee = 25
	bullet = 5
	laser = 10
	energy = 10
	bomb = 15
	bio = 25
	fire = 50
	acid = 35
	wound = 10

/obj/item/mod/control/pre_equipped/loader
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/stamp,
	)
	default_pins = list(
		/obj/item/mod/module/clamp/loader,
		/obj/item/mod/module/magnet,
		/obj/item/mod/module/hydraulic,
	)

/datum/supply_pack/service/MODsuit_cargo
	name = "Cargo Loader MK2 MODsuit Crate"
	desc = "Contains a single sealed, back-mounted cargo MODsuit with utility modules and powered loading equipment."

/datum/outfit/job/cargo_tech/mod
	back = /obj/item/mod/control/pre_equipped/loader
	belt = null
