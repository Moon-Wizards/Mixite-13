// this code is hacky

/datum/round_event/shuttle_loan
	/// Whether the loan shuttle has made its preliminary stop at CentCom.
	var/centcom_visit = FALSE
	/// Whether the preliminary shuttle request has actually started moving.
	var/centcom_trip_started = FALSE
	/// The supply shuttle's normal travel time, restored after the CentCom leg.
	var/centcom_original_call_time

/datum/round_event/shuttle_loan/loan_shuttle()
	if(!centcom_visit)
		centcom_visit = TRUE
		end_when = activeFor + 1

		centcom_original_call_time = SSshuttle.supply.callTime
		SSshuttle.supply.callTime = 1 MINUTES
		SSshuttle.supply.request(SSshuttle.getDock("cargo_centcom"))
		centcom_trip_started = SSshuttle.supply.mode != SHUTTLE_IDLE
		return

	SSshuttle.supply.callTime = centcom_original_call_time
	. = ..()

/datum/round_event/shuttle_loan/tick()
	if(centcom_visit && !dispatched)
		end_when = activeFor + 60 SECONDS
		if(SSshuttle.supply.mode != SHUTTLE_IDLE)
			centcom_trip_started = TRUE
			return

		if(centcom_trip_started || SSshuttle.supply.getDockedId() == "cargo_centcom")
			loan_shuttle()
		else
			SSshuttle.supply.request(SSshuttle.getDock("cargo_centcom"))
		return

	. = ..()
