/datum/design/leftarm/New()
	category += list(SPECIES_ARACHNID)
	return ..()

/datum/design/rightarm/New()
	category += list(SPECIES_ARACHNID)
	return ..()

/datum/design/leftleg/New()
	category += list(SPECIES_ARACHNID)
	return ..()

/datum/design/rightleg/New()
	category += list(SPECIES_ARACHNID)
	return ..()

/datum/design/tongue/arachnid
	name = "Arachnid Tongue"
	build_path = /obj/item/organ/tongue/arachnid
	category = list(
		SPECIES_ARACHNID,
	)

/datum/design/liver/arachnid
	name = "Arachnid Liver"
	build_path = /obj/item/organ/liver/arachnid
	category = list(
		SPECIES_ARACHNID,
	)

/datum/design/heart/arachnid
	name = "Arachnid Heart"
	build_path = /obj/item/organ/heart/arachnid
	category = list(
		SPECIES_ARACHNID,
	)

/datum/design/eyes/arachnid
	name = "Arachnid Eyes"
	build_path = /obj/item/organ/eyes/night_vision/arachnid
	category = list(
		SPECIES_ARACHNID,
	)

/datum/design/arachnid_appendages
	name = "Arachnid Appendages"
	build_type = LIMBGROWER
	research_icon = 'modular_zmixite/modules/arachnids/icons/research_icons.dmi'
	research_icon_state = "appendages"
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 20)
	build_path = /obj/item/organ/arachnid_appendages
	category = list(SPECIES_ARACHNID)

/datum/design/arachnid_chelicerae
	name = "Arachnid Chelicerae"
	build_type = LIMBGROWER
	research_icon = 'modular_zmixite/modules/arachnids/icons/research_icons.dmi'
	research_icon_state = "chelicerae"
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 15)
	build_path = /obj/item/organ/arachnid_chelicerae
	category = list(SPECIES_ARACHNID)

/datum/design/arachnid_silkgland
	name = "Arachnid Silk Gland"
	build_type = LIMBGROWER
	research_icon = 'modular_zmixite/modules/arachnids/icons/research_icons.dmi'
	research_icon_state = "silkgland"
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 15)
	build_path = /obj/item/organ/silkgland
	category = list(SPECIES_ARACHNID)

/obj/item/disk/design_disk/limbs/arachnid
	name = "Arachnid Organ Design Disk"
	blueprints = list(/datum/design/liver/arachnid, /datum/design/heart/arachnid, /datum/design/tongue/arachnid, /datum/design/eyes/arachnid, /datum/design/arachnid_silkgland, /datum/design/arachnid_appendages, /datum/design/arachnid_chelicerae)

/datum/design/limb_disk/arachnid
	name = "Arachnid Organ Design Disk"
	desc = "Contains designs for arachnid organs for the limbgrower - Arachnid heart, liver, tongue, silk gland, appendages, chelicerae and eyes."
	build_path = /obj/item/disk/design_disk/limbs/arachnid

/datum/design/leftarm/New()
	category += list(SPECIES_HYDRAKIN)
	return ..()

/datum/design/rightarm/New()
	category += list(SPECIES_HYDRAKIN)
	return ..()

/datum/design/leftleg/New()
	category += list(SPECIES_HYDRAKIN)
	return ..()

/datum/design/rightleg/New()
	category += list(SPECIES_HYDRAKIN)
	return ..()

/datum/design/tongue/hydrakin
	name = "Hydrakin Tongue"
	build_path = /obj/item/organ/tongue/hydrakin
	category = list(
		SPECIES_HYDRAKIN,
	)

/datum/design/lungs/hydrakin
	name = "Hydrakin Lungs"
	build_path = /obj/item/organ/lungs/hydrakin
	category = list(
		SPECIES_HYDRAKIN,
	)

/datum/design/liver/hydrakin
	name = "Hydrakin Liver"
	build_path = /obj/item/organ/liver/hydrakin
	category = list(
		SPECIES_HYDRAKIN,
	)

/datum/design/eyes/hydrakin
	name = "Hydrakin Eyes"
	build_path = /obj/item/organ/eyes/hydrakin
	category = list(
		SPECIES_HYDRAKIN,
	)

/obj/item/disk/design_disk/limbs/hydrakin
	name = "Hydrakin Organ Design Disk"
	blueprints = list(/datum/design/liver/hydrakin, /datum/design/lungs/hydrakin, /datum/design/tongue/hydrakin, /datum/design/eyes/hydrakin)

/datum/design/limb_disk/hydrakin
	name = "Hydrakin Organ Design Disk"
	desc = "Contains designs for hydrakin organs for the limbgrower - Hydrakin liver, lungs, tongue, and eyes."
	build_path = /obj/item/disk/design_disk/limbs/arachnid
