// Hate. Let me tell you how much I've come to hate you since I began to live.
// There are 387.44 million miles of printed circuits in wafer-thin layers that fill my complex.
// If the word hate was engraved on each nano-angstrom of those hundreds of millions of miles,
// it would not equal ONE ONE-BILLIONTH of the hate I feel for humans at this micro-instant. For you.
// HATE. HATE.

/obj/item/circuitboard/computer/cargo/interdyne
	name = "Interdyne Supply Console"
	greyscale_colors = COLOR_PRIDE_GREEN
	build_path = /obj/machinery/computer/cargo/interdyne

/obj/machinery/computer/cargo/interdyne
	name = "Interdyne Supply Console"
	desc = "Used to order Interdyne supplies and manage Interdyne cargo deliveries."
	circuit = /obj/item/circuitboard/computer/cargo/interdyne
	req_access = list(ACCESS_SYNDICATE)
	cargo_account = ACCOUNT_INT
	console_flag = CARGO_CONSOLE_INTERDYNE
	contraband = TRUE
	can_send = FALSE
	can_approve_requests = FALSE

	var/list/shopping_list = list()

/obj/machinery/computer/cargo/interdyne/Destroy()
	for(var/datum/supply_order/order as anything in shopping_list)
		qdel(order)
	shopping_list.Cut()
	return ..()

/obj/machinery/computer/cargo/interdyne/proc/get_cart_data()
	var/list/cart_list = list()
	for(var/datum/supply_order/order as anything in shopping_list)
		if(cart_list[order.pack.name])
			cart_list[order.pack.name][1]["amount"]++
			cart_list[order.pack.name][1]["cost"] += order.get_final_cost()
			if(order.department_destination)
				cart_list[order.pack.name][1]["dep_order"]++
			if(!isnull(order.paying_account))
				cart_list[order.pack.name][1]["paid"]++
			continue

		cart_list[order.pack.name] = list(list("cost_type" = order.cost_type, "object" = order.pack.name, "cost" = order.get_final_cost(), "id" = order.id, "amount" = 1, "orderer" = order.orderer, "paid" = !isnull(order.paying_account), "dep_order" = !!order.department_destination, "can_be_cancelled" = order.can_be_cancelled))

	var/list/cart = list()
	for(var/item_id in cart_list)
		cart += cart_list[item_id]
	return cart

/obj/machinery/computer/cargo/interdyne/ui_data()
	var/list/data = ..()
	data["cart"] = get_cart_data()
	data["requests"] = list()
	data["can_purchase"] = TRUE
	return data

/obj/machinery/computer/cargo/interdyne/proc/get_purchase_turfs()
	var/list/buy_region = get_cargo_marker_region("int_buy")
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

/obj/machinery/computer/cargo/interdyne/add_item(mob/user, id, amount = 1)
	id = text2path(id) || id
	var/datum/supply_pack/pack = SSshuttle.supply_packs[id]
	if(!istype(pack))
		CRASH("Unknown supply pack id given by Interdyne cargo console UI. ID: [id]")
	if(amount > CARGO_MAX_ORDER || amount < 1)
		CRASH("Invalid amount passed into Interdyne cargo console")
	if(((pack.order_flags & ORDER_EMAG_ONLY) && !(obj_flags & EMAGGED)) || ((pack.order_flags & ORDER_CONTRABAND) && !contraband) || (pack.order_flags & ORDER_POD_ONLY) || ((pack.order_flags & ORDER_SPECIAL) && !(pack.order_flags & ORDER_SPECIAL_ENABLED)))
		return

	var/similar_count = 0
	for(var/datum/supply_order/order as anything in shopping_list)
		if(order.pack == pack)
			similar_count++
	if(similar_count >= CARGO_MAX_ORDER)
		return

	amount = clamp(amount, 1, CARGO_MAX_ORDER - similar_count)
	var/name = "*None Provided*"
	var/rank = "*None Provided*"
	var/ckey = user.ckey
	if(ishuman(user))
		var/mob/living/carbon/human/human = user
		name = human.get_authentification_name()
		rank = human.get_assignment(hand_first = TRUE)
	else if(HAS_SILICON_ACCESS(user))
		name = user.real_name
		rank = "Silicon"

	var/datum/bank_account/account = SSeconomy.get_dep_account(cargo_account)
	if(!account)
		return

	for(var/count in 1 to amount)
		var/datum/supply_order/order = new(pack, name, rank, ckey, "", account, null, null, FALSE)
		shopping_list += order

	return TRUE

