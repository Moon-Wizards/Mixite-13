/obj/item/clothing/head/helmet/perceptomatrix
	stagger_duration = 3 SECONDS
	hallucination_duration = 30 SECONDS
	additional_clothing_traits  += TRAIT_XRAY_HEARING, TRAIT_XRAY_VISION

/datum/action/cooldown/spell/pointed/percept_hallucination/cast(mob/living/carbon/human/cast_on)
	. = ..()
	cast_on.flash_act(1, TRUE)
