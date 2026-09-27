/obj/item/clothing/head/helmet/perceptomatrix
	var/list/additional_clothing_traits = list(
		TRAIT_XRAY_HEARING,
		TRAIT_XRAY_VISION,
	)
/datum/action/cooldown/spell/pointed/percept_hallucination
	var/stagger_duration = 6 SECONDS
/datum/action/cooldown/spell/pointed/percept_hallucination/cast(mob/living/carbon/human/cast_on)
	. = ..()
	cast_on.flash_act(1, TRUE)