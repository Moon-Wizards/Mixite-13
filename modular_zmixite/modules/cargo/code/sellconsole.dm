/obj/item/circuitboard/computer/cargo_seller
	name = "Supply Selling Console"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/cargo_seller

/obj/machinery/computer/cargo_seller
	name = "supply selling console"
	desc = "Used to only sell supplies."

	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/cargo")
	icon_screen = "supply"
	light_color = COLOR_BRIGHT_ORANGE
	circuit = /obj/item/circuitboard/computer/cargo_seller

	resistance_flags = INDESTRUCTIBLE
	req_access = list(ACCESS_CARGO)

	// ID of the marker region.
	var/region_id = "default"
	// The marker region.
	var/list/region

	///Interface name for the ui_interact call for different subtypes.
	var/interface_type = "CargoSeller"
	///The account this console processes and displays. Independent from the account the shuttle processes.
	var/cargo_account = ACCOUNT_CAR

	var/list/preview_items = list()
	var/preview_value = 0
	var/next_preview_update = 0
	var/last_sale = 0
	var/message = "Remember to stamp and send back the supply manifests."
	var/update_interval = 1 SECONDS

/obj/machinery/computer/cargo_seller/screwdriver_act(mob/living/user, obj/item/tool)
	return TRUE

/obj/machinery/computer/cargo_seller/ui_interact(mob/user, datum/tgui/ui)
	refresh_preview(TRUE)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, interface_type, name)
		ui.open()

/obj/machinery/computer/cargo_seller/post_machine_initialize()
	. = ..()
	region = get_cargo_marker_region(region_id)

/obj/machinery/computer/cargo_seller/proc/get_sellable_atoms()
	var/list/items = list()

	for(var/turf/market_turf as anything in region)
		for(var/atom/movable/item in market_turf.contents)
			if(ismob(item) || item.anchored)
				continue

			if(item == src || istype(item, /obj/effect/landmark/cargo_marker))
				continue

			items += item

	return items

/obj/machinery/computer/cargo_seller/proc/get_export_value(atom/movable/item, include_contents = TRUE)
	var/datum/export_report/report
	if(include_contents)
		report = export_item_and_contents(item, dry_run = TRUE, delete_unsold = FALSE)
	else
		report = export_single_item(item, dry_run = TRUE, delete_unsold = FALSE)

	var/value = 0
	for(var/export_type in report.total_value)
		value += report.total_value[export_type]

	return value

/obj/machinery/computer/cargo_seller/proc/find_contraband(atom/movable/item)
	if(is_type_in_typecache(item, GLOB.blacklisted_cargo_types))
		return TRUE

	// TODO: emagging allows to sell contraband?
	if(HAS_TRAIT(item, TRAIT_CONTRABAND))
		return TRUE

	if(HAS_TRAIT(item, TRAIT_CONTRABAND_BLOCKER))
		return FALSE

	for(var/atom/movable/contained in item.contents)
		var/atom/movable/found_contraband = find_contraband(contained)
		if(found_contraband)
			return TRUE

	return FALSE

/obj/machinery/computer/cargo_seller/proc/get_preview_item(atom/movable/item)
	return list("name" = item.name, "value" = get_export_value(item, FALSE), "is_manifest" = istype(item, /obj/item/paper/fluff/jobs/cargo/manifest))

/obj/machinery/computer/cargo_seller/proc/refresh_preview(force = FALSE)
	if(!force && world.time < next_preview_update)
		return

	preview_items = list()
	preview_value = 0
	for(var/atom/movable/item as anything in get_sellable_atoms())
		preview_items += list(get_preview_item(item))
		preview_value += get_export_value(item)

		for(var/atom/movable/contained in item.get_all_contents_skipping_traits(TRAIT_CONTRABAND_BLOCKER))
			if(contained == item)
				continue
			preview_items += list(get_preview_item(contained))

	next_preview_update = world.time + update_interval

/obj/machinery/computer/cargo_seller/ui_data(mob/user)
	refresh_preview()
	var/list/data = list()
	data["items"] = preview_items
	data["preview_value"] = preview_value
	data["last_sale"] = last_sale
	data["message"] = message
	data["account_balance"] = 0
	data["currency_full_name"] = MONEY_NAME
	data["currency_symbol"] = MONEY_SYMBOL

	var/datum/bank_account/account = SSeconomy.get_dep_account(cargo_account)
	if(account)
		data["account_balance"] = account.account_balance

	return data

/obj/machinery/computer/cargo_seller/proc/sell(mob/user)
	var/datum/bank_account/account = SSeconomy.get_dep_account(cargo_account)
	if(!account)
		log_admin("[src] has tried to access [cargo_account] but couldn't, something is really fucked!")
		say("No valid cargo account is configured.")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
		return

	var/list/items = get_sellable_atoms()
	if(!length(items))
		say("There are no items in the selling zone.")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
		return

	for(var/atom/movable/item as anything in items)
		if(find_contraband(item))
			say("Contraband detected in the selling zone.")
			playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
			refresh_preview(TRUE)
			return

	var/presale_points = account.account_balance
	var/msg = ""
	var/datum/export_report/report = new

	for(var/atom/movable/item as anything in items)
		export_item_and_contents(item, delete_unsold = FALSE, external_report = report)


	for(var/datum/export/exported_datum in report.total_amount)
		var/export_text = exported_datum.total_printout(report)
		if(!export_text)
			continue

		msg += export_text + "\n"
		account.adjust_money(report.total_value[exported_datum])

	last_sale = account.account_balance - presale_points
	message = msg || "Nothing in the selling zone had export value."
	SSshuttle.centcom_message = message

	if(report.exported_atoms.len)
		investigate_log("contents sold for [last_sale] [MONEY_NAME]. Contents: [report.exported_atoms.Join(",")]. Message: [msg]", INVESTIGATE_CARGO)

	playsound(src, 'sound/machines/beep/twobeep_high.ogg', 50, FALSE)
	refresh_preview(TRUE)

/obj/machinery/computer/cargo_seller/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("sell")
			sell(ui.user)
			SStgui.update_uis(src)
			return TRUE

/obj/machinery/computer/cargo_seller/interdyne
	cargo_account = ACCOUNT_INT
	req_access = list(ACCESS_SYNDICATE)
