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

/obj/item/bodypart/head/robot/cyberkin
	name = "cyberkin head"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_static =  'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon_state = "robotic_head"
	is_dimorphic = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED
	head_flags = HEAD_EYESPRITES | HEAD_EYEHOLES | HEAD_DEBRAIN | HEAD_EYECOLOR | HEAD_HAIR

/obj/item/bodypart/chest/robot/cyberkin
	name = "cyberkin chest"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_static =  'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon_state = "robotic_chest"
	is_dimorphic = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED

/obj/item/bodypart/arm/right/robot/cyberkin
	name = "cyberkin right arm"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_static =  'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon_state = "robotic_r_arm"
	is_dimorphic = FALSE
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	unarmed_attack_verbs_continuous = list("slashed", "scratched", "clawed")
	grappled_attack_verb = "lacerate"
	grappled_attack_verb_continuous = "lacerates"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/arm/left/robot/cyberkin
	name = "cyberkin left arm"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_static =  'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon_state = "robotic_l_arm"
	is_dimorphic = FALSE
	unarmed_attack_verbs = list("slash", "scratch", "claw")
	unarmed_attack_verbs_continuous = list("slashed", "scratched", "clawed")
	grappled_attack_verb = "lacerate"
	grappled_attack_verb_continuous = "lacerates"
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/leg/right/robot/cyberkin
	name = "cyberkin right leg"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_static =  'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon_state = "robotic_r_leg"
	is_dimorphic = FALSE
	bodyshape = BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/leg/left/robot/cyberkin
	name = "cyberkin left leg"
	desc = "A skeletal limb wrapped in pseudomuscles, with a low-conductivity case."
	icon_static =  'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'
	icon_state = "robotic_l_leg"
	is_dimorphic = FALSE
	bodyshape = BODYSHAPE_DIGITIGRADE

/obj/item/bodypart/head/robot/cyberkin/grayscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'

/obj/item/bodypart/chest/robot/cyberkin/grayscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'

/obj/item/bodypart/arm/right/robot/cyberkin/grayscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'

/obj/item/bodypart/arm/left/robot/cyberkin/grayscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'

/obj/item/bodypart/leg/right/robot/cyberkin/grayscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'

/obj/item/bodypart/leg/left/robot/cyberkin/grayscale
	icon_static = null
	should_draw_greyscale = TRUE
	icon_greyscale = 'modular_zmixite/modules/hydrakin/icons/cyberkin.dmi'

//Put the cybers into augment prefs

/datum/augment_item/limb/head/cyberkin
	name = "Cyberkin head"
	path = /obj/item/bodypart/head/robot/cyberkin
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/chest/cyberkin
	name = "Cyberkin chest"
	path = /obj/item/bodypart/chest/robot/cyberkin
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/l_arm/cyberkin
	name = "Cyberkin left arm"
	path = /obj/item/bodypart/arm/left/robot/cyberkin
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/r_arm/cyberkin
	name = "Cyberkin right arm"
	path = /obj/item/bodypart/arm/right/robot/cyberkin
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/l_leg/cyberkin
	name = "Cyberkin left leg"
	path = /obj/item/bodypart/leg/left/robot/cyberkin
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/r_leg/cyberkin
	name = "Cyberkin right leg"
	path = /obj/item/bodypart/leg/right/robot/cyberkin
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/head/cyberkin/grayscale
	name = "Cyberkin head (Grayscale)"
	path = /obj/item/bodypart/head/robot/cyberkin/grayscale
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/chest/cyberkin/grayscale
	name = "Cyberkin chest (Grayscale)"
	path = /obj/item/bodypart/chest/robot/cyberkin/grayscale
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/l_arm/cyberkin/grayscale
	name = "Cyberkin left arm (Grayscale)"
	path = /obj/item/bodypart/arm/left/robot/cyberkin/grayscale
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/r_arm/cyberkin/grayscale
	name = "Cyberkin right arm (Grayscale)"
	path = /obj/item/bodypart/arm/right/robot/cyberkin/grayscale
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/l_leg/cyberkin/grayscale
	name = "Cyberkin left leg (Grayscale)"
	path = /obj/item/bodypart/leg/left/robot/cyberkin/grayscale
	species_whitelist = list(SPECIES_HYDRAKIN = 1)

/datum/augment_item/limb/r_leg/cyberkin/grayscale
	name = "Cyberkin right leg (Grayscale)"
	path = /obj/item/bodypart/leg/right/robot/cyberkin/grayscale
	species_whitelist = list(SPECIES_HYDRAKIN = 1)
