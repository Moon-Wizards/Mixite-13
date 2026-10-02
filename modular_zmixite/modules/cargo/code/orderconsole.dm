/obj/docking_port/mobile/supply/get_purchase_turfs()
	var/list/buy_region = get_cargo_marker_region("nt_buy")
	if(!length(buy_region))
		return list()

	var/list/empty_turfs = list()
	var/list/pad_turfs = list()
	for(var/turf/open/floor/pad_turf as anything in buy_region)
		pad_turfs += pad_turf
		var/occupied = FALSE
		for(var/atom/movable/occupant in pad_turf.contents)
			if(occupant.anchored || istype(occupant, /obj/effect/landmark/cargo_marker))
				continue
			occupied = TRUE
			break

		if(!occupied)
			empty_turfs += pad_turf

	return length(empty_turfs) ? empty_turfs : pad_turfs

/obj/machinery/computer/cargo/proc/create_requisition()
	if(!length(SSshuttle.shopping_list))
		return FALSE

	var/obj/item/paper/requisition/requisition_paper = new(get_turf(src))
	requisition_paper.name = "requisition form - [server_timestamp(ic_time = TRUE)] (PT: [round_timestamp()])"
	var/requisition_text = "<h2>[station_name()] Supply Requisition</h2>"
	requisition_text += "<hr/>"
	requisition_text += "Time of Order: [UNDERLINED_HTML_TEXT("[server_timestamp(ic_time = TRUE)]", "Shift Time: [round_timestamp()]")]<br/><br/>"
	for(var/datum/supply_order/order as anything in SSshuttle.shopping_list)
		requisition_text += "<b>[order.pack.name]</b></br>"
		requisition_text += "- Order ID: [order.id]</br>"
		var/restrictions = SSid_access.get_access_desc(order.pack.access)
		if(restrictions)
			requisition_text += "- Access Restrictions: [restrictions]</br>"
		requisition_text += "- Ordered by: [order.orderer] ([order.orderer_rank])</br>"
		var/paying_account = order.paying_account
		if(paying_account)
			requisition_text += "- Paid Privately by: [order.paying_account.account_holder]<br/>"
		var/reason = order.reason
		if(reason)
			requisition_text += "- Reason Given: [reason]</br>"
		requisition_text += "</br></br>"
	requisition_paper.add_raw_text(requisition_text, advanced_html = TRUE)
	requisition_paper.color = "#9ef5ff"
	requisition_paper.update_appearance()
	return TRUE

/obj/machinery/computer/cargo/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(action == "purchase")
		if(!create_requisition())
			return

		SSshuttle.supply.buy()
		playsound(src, 'sound/machines/beep/twobeep_high.ogg', 50, FALSE)
		say("Order processed. Navigate to the Automated Trade Station to collect it.")
		return TRUE

	if(action == "send" && SSshuttle.supply.getDockedId() != docking_home)
		if(!SSshuttle.supply.canMove())
			say(safety_warning)
			return
		if(SSshuttle.supply_blocked)
			say(blockade_warning)
			return

		ui.user.investigate_log("called the supply shuttle.", INVESTIGATE_CARGO)
		say("The supply shuttle has been called and will arrive in [SSshuttle.supply.timeLeft(600)] minute\s.")
		SSshuttle.moveShuttle(cargo_shuttle, docking_home, TRUE)
		return TRUE

	return ..()
