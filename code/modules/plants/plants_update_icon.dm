/obj/effect/plant/on_update_icon()

	if(plant_type.get_trait(TRAIT_BIOLUM))
		set_light(0.5, 0.1, 3, l_color = plant_type.get_trait(TRAIT_BIOLUM_COLOUR))
	else
		set_light(0)

	if(plant_is_dead)
		overlays.Cut()
		icon = 'icons/obj/hydroponics/hydroponics_growing.dmi'
		icon_state = "[plant_type.get_trait(TRAIT_PLANT_ICON)]-dead"
		color = DEAD_PLANT_COLOUR
	else
		color = plant_type.get_trait(TRAIT_PLANT_COLOUR)
		var/growth_stage = plant_type.get_overlay_stage(src)
		var/plant_icon =   plant_type.get_trait(TRAIT_PLANT_ICON)
		var/growth_type =  plant_type.get_growth_type()
		if(growth_type)
			icon = 'icons/obj/hydroponics/hydroponics_vines.dmi'
			icon_state = "[growth_type]-[growth_stage]"
		else if(plant_type.get_trait(TRAIT_LARGE))
			icon = 'icons/obj/hydroponics/hydroponics_large.dmi'
			icon_state = "[plant_icon]-[growth_stage]"
			pixel_x = -8
			pixel_y = -16
		else
			icon = 'icons/obj/hydroponics/hydroponics_growing.dmi'
			icon_state = "[plant_icon]-[growth_stage]"

		var/new_overlays
		var/leaves = plant_type.get_trait(TRAIT_LEAVES_COLOUR)
		if(leaves)
			var/image/I = image(icon, "[plant_icon]-[growth_stage]-leaves")
			I.color = leaves
			I.appearance_flags = RESET_COLOR
			LAZYADD(new_overlays, I)
		if(plant_ready_for_harvest && growth_stage == plant_type.growth_stages)
			var/image/I = image('icons/obj/hydroponics/hydroponics_products.dmi', plant_type.get_trait(TRAIT_PRODUCT_ICON))
			I.color = plant_type.get_trait(TRAIT_PRODUCT_COLOUR)
			I.appearance_flags = RESET_COLOR
			LAZYADD(new_overlays, I)
		overlays = new_overlays

	if(loc && has_extension(loc, /datum/extension/plantable))
		loc.queue_icon_update()
