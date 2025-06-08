/decl/outfit/job/ringdown
	abstract_type = /decl/outfit/job/ringdown
	mask          = /obj/item/clothing/mask/gas/half
	gloves        = /obj/item/clothing/gloves/black
	shoes         = /obj/item/clothing/shoes/workboots
	pda_type      = null

/decl/outfit/job/ringdown/drifter
	name    = "Ringdown - Drifter"
	uniform = /obj/item/clothing/jumpsuit/drifter
	suit    = /obj/item/clothing/suit/poncho/drifter

/decl/outfit/job/ringdown/asset_reclamation
	name    = "Ringdown - Asset Reclamation Employee"
	suit    = /obj/item/clothing/suit/ar_jacket
	uniform = /obj/item/clothing/costume/ar_uniform
	shoes   = /obj/item/clothing/shoes/color/black

/decl/outfit/job/ringdown/courser_guild
	name    = "Ringdown - Courser Guild Recruit"
	suit    = /obj/item/clothing/suit/courser_jacket
	uniform = /obj/item/clothing/costume/courser_uniform
	shoes   = /obj/item/clothing/shoes/jackboots
	gloves  = /obj/item/clothing/gloves/thick

/decl/outfit/job/ringdown/imperial_citizen
	name    = "Ringdown - Crown Imperial Citizen"
	uniform = /obj/item/clothing/shirt/toga
	shoes   = /obj/item/clothing/shoes/sandal
	mask    = /obj/item/clothing/accessory/necklace/gold

/decl/outfit/job/ringdown/shoaler
	name    = "Ringdown - Shoaler"
	shoes   = /obj/item/clothing/shoes/magboots/vox
	gloves  = /obj/item/clothing/gloves/vox
	mask    = /obj/item/clothing/mask/gas/vox
	back    = /obj/item/tank/nitrogen
	uniform = /obj/item/clothing/suit/robe/vox
	suit    = /obj/item/clothing/suit/cloak/shoaler

/decl/outfit/job/ringdown/brood_auxillary
	name    = "Ringdown - Brood Auxillary"
	mask    = /obj/item/clothing/mask/gas/ascent
	uniform = /obj/item/clothing/jumpsuit/ascent
	shoes   = /obj/item/clothing/shoes/magboots/ascent
	back    = /obj/item/tank/mantid/reactor // this needs to be revisited and made less broken (algae tank instead?)
	suit    = /obj/item/clothing/suit/armor/mantid
	head    = /obj/item/clothing/head/helmet/mantid

/decl/outfit/job/ringdown/brood_auxillary/post_equip(mob/living/human/H)
	. = ..()
	spawn(1)
		H.set_internals(H.get_equipped_item(slot_back_str))

/decl/outfit/job/ringdown/guild_runner
	name    = "Ringdown - Courser Guild Runner"
	shoes   = /obj/item/clothing/shoes/avian/footwraps
	uniform = /obj/item/clothing/dress/avian_smock/courser_uniform
	suit    = /obj/item/clothing/suit/cloak/courser

/decl/outfit/job/ringdown/wandering_husk
	name    = "Ringdown - Wandering Husk"
	uniform = /obj/item/clothing/shirt/harness
	suit    = /obj/item/clothing/suit/poncho/drifter

/decl/outfit/job/ringdown/drake_clanner
	name    = "Ringdown - Clanless Drake"
	suit    = /obj/item/clothing/suit/poncho/drake
	uniform = /obj/item/clothing/suit/mantle
	shoes   = /obj/item/clothing/shoes/sandal
