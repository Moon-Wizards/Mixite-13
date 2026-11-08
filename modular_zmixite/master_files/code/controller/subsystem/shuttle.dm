/datum/controller/subsystem/shuttle/proc/revert_autoend()
	emergency_no_recall = FALSE
	endvote_passed = FALSE
	SSevents.can_fire = TRUE