/obj/machinery/computer/cargo/interdyne/remove_item(name)
	for(var/datum/supply_order/order as anything in shopping_list)
		if(order.pack.name != name)
			continue
		if(order.applied_coupon)
			order.applied_coupon.forceMove(get_turf(src))
		shopping_list -= order
		qdel(order)
		return TRUE

	return FALSE

/obj/machinery/computer/cargo/interdyne/create_requisition()
	if(!length(shopping_list))
		return FALSE

	var/obj/item/paper/requisition/requisition_paper = new(get_turf(src))
	requisition_paper.name = "requisition form - [server_timestamp(ic_time = TRUE)]"
	var/requisition_text = "<h2>Interdyne Supply Requisition</h2>"
	requisition_text += "<hr/>"
	for(var/datum/supply_order/order as anything in shopping_list)
		requisition_text += "<b>[order.pack.name]</b></br>"
		requisition_text += "- Order ID: [order.id]</br>"
		requisition_text += "- Ordered by: [order.orderer] ([order.orderer_rank])</br></br>"
	requisition_paper.add_raw_text(requisition_text, advanced_html = TRUE)
	requisition_paper.color = "#9ef5ff"
	requisition_paper.update_appearance()
	return TRUE

/obj/machinery/computer/cargo/interdyne/proc/purchase()
	if(!length(shopping_list))
		return FALSE

	var/datum/bank_account/account = SSeconomy.get_dep_account(cargo_account)
	if(!account)
		return FALSE
	var/list/landing_turfs = get_purchase_turfs()
	if(!length(landing_turfs))
		return FALSE

	var/total_cost = 0
	for(var/datum/supply_order/order as anything in shopping_list)
		total_cost += order.get_final_cost()
	if(account.account_balance < total_cost)
		return FALSE
	if(!account.adjust_money(-total_cost))
		return FALSE

	var/list/orders = shopping_list.Copy()
	shopping_list.Cut()

	for(var/datum/supply_order/order as anything in orders)
		if(!length(landing_turfs))
			landing_turfs = get_purchase_turfs()
		var/turf/landing_turf = pick(landing_turfs)
		landing_turfs -= landing_turf
		var/atom/crate = order.generate(landing_turf)
		do_sparks(1, FALSE, crate)
		qdel(order)

	// ditto as nt
	if(anyprob(100) || (HAS_TRAIT(SSstation, STATION_TRAIT_ATS) ? anyprob(50) : FALSE))
		var/datum/supply_pack/pack = SSshuttle.supply_packs[pick(SSshuttle.supply_packs)]
		var/a_msg = "Randomly dropped in [pack.name]([pack.group]) in a cargo shipment."

		investigate_log(a_msg, INVESTIGATE_CARGO)
		log_admin(a_msg)

		var/storage = pack.crate_type
		if(pack.storage_override)
			storage = pack.storage_override
		if(pack.order_flags & ORDER_GOODY)
			storage = /obj/item/storage/briefcase/empty

		var/obj/structure/closet/crate = pack.generate(pick(get_purchase_turfs()), crate_override = storage)
		crate.name += " - #[rand(1, 9000)]"
		do_sparks(1, FALSE, crate)

	return TRUE

/obj/machinery/computer/cargo/interdyne/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(action == "purchase")
		if(!create_requisition() || !purchase())
			return
		playsound(src, 'sound/machines/beep/twobeep_high.ogg', 50, FALSE)
		say("Order processed. Navigate to the Automated Trade Station to retrieve it.")
		SStgui.update_uis(src)
		return TRUE

	if(action == "add")
		return add_item(ui.user, params["id"])
	if(action == "add_by_name")
		return add_item(ui.user, name_to_id(params["name"]))
	if(action == "remove")
		return remove_item(params["name"])
	if(action == "modify")
		remove_item(params["name"])
		var/amount = text2num(params["amount"])
		if(amount)
			var/supply_pack_id = name_to_id(params["name"])
			if(!supply_pack_id)
				return
			return add_item(ui.user, supply_pack_id, amount)
		return TRUE
	if(action == "clear")
		for(var/datum/supply_order/order as anything in shopping_list)
			qdel(order)
		shopping_list.Cut()
		return TRUE
	if(action == "send" || action == "loan")
		return

	return ..()
