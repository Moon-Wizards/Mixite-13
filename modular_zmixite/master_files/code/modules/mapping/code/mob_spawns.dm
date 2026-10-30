/datum/outfit/ds2/syndicate
	name = "DS-2 Operative"
	uniform = /obj/item/clothing/under/syndicate/nova/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		/obj/item/crowbar = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/nova/ds2

/datum/outfit/ds2/syndicate/miner
	name = "DS-2 Mining Officer"
	uniform = /obj/item/clothing/under/syndicate/nova/overalls
	belt = /obj/item/storage/bag/ore
	back = /obj/item/storage/backpack/satchel/explorer
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		/obj/item/crowbar = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/t_scanner/adv_mining_scanner/lesser = 1,
		/obj/item/gun/energy/recharge/kinetic_accelerator = 1,
		)
	id_trim = /datum/id_trim/syndicom/nova/ds2/miner
	l_pocket = /obj/item/card/mining_point_card
	r_pocket = /obj/item/mining_voucher
	head = /obj/item/clothing/head/soft/black

/datum/outfit/ds2/syndicate/service
	name = "DS-2 General Staff"
	uniform = /obj/item/clothing/under/syndicate/nova/tactical
	id_trim = /datum/id_trim/syndicom/nova/ds2/syndicatestaff
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
	)
	suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/soft/mime

/datum/outfit/ds2/syndicate/enginetech
	name = "DS-2 Engine Technician"
	uniform = /obj/item/clothing/under/syndicate/nova/overalls
	head = /obj/item/clothing/head/soft/sec/syndicate
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		)
	id_trim = /datum/id_trim/syndicom/nova/ds2/enginetechnician
	glasses = /obj/item/clothing/glasses/welding/up
	belt = /obj/item/storage/belt/utility/syndicate
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/ds2/syndicate/researcher
	name = "DS-2 Researcher"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/nova/utility/syndicate
	id_trim = /datum/id_trim/syndicom/nova/ds2/researcher
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	glasses = /obj/item/clothing/glasses/sunglasses/chemical
	gloves = /obj/item/clothing/gloves/color/black
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
	)

/datum/outfit/ds2/syndicate/stationmed
	name = "DS-2 Medical Officer"
	uniform = /obj/item/clothing/under/syndicate/scrubs
	id_trim = /datum/id_trim/syndicom/nova/ds2/medicalofficer
	suit = /obj/item/clothing/suit/toggle/labcoat/interdyne
	belt = /obj/item/storage/belt/medical/paramedic
	gloves = /obj/item/clothing/gloves/latex/nitrile/ntrauma
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		/obj/item/crowbar = 1,
		/obj/item/storage/medkit/surgery = 1,
		)

/datum/outfit/ds2/syndicate/brigoff
	name = "DS-2 Brig Officer"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/nova/ds2/brigofficer
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	back = /obj/item/storage/backpack/security
	head = /obj/item/clothing/head/helmet/swat/ds
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/gun/ballistic/automatic/pistol/sol/evil = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol = 1,
		)
	r_pocket = /obj/item/flashlight/seclite
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/syndicate/alt

/datum/outfit/ds2/syndicate/post_equip(mob/living/carbon/human/syndicate)
	syndicate.add_faction(ROLE_DS2)
	return ..()

//DS-2 Command
/datum/outfit/ds2/syndicate_command
	name = "DS-2 Command Operative"
	uniform = /obj/item/clothing/under/syndicate/nova/tactical
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicate/alt/leader
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/storage/box/nif_ghost_box/ghost_role=1,
		/obj/item/crowbar = 1,
		)
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/nova/ds2

/datum/outfit/ds2/syndicate_command/masteratarms
	name = "DS-2 Master At Arms"
	uniform = /obj/item/clothing/under/syndicate/combat
	id_trim = /datum/id_trim/syndicom/nova/ds2/masteratarms
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	back = /obj/item/storage/backpack/satchel/sec
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
	)
	head = /obj/item/clothing/head/hats/hos/beret/syndicate
	r_pocket = /obj/item/flashlight/seclite
	implants = list(
		/obj/item/implant/weapons_auth,
		/obj/item/implant/kaza_ruk
		)

/datum/outfit/ds2/syndicate_command/corporateliaison
	name = "DS-2 Corporate Liasion"
	uniform = /obj/item/clothing/under/syndicate/sniper
	head = /obj/item/clothing/head/fedora
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
	)
	id_trim = /datum/id_trim/syndicom/nova/ds2/corporateliasion

/datum/outfit/ds2/syndicate_command/admiral
	name = "DS-2 Admiral"
	uniform = /obj/item/clothing/under/rank/captain/nova/utility/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
	)
	belt = /obj/item/gun/ballistic/automatic/pistol/aps
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	id = /obj/item/card/id/advanced/gold/generic
	id_trim = /datum/id_trim/syndicom/nova/ds2/stationadmiral
