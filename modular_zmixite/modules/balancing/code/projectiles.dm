#define PROJECTILE_SPEED_MULTIPLIER 2
#define BEAM_SPEED_MULTIPLIER_ADD 0.25

/obj/projectile/fire(fire_angle, atom/direct_target)
	speed *= PROJECTILE_SPEED_MULTIPLIER + (istype(src, /obj/projectile/beam) ? BEAM_SPEED_MULTIPLIER_ADD : 0)
	return ..()

#undef PROJECTILE_SPEED_MULTIPLIER
#undef BEAM_SPEED_MULTIPLIER_ADD
