/obj/item/clothing/accessory/cloak/eureka
	name = "weathercloak"
	desc = "A rough and hardy cloak suitable for the worst weather Nullius can throw at it."
	color = COLOR_COLONIST
	icon = 'maps/eureka/icons/cloak_imperial.dmi'


/obj/item/clothing/accessory/cloak/eureka/medic
	name = "medic's weathercloak"
	desc = "A hardy weathercloak for the sawbones on the go."
	var/stripe_colour = "#d3e0de"
	var/cross_colour = "#55827b"

/obj/item/clothing/accessory/cloak/eureka/medic/on_update_icon()
	..()
	cut_overlays()
	if(stripe_colour && check_state_in_icon("[icon_state]-stripe", icon))
		var/image/I = image(icon, "[icon_state]-stripe")
		I.color = stripe_colour
		I.appearance_flags |= RESET_COLOR
		add_overlay(I)
	if(cross_colour && check_state_in_icon("[icon_state]-cross", icon))
		var/image/I = image(icon, "[icon_state]-cross")
		I.color = cross_colour
		I.appearance_flags |= RESET_COLOR
		add_overlay(I)

/obj/item/clothing/accessory/cloak/eureka/medic/apply_overlays(mob/user_mob, bodytype, image/overlay, slot)
	..()
	if(!(slot == slot_wear_suit_str || slot == slot_tie_str || slot == slot_w_uniform_str))
		return overlay

	if(stripe_colour)
		var/image/cloverlay
		var/bodyicon = get_icon_for_bodytype(bodytype)
		if(bodytype != lowertext(user_mob.get_bodytype()))
			var/mob/living/carbon/human/H = user_mob
			cloverlay = H.species.get_offset_overlay_image(FALSE, bodyicon, "[bodytype]-overlay-stripe", stripe_colour, slot)
		else
			cloverlay = image(bodyicon, "[bodytype]-overlay-stripe")
			cloverlay.color = stripe_colour
		cloverlay.layer = MOB_LAYER+0.01
		cloverlay.appearance_flags |= RESET_COLOR
		overlay.overlays += cloverlay

	if(cross_colour)
		var/image/cloverlay
		var/bodyicon = get_icon_for_bodytype(bodytype)
		if(bodytype != lowertext(user_mob.get_bodytype()))
			var/mob/living/carbon/human/H = user_mob
			cloverlay = H.species.get_offset_overlay_image(FALSE, bodyicon, "[bodytype]-overlay-cross", cross_colour, slot)
		else
			cloverlay = image(bodyicon, "[bodytype]-overlay-cross")
			cloverlay.color = cross_colour
		cloverlay.layer = MOB_LAYER+0.01
		cloverlay.appearance_flags |= RESET_COLOR
		overlay.overlays += cloverlay

	. = overlay


/obj/item/clothing/accessory/cloak/eureka/imperial
	name = "\improper Crown-Imperial weathercloak"
	color = COLOR_LEGION
	var/trim_colour = COLOR_LEGION_TRIM

/obj/item/clothing/accessory/cloak/eureka/imperial/officer
	name = "\improper Crown officer's weathercloak"
	color = COLOR_LEGION_OFFICER
	trim_colour = COLOR_LEGION_OFFICER_TRIM

/obj/item/clothing/accessory/cloak/eureka/imperial/on_update_icon()
	..()
	cut_overlays()
	if(trim_colour && check_state_in_icon("[icon_state]-trim", icon))
		var/image/I = image(icon, "[icon_state]-trim")
		I.color = trim_colour
		I.appearance_flags |= RESET_COLOR
		add_overlay(I)

/obj/item/clothing/accessory/cloak/eureka/imperial/apply_overlays(mob/user_mob, bodytype, image/overlay, slot)
	..()
	if(trim_colour && (slot == slot_wear_suit_str || slot == slot_tie_str || slot == slot_w_uniform_str))
		var/image/underlay
		var/image/cloverlay
		var/bodyicon = get_icon_for_bodytype(bodytype)
		if(bodytype != lowertext(user_mob.get_bodytype()))
			var/mob/living/carbon/human/H = user_mob
			underlay =  H.species.get_offset_overlay_image(FALSE, bodyicon, "[bodytype]-underlay-trim", trim_colour, slot)
			cloverlay = H.species.get_offset_overlay_image(FALSE, bodyicon, "[bodytype]-overlay-trim", trim_colour, slot)
		else
			underlay = image(bodyicon, "[bodytype]-underlay-trim")
			underlay.color = trim_colour
			cloverlay = image(bodyicon, "[bodytype]-overlay-trim")
			cloverlay.color = trim_colour
		underlay.appearance_flags |= RESET_COLOR
		underlay.layer = MOB_LAYER-0.01
		overlay.underlays += underlay
		cloverlay.layer = MOB_LAYER+0.01
		cloverlay.appearance_flags |= RESET_COLOR
		overlay.overlays += cloverlay
	. = overlay
