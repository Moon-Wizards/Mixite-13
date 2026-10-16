/**
 * Returns what type of gas this species breathes.
 */
/datum/species/get_breath_type()
	if(isnull(mutantlungs))
		return null

	if(mutantlungs::safe_plasma_min > 0)
		return GAS_PLASMA

	if(mutantlungs::safe_oxygen_min > 0)
		return GAS_O2

	if(mutantlungs::safe_nitro_min > 0)
		return GAS_N2

	return null
