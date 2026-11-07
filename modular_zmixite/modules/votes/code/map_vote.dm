/datum/vote/map_vote
	count_method = VOTE_COUNT_METHOD_SINGLE
	winner_method = VOTE_WINNER_METHOD_SIMPLE
	display_statistics = TRUE

/datum/controller/subsystem/map_vote/finalize_map_vote(datum/vote/map_vote/map_vote)
	if(already_voted)
		message_admins("Attempted to finalize a map vote after a map vote has already been finalized.")
		return
	already_voted = TRUE

	if(admin_override)
		send_map_vote_notice("Override set! Map will not be changed.")
		return

	var/list/winners = list()
	var/highest_votes = 0
	for(var/map_id in map_vote.choices)
		var/votes = map_vote.choices[map_id]
		if(votes > highest_votes)
			highest_votes = votes
			winners = list(map_id)
		else if(votes == highest_votes)
			winners += map_id

	var/winner = pick(winners)
	ASSERT(winner, "No winner found in map vote.")
	set_next_map(config.maplist[winner])

	var/list/messages = list("Map Selected - [span_bold(next_map_config.map_name)]")
	if(!highest_votes)
		messages += "No votes were cast, so a map was chosen at random."
	send_map_vote_notice(arglist(messages))

/datum/controller/subsystem/map_vote/update_tally_printout()
	return ""
