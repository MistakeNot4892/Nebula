
/mob/living/silicon/robot/platform/on_update_icon()

	cut_overlays()

	if(!istype(module, /obj/item/robot_module/platform))
		icon = initial(icon)
		icon_state = initial(icon_state)
		color = initial(color)
		return

	var/image/I
	var/obj/item/robot_module/platform/tank_module = module
	icon = tank_module.user_icon
	icon_state = tank_module.user_icon_state
	color = tank_module.base_color

	if(tank_module.armor_color)
		I = image(icon, "[icon_state]_armour")
		I.color = tank_module.armor_color
		I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
		add_overlay(I)

	for(var/decal in tank_module.decals)
		I = image(icon, "[icon_state]_[decal]")
		I.color = tank_module.decals[decal]
		I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
		add_overlay(I)

	if(tank_module.eye_color)
		I = image(icon, "[icon_state]_eyes")
		I.color = tank_module.eye_color
		I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
		add_overlay(I)

	if(client && key && stat == CONSCIOUS && tank_module.pupil_color)
		I = image(icon, "[icon_state]_pupils")
		I.color = tank_module.pupil_color
		I.layer = ABOVE_LIGHTING_LAYER
		I.plane = EFFECTS_ABOVE_LIGHTING_PLANE
		I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
		add_overlay(I)

/mob/living/silicon/robot/platform/proc/try_paint(var/obj/item/paint_sprayer/painting, var/mob/user)

	var/obj/item/robot_module/platform/tank_module = module
	if(!istype(tank_module))
		to_chat(user, SPAN_WARNING("\The [src] is not paintable."))
		return FALSE

	var/list/options = list("Eyes", "Armour", "Body", "Clear Colors")
	if(length(tank_module.available_decals))
		options += "Decal"
	if(length(tank_module.decals))
		options += "Clear Decals"
	for(var/option in options)
		var/image/radial_button = new /image
		radial_button.name = option
		LAZYSET(options, option, radial_button)

	var/choice = show_radial_menu(user, painting, options, radius = 42, require_near = TRUE, use_labels = TRUE, check_locs = list(painting))
	if(!choice || QDELETED(src) || QDELETED(painting) || QDELETED(user) || user.incapacitated() || tank_module.loc != src)
		return FALSE

	if(choice == "Decal")
		choice = null
		options = list()
		for(var/decal_name in tank_module.available_decals)
			var/image/radial_button = new /image
			radial_button.name = decal_name
			LAZYSET(options, decal_name, radial_button)
		choice = show_radial_menu(user, painting, options, radius = 42, require_near = TRUE, use_labels = TRUE, check_locs = list(painting))
		if(!choice || QDELETED(src) || QDELETED(painting) || QDELETED(user) || user.incapacitated() || tank_module.loc != src)
			return FALSE

	. = TRUE
	switch(choice)
		if("Eyes")
			tank_module.eye_color =   painting.paint_color
		if("Armour")
			tank_module.armor_color = painting.paint_color
		if("Body")
			tank_module.base_color =  painting.paint_color
		if("Clear Colors")
			tank_module.eye_color =   initial(tank_module.eye_color)
			tank_module.armor_color = initial(tank_module.armor_color)
			tank_module.base_color =  initial(tank_module.base_color)
		if("Clear Decals")
			tank_module.decals = null
		else
			if(choice in tank_module.available_decals)
				LAZYSET(tank_module.decals, tank_module.available_decals[choice], painting.paint_color)
			else
				. = FALSE
	if(.)
		queue_icon_update()
