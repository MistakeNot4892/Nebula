/obj/structure/mechanical/axle
	name = "horizontal axle"
	icon = 'mods/content/mechanics/icons/axle.dmi'
	icon_state = "axle"
	anchored = FALSE

/obj/structure/mechanical/axle/Initialize()
	. = ..()
	set_dir(dir)

/obj/structure/mechanical/axle/get_mechanical_connection_overlay(key, obj/structure/mechanical/connected)
	if(istype(connected, /obj/structure/mechanical/axle))
		return null
	return ..()

/obj/structure/mechanical/axle/get_mechanical_connection_dirs()
	if(dir == EAST)
		var/static/list/horizontal_axle_dirs = list(EAST, WEST)
		return horizontal_axle_dirs
	var/static/list/vertical_axle_dirs = list(NORTH, SOUTH)
	return vertical_axle_dirs

// Axles can only be set to east or north.
/obj/structure/mechanical/axle/set_dir(ndir)
	if((ndir & WEST) || (ndir & EAST))
		ndir = EAST
	else
		ndir = NORTH
	return ..(ndir)

/obj/structure/mechanical/axle/mechanical_can_connect(obj/structure/mechanical/connecting)
	if(z == connecting.z)
		if(istype(connecting, /obj/structure/mechanical/junction))
			return TRUE
		if(istype(connecting, /obj/structure/mechanical/axle))
			return connecting.dir == dir
		if(istype(connecting, /obj/structure/mechanical/sink) || istype(connecting, /obj/structure/mechanical/source))
			var/connect_dir = get_dir(src, connecting)
			if(dir == EAST)
				return connect_dir == EAST || connect_dir == WEST
			if(dir == NORTH)
				return connect_dir == NORTH || connect_dir == SOUTH
	return FALSE

/obj/structure/mechanical/axle/mapped
	anchored = TRUE
