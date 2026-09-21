/obj/item/bodypart/head/hydrakin
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/bodyparts.dmi'
	limb_id = SPECIES_HYDRAKIN
	is_dimorphic = FALSE
	head_flags = HEAD_EYESPRITES | HEAD_EYEHOLES | HEAD_DEBRAIN | HEAD_EYECOLOR | HEAD_HAIR
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED

/obj/item/bodypart/chest/hydrakin
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/bodyparts.dmi'
	limb_id = SPECIES_HYDRAKIN
	is_dimorphic = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED

/obj/item/bodypart/arm/left/hydrakin
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/bodyparts.dmi'
	limb_id = SPECIES_HYDRAKIN
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	unarmed_attack_verbs_continuous = list("slashed", "scratched", "clawed")
	grappled_attack_verb = "lacerate"
	grappled_attack_verb_continuous = "lacerates"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
	is_dimorphic = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED

/obj/item/bodypart/arm/right/hydrakin
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/bodyparts.dmi'
	limb_id = SPECIES_HYDRAKIN
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	unarmed_attack_verbs_continuous = list("slashed", "scratched", "clawed")
	grappled_attack_verb = "lacerate"
	grappled_attack_verb_continuous = "lacerates"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
	is_dimorphic = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED

/obj/item/bodypart/leg/left/digitigrade/hydrakin
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/bodyparts.dmi'
	limb_id = SPECIES_HYDRAKIN
	is_dimorphic = FALSE
	bodyshape = BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/right/digitigrade/hydrakin
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/bodyparts.dmi'
	limb_id = SPECIES_HYDRAKIN
	is_dimorphic = FALSE
	bodyshape = BODYSHAPE_DIGITIGRADE
