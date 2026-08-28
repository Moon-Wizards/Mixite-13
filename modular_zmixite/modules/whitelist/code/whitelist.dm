// our whitelist needs to be dynamic so reload it before on check, people don't spam rejoin n' shit so it shouldn't be an issue.

/world/IsBanned(key, address, computer_id, type, real_bans_only=FALSE)
	load_whitelist()
	. = ..()
