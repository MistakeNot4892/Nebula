/decl/hierarchy/outfit/job/wyrm/captain
	name = WYRM_OUTFIT_JOB_NAME("Captain")
	uniform = /obj/item/clothing/pants/baggy/casual/classicjeans
	shoes = /obj/item/clothing/shoes/color/black
	pda_type = /obj/item/modular_computer/pda/heads/captain
	id_type = /obj/item/card/id/gold
	l_ear = /obj/item/radio/headset/heads/captain

/decl/hierarchy/outfit/job/tradeship/captain/post_equip(var/mob/living/carbon/human/H)
	..()
	var/obj/item/clothing/uniform = H.w_uniform
	if(uniform)
		var/obj/item/clothing/accessory/toggleable/hawaii/random/eyegore = new()
		if(uniform.can_attach_accessory(eyegore))
			uniform.attach_accessory(null, eyegore)
		else
			qdel(eyegore)

/decl/hierarchy/outfit/job/wyrm/mate
	name = WYRM_OUTFIT_JOB_NAME("First Mate")
	uniform = /obj/item/clothing/pants/casual/blackjeans
	shoes = /obj/item/clothing/shoes/color/black
	id_type = /obj/item/card/id/silver
	pda_type = /obj/item/modular_computer/pda/heads/hop
	l_ear = /obj/item/radio/headset/heads/hop/wyrm

/decl/hierarchy/outfit/job/wyrm/mate/post_equip(var/mob/living/carbon/human/H)
	..()
	var/obj/item/clothing/uniform = H.w_uniform
	if(uniform)
		var/obj/item/clothing/accessory/toggleable/corpjacket/heph/wyrm/profesinal = new()
		if(uniform.can_attach_accessory(profesinal))
			uniform.attach_accessory(null, profesinal)
		else
			qdel(profesinal)

/obj/item/clothing/accessory/toggleable/corpjacket/heph/wyrm
	name = "first mate's jacket"
	desc = "A well-kept jacket more typically worn by corporate executives."
	open = FALSE

/obj/item/radio/headset/heads/hop/wyrm
	name = "first mate's headset"

/decl/hierarchy/outfit/job/wyrm/hos
	name = WYRM_OUTFIT_JOB_NAME("Security Officer")
	uniform = /obj/item/clothing/under/tactical
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/storage/belt/holster/security
	glasses = /obj/item/clothing/glasses/sunglasses/sechud/toggle
	l_ear = /obj/item/radio/headset/headset_com

/decl/hierarchy/outfit/job/wyrm/bodyguard