/obj/screen/uibox
	name = "ui box"
	icon = 'icons/screen/uibox_tex.dmi'
	icon_state = "blank"
	screen_loc = "CENTER,CENTER"
	appearance_flags = RESET_TRANSFORM | RESET_ALPHA | RESET_COLOR | KEEP_TOGETHER
	color = COLOR_LIGHT_CYAN

	var/min_unit  // Icon size of composite icon sections.
	var/scale_gap // Minus corners + self
	var/half_step // Used for halfpoint offsetting.

	var/scale_borders = FALSE // Whether to scale or tile the border images.
	var/scale_fill = FALSE    // Whether to scale or tile the central fill images.
	var/x_bound = 0           // Current target horizontal size in pixels.
	var/y_bound = 0           // Current target vertical size in pixels.
	var/x_pos = 200           // Leftmost x coordinate.
	var/y_pos = 200           // Bottommost y coordinate.

	// GC/update refs.
	var/client/owner
	var/list/elements
	var/static/list/element_types = list(
		/obj/screen/uielem/background,
		/obj/screen/uielem/close,
		/obj/screen/uielem/move,
		/obj/screen/uielem/resize
	)

/obj/screen/uibox/proc/set_icon(var/new_icon)

	// Set our helper vars for offsets and scaling.
	icon = new_icon
	var/icon/iconed_icon = icon(icon)
	min_unit = max(iconed_icon.Height(), iconed_icon.Width())
	scale_gap = min_unit * 2
	half_step = min_unit * 0.5

	// Refresh everything.
	set_loc(x_pos, y_pos)
	set_bounds(x_bound, y_bound)
	for(var/atom/element AS_ANYTHING in elements)
		element.icon = icon

/obj/screen/uibox/Initialize()

	for(var/elem in element_types)
		var/obj/screen/uielem/elem_instance = new elem
		elem_instance.master_box = src
		LAZYADD(elements, elem_instance)
		add_vis_contents(src, elem_instance)

	set_icon(icon)

	. = ..()

/obj/screen/uibox/proc/focus()
	if(owner)
		owner.screen -= src
		owner.screen += src
	
/obj/screen/uibox/proc/close()
	qdel(src)

/obj/screen/uibox/Destroy()
	if(owner)
		owner.screen -= src
		owner.screen -= elements
		owner = null
	QDEL_NULL_LIST(elements)
	return ..()

/obj/screen/uibox/proc/set_owner(var/client/new_owner)

	if(owner == new_owner)
		return

	if(owner)
		owner.screen -= src
		owner.screen -= elements

	owner = new_owner
	owner.screen |= src
	owner.screen |= elements

/obj/screen/uibox/proc/set_bounds(ux, uy)

	// Round our values to the component size to avoid 
	// weird scaling gaps or overlaps in textured icons.
	var/new_x_bound = max(64, FLOOR(ux/min_unit)*min_unit)
	var/new_y_bound = max(64, FLOOR(uy/min_unit)*min_unit)
	if(new_x_bound != x_bound || new_y_bound != x_bound)
		x_bound = new_x_bound
		y_bound = new_y_bound

		// Update our button positions.
		for(var/obj/screen/uielem/elem AS_ANYTHING in elements)
			elem.update_screen_offsets()

		update_icon()

/obj/screen/uibox/proc/set_loc(lx, ly)
	var/new_lx = max(0, lx)
	var/new_ly = max(0, ly)
	if(new_lx != x_pos || new_ly != y_pos)
		x_pos = new_lx
		y_pos = new_ly
		screen_loc = "LEFT:[x_pos],BOTTOM:[y_pos]"

/image/proc/Scale(var/xs, var/ys)
	var/matrix/M = matrix()
	M.Scale(xs, ys)
	transform = M

/obj/screen/uibox/on_update_icon()
	. = ..()
	for(var/obj/screen/uielem/elem AS_ANYTHING in elements)
		elem.update_icon()

/obj/screen/uielem
	icon = 'icons/screen/uibox.dmi'
	vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE
	var/obj/screen/uibox/master_box

/obj/screen/uielem/Click(location, control, params)
	. = ..()
	if(master_box)
		master_box.focus()

/obj/screen/uielem/Destroy()
	if(master_box)
		LAZYREMOVE(master_box.elements, src)
		master_box = null
	return ..()

/obj/screen/uielem/proc/update_screen_offsets()
	return

/obj/screen/uielem/close
	name = "Close Window"
	icon_state = "close"

/obj/screen/uielem/close/update_screen_offsets()
	if(master_box)
		pixel_x =  master_box.x_bound - master_box.half_step
		pixel_y =  master_box.y_bound - master_box.half_step

/obj/screen/uielem/close/Click(location, control, params)
	if(master_box)
		master_box.close()

/obj/screen/uielem/move
	name = "Move Window"
	icon_state = "move"
	pixel_x = -2
	pixel_y = -2

/obj/screen/uielem/move/MouseDrag(over_object, src_location, over_location, src_control, over_control, params)
	if(master_box)
		master_box.focus()
		var/list/paramslist = params2list(params)
		var/list/screenloc_comp = splittext(paramslist["screen-loc"], ",")
		var/list/screenloc_comp_x = splittext(screenloc_comp[1], ":")
		var/list/screenloc_comp_y = splittext(screenloc_comp[2], ":")
		master_box.set_loc(
			((text2num(screenloc_comp_x[1])-1) * world.icon_size) + text2num(screenloc_comp_x[2]),
			((text2num(screenloc_comp_y[1])-2) * world.icon_size) + text2num(screenloc_comp_y[2])
		)

