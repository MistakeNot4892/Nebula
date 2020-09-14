/decl/hierarchy/outfit/nanotrasen
	hierarchy_type = /decl/hierarchy/outfit/nanotrasen
	uniform = /obj/item/clothing/under/centcom
	shoes = /obj/item/clothing/shoes/dress
	gloves = /obj/item/clothing/gloves/color/white
	l_ear = /obj/item/radio/headset/heads/hop
	glasses = /obj/item/clothing/glasses/sunglasses
	id_slot = slot_wear_id_str
	id_type = /obj/item/card/id/centcom/station
	pda_slot = slot_r_store_str
	pda_type = /obj/item/modular_computer/pda/heads

/obj/item/radio/headset/heads/hop
	name = "head of personnel's headset"
	desc = "The headset of the guy who will one day be captain."
	icon = 'icons/obj/items/device/radio/headsets/headset_command.dmi'
	encryption_keys = list(/obj/item/encryptionkey/heads/hop)

/obj/item/encryptionkey/heads/hop
	name = "head of personnel's encryption key"
	icon_state = "hop_cypherkey"
	can_decrypt = list(
		access_bar,
		access_cargo,
		access_bridge,
		access_security
	)

/decl/hierarchy/outfit/nanotrasen/representative
	name = "Corporate Representative"
	belt = /obj/item/clipboard
	id_pda_assignment = "Corporate Representative"

/decl/hierarchy/outfit/nanotrasen/officer
	name = "Corporate Officer"
	head = /obj/item/clothing/head/beret/corp/centcom/officer
	l_ear = /obj/item/radio/headset/heads/captain
	belt = /obj/item/gun/energy
	id_pda_assignment = "Corporate Officer"

/decl/hierarchy/outfit/nanotrasen/captain
	name = "Corporate Captain"
	uniform = /obj/item/clothing/under/centcom_captain
	l_ear = /obj/item/radio/headset/heads/captain
	head = /obj/item/clothing/head/beret/corp/centcom/captain
	belt = /obj/item/gun/energy
	id_pda_assignment = "Corporate Captain"

/decl/hierarchy/outfit/nanotrasen/commander
	name = "Corporate Commander"
	head = /obj/item/clothing/head/centhat
	mask = /obj/item/clothing/mask/smokable/cigarette/cigar/cohiba
	shoes = /obj/item/clothing/shoes/jackboots/swat
	uniform = /obj/item/clothing/under/centcom_captain
	suit = /obj/item/clothing/suit/armor/bulletproof
	gloves = /obj/item/clothing/gloves/thick/swat
	l_ear =  /obj/item/radio/headset/heads/captain
	glasses = /obj/item/clothing/glasses/eyepatch
	l_pocket = /obj/item/flame/lighter/zippo
	id_pda_assignment = "Corporate Commander"

/obj/item/radio/headset/heads/captain
	name = "captain's headset"
	desc = "The headset of the boss."
	icon_state = "com_headset"
	icon = 'icons/obj/items/device/radio/headsets/headset_command.dmi'
	encryption_keys = list(/obj/item/encryptionkey/heads/captain)

/obj/item/encryptionkey/heads/captain
	name = "captain's encryption key"
	icon_state = "cap_cypherkey"
	can_decrypt = list(
		access_bridge,
		access_security,
		access_engine,
		access_research,
		access_medical,
		access_cargo,
		access_bar
	)

/decl/hierarchy/outfit/death_command
	name = "Spec Ops - Death commando"

/decl/hierarchy/outfit/death_command/equip(mob/living/carbon/human/H, rank, assignment, equip_adjustments)
	var/decl/special_role/deathsquad = GET_DECL(/decl/special_role/deathsquad)
	deathsquad.equip(H)
	return 1

/decl/hierarchy/outfit/syndicate_command
	name = "Spec Ops - Syndicate commando"

/decl/hierarchy/outfit/syndicate_command/equip(mob/living/carbon/human/H, rank, assignment, equip_adjustments)
	var/decl/special_role/commandos = GET_DECL(/decl/special_role/deathsquad/mercenary)
	commandos.equip(H)
	return 1

