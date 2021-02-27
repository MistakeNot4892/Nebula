/obj/item/robot_module/platform
	var/pupil_color =     COLOR_CYAN
	var/base_color =      COLOR_WHITE
	var/eye_color =       COLOR_BEIGE
	var/armor_color =    "#68a2f2"
	var/user_icon =       'icons/mob/robots_thinktank.dmi'
	var/user_icon_state = "tachi"

	var/list/decals
	var/list/available_decals = list(
		"Stripe" = "stripe", 
		"Vertical Stripe" = "stripe_vertical"
	)

/obj/item/robot_module/platform/verb/set_eye_colour()
	set name = "Set Eye Colour"
	set desc = "Select an eye colour to use."
	set category = "Silicon Commands"
	set src in usr

	var/new_pupil_color = input(usr, "Select a pupil colour.", "Pupil Colour Selection") as color|null
	if(usr.incapacitated() || QDELETED(usr) || QDELETED(src) || loc != usr)
		return
	
	pupil_color = new_pupil_color || initial(pupil_color)
	usr.update_icon()

/obj/item/robot_module/platform/explorer
	armor_color = "#528052"
	eye_color =   "#7b7b46"
	decals = list(
		"stripe_vertical" = "#52b8b8",
		"stripe" =          "#52b8b8"
	)