/obj/screen/uielem/resize
	name = "Resize Window"
	icon_state = "resize"

/obj/screen/uielem/resize/update_screen_offsets()
	if(master_box)
		pixel_x = master_box.x_bound - master_box.min_unit
		pixel_y = master_box.y_bound - master_box.half_step

/obj/screen/uielem/resize/MouseDrag(over_object, src_location, over_location, src_control, over_control, params)
	if(master_box)
		master_box.focus()
		var/list/paramslist = params2list(params)
		var/list/screenloc_comp = splittext(paramslist["screen-loc"], ",")
		var/list/screenloc_comp_x = splittext(screenloc_comp[1], ":")
		var/list/screenloc_comp_y = splittext(screenloc_comp[2], ":")
		master_box.set_bounds(
			(((text2num(screenloc_comp_x[1])-1) * world.icon_size) + text2num(screenloc_comp_x[2]))-master_box.x_pos,
			(((text2num(screenloc_comp_y[1])-2) * world.icon_size) + text2num(screenloc_comp_y[2]))-master_box.y_pos
		)

/obj/screen/uielem/background
	icon_state = "bottomleft"
	mouse_opacity = 0
	alpha = 180

/obj/screen/uielem/background/on_update_icon()

	. = ..()
	if(!master_box)
		return

	cut_overlays()

	// Draw the corners - the bottom left corner is our background base icon and doesn't need to be added.
	var/image/I = image(icon, "topleft")
	I.pixel_y = master_box.y_bound - master_box.min_unit
	add_overlay(I)
	I = image(icon, "topright")
	I.pixel_x = master_box.x_bound - master_box.min_unit
	I.pixel_y = master_box.y_bound - master_box.min_unit
	add_overlay(I)
	I = image(icon, "bottomright")
	I.pixel_x = master_box.x_bound - master_box.min_unit
	add_overlay(I)

	// Draw the border - either scale and offset (for non-textured boxes) or repeat to fill.
	if(master_box.scale_borders)

		I = image(icon, "left")
		I.Scale(1, (master_box.y_bound - master_box.scale_gap) / master_box.min_unit)
		I.pixel_y = (master_box.y_bound / 2) - master_box.half_step
		add_overlay(I)

		I = image(icon, "right")
		I.Scale(1, (master_box.y_bound - master_box.scale_gap) / master_box.min_unit)
		I.pixel_x = master_box.x_bound-master_box.min_unit
		I.pixel_y = (master_box.y_bound / 2) - master_box.half_step
		add_overlay(I)

		I = image(icon, "top")
		I.Scale((master_box.x_bound - master_box.scale_gap) / master_box.min_unit, 1)
		I.pixel_x = (master_box.x_bound / 2) - master_box.half_step
		I.pixel_y = master_box.y_bound-master_box.min_unit
		add_overlay(I)

		I = image(icon, "bottom")
		I.Scale((master_box.x_bound - master_box.scale_gap) / master_box.min_unit, 1)
		I.pixel_x = (master_box.x_bound / 2) - master_box.half_step
		add_overlay(I)
	
	else

		for(var/x_offset = 0 to ((master_box.x_bound-master_box.scale_gap)/master_box.min_unit)-1)

			I = image(icon, "top")
			I.pixel_x = master_box.min_unit + (x_offset * master_box.min_unit)
			I.pixel_y = master_box.y_bound-master_box.min_unit
			add_overlay(I)

			I = image(icon, "bottom")
			I.pixel_x = master_box.min_unit + (x_offset * master_box.min_unit)
			add_overlay(I)

		for(var/y_offset = 0 to ((master_box.y_bound-master_box.scale_gap)/master_box.min_unit)-1)

			I = image(icon, "left")
			I.pixel_y = master_box.min_unit + (y_offset * master_box.min_unit)
			add_overlay(I)

			I = image(icon, "right")
			I.pixel_x = master_box.x_bound-master_box.min_unit
			I.pixel_y = master_box.min_unit + (y_offset * master_box.min_unit)
			add_overlay(I)

	// Draw the interior fill - same concept as above but on two axes.
	if(master_box.scale_fill)

		I = image(icon, "fill")
		I.pixel_x = (master_box.x_bound / 2) - master_box.half_step
		I.pixel_y = (master_box.y_bound / 2) - master_box.half_step
		I.Scale((master_box.x_bound - master_box.scale_gap) / master_box.min_unit, (master_box.y_bound - master_box.scale_gap) / master_box.min_unit)
		add_overlay(I)

	else

		for(var/x_offset = 0 to ((master_box.x_bound-master_box.scale_gap)/master_box.min_unit)-1)
			for(var/y_offset = 0 to ((master_box.y_bound-master_box.scale_gap)/master_box.min_unit)-1)
				I = image(icon, "fill")
				I.pixel_x = master_box.min_unit + (x_offset * master_box.min_unit)
				I.pixel_y = master_box.min_unit + (y_offset * master_box.min_unit)
				add_overlay(I)

	compile_overlays()

/obj/screen/uielem/background/Initialize()
	. =..()
	add_filter("glow", 1, list(type="drop_shadow", x = 0, y = 0, offset = 0, size = 4))

/mob/verb/debug_ui_box()
	set name = "Debug UI Box"
	set category = "Debug"

	var/ux = input(src, "Enter an X value", "Enter X Value", 120) as num
	var/uy = input(src, "Enter an X value", "Enter X Value", 120) as num

	var/obj/screen/uibox/box = new()
	box.set_owner(client)
	box.set_bounds(ux, uy)
