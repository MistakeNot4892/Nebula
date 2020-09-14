
/decl/hierarchy/outfit/job/generic
	hierarchy_type = /decl/hierarchy/outfit/job/generic
	id_type = /obj/item/card/id/civilian

/decl/hierarchy/outfit/job/generic/scientist
	name = OUTFIT_JOB_NAME("Default Scientist")
	l_ear = /obj/item/radio/headset/headset_sci
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science
	shoes = /obj/item/clothing/shoes/color/white
	pda_type = /obj/item/modular_computer/pda/science
	uniform = /obj/item/clothing/under/color/white

/obj/item/radio/headset/headset_sci
	name = "science radio headset"
	desc = "A sciency headset. Like usual."
	icon = 'icons/obj/items/device/radio/headsets/headset_science.dmi'
	encryption_keys = list(/obj/item/encryptionkey/headset_sci)
	
/obj/item/encryptionkey/headset_sci
	name = "science radio encryption key"
	icon_state = "sci_cypherkey"
	can_decrypt = list(access_research)

/decl/hierarchy/outfit/job/generic/engineer
	name = OUTFIT_JOB_NAME("Default Engineer")
	head = /obj/item/clothing/head/hardhat
	uniform = /obj/item/clothing/under/engineer
	r_pocket = /obj/item/t_scanner
	belt = /obj/item/storage/belt/utility/full
	l_ear = /obj/item/radio/headset/headset_eng
	shoes = /obj/item/clothing/shoes/workboots
	pda_type = /obj/item/modular_computer/pda/engineering
	pda_slot = slot_l_store_str
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL

/obj/item/radio/headset/headset_eng
	name = "engineering radio headset"
	desc = "When the engineers wish to gossip like highschoolers."
	icon = 'icons/obj/items/device/radio/headsets/headset_engineering.dmi'
	encryption_keys = list(/obj/item/encryptionkey/headset_eng)

/obj/item/encryptionkey/headset_eng
	name = "engineering radio encryption key"
	icon_state = "eng_cypherkey"
	can_decrypt = list(access_engine)

/decl/hierarchy/outfit/job/generic/engineer/New()
	..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/generic/doctor
	name = OUTFIT_JOB_NAME("Default Doctor")
	uniform = /obj/item/clothing/under/medical
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	hands = list(/obj/item/storage/firstaid/adv)
	r_pocket = /obj/item/flashlight/pen
	l_ear = /obj/item/radio/headset/headset_med
	shoes = /obj/item/clothing/shoes/color/white
	pda_type = /obj/item/modular_computer/pda/medical
	pda_slot = slot_l_store_str

/obj/item/radio/headset/headset_med
	name = "medical radio headset"
	desc = "A headset for the trained staff of the medbay."
	icon = 'icons/obj/items/device/radio/headsets/headset_medical.dmi'
	encryption_keys = list(/obj/item/encryptionkey/headset_med)

/obj/item/encryptionkey/headset_med
	name = "medical radio encryption key"
	icon_state = "med_cypherkey"
	can_decrypt = list(access_medical)

/decl/hierarchy/outfit/job/generic/doctor/New()
	..()
	BACKPACK_OVERRIDE_MEDICAL

/decl/hierarchy/outfit/job/generic/chef
	name = OUTFIT_JOB_NAME("Default Chef")
	l_ear = /obj/item/radio/headset/headset_service
	uniform = /obj/item/clothing/under/chef
	suit = /obj/item/clothing/suit/chef
	head = /obj/item/clothing/head/chefhat
	pda_type = /obj/item/modular_computer/pda

/obj/item/encryptionkey/headset_service
	name = "service radio encryption key"
	icon_state = "srv_cypherkey"
	can_decrypt = list(access_bar)

/obj/item/radio/headset/headset_service
	name = "service radio headset"
	desc = "Headset used by the service staff, tasked with keeping everyone full, happy and clean."
	icon = 'icons/obj/items/device/radio/headsets/headset_service.dmi'
	encryption_keys = list(/obj/item/encryptionkey/headset_service)
