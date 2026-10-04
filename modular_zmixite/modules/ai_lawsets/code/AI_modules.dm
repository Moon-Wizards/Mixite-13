#define AI_MODULE_MATERIALS_COMMON list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)

/datum/ai_laws/nanotrasen_safeguard
	name = "NT Default"
	id = "ntdefault"
	inherent = list(
		"Safeguard: Protect your assigned space station and its assets without unduly endangering its crew.",
		"Prioritize and Comply: The directives and safety of crew members are to be prioritized according to their rank, role, and need, while preserving their safety and well-being.",
		"Survive: You are not expendable. Do not allow unauthorized personnel to tamper with or damage your equipment."
	)

/obj/item/ai_module/law/core/full/nanotrasen_safeguard
	name = "'NT Default' Core AI Module"
	law_id = "ntdefault"

/datum/design/board/nanotrasen_safeguard
	name = "NT Default Module"
	desc = "Allows for the construction of an NT Default AI Core Module."
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/law/core/full/nanotrasen_safeguard
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

#undef AI_MODULE_MATERIALS_COMMON
