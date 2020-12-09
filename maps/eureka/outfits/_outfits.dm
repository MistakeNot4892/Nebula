/decl/hierarchy/outfit/job/eureka
	hierarchy_type = /decl/hierarchy/outfit/job/eureka
	mask = /obj/item/clothing/mask/gas/half
	belt = /obj/item/tank/emergency/oxygen
	glasses = /obj/item/clothing/glasses/goggles
	l_ear = null
	uniform = /obj/item/clothing/under/dispatch 
	shoes = /obj/item/clothing/shoes/workboots
	id_slot = slot_belt_str
	id_type = /obj/item/card/id/civilian // todo: chit or tags
	var/cloak_type = /obj/item/clothing/accessory/cloak/eureka

/decl/hierarchy/outfit/job/eureka/equip(mob/living/carbon/human/H, rank, assignment, equip_adjustments)
	. = ..()
	if(cloak_type)
		var/obj/item/clothing/accessory/cloak = new cloak_type(H)
		if(istype(H.w_uniform, /obj/item/clothing))
			var/obj/item/clothing/uniform = H.w_uniform
			if(uniform.can_attach_accessory(cloak))
				uniform.attach_accessory(null, cloak)
				return
		if(istype(H.wear_suit, /obj/item/clothing))
			var/obj/item/clothing/suit = H.wear_suit
			if(suit.can_attach_accessory(cloak))
				suit.attach_accessory(null, cloak)
				return
		if(!H.wear_suit)
			H.equip_to_slot_or_del(cloak, slot_wear_suit_str)

/obj/item/clothing/glasses/goggles
	name = "protective goggles"
	desc = "Tight-fitted protective goggles."
	icon = 'maps/eureka/icons/goggles.dmi'

/obj/item/clothing/gloves/color/gray
	color = COLOR_GRAY40
