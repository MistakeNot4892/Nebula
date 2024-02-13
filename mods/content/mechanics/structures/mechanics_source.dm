/obj/structure/mechanical/source
	name = "mechanical power source"
	icon = 'mods/content/mechanics/icons/debug.dmi'
	icon_state = "junction"
	color = COLOR_GREEN

/obj/structure/mechanical/source/mapped
	anchored = TRUE

/obj/structure/mechanical/source/on_update_icon()
	. = ..()
	color = COLOR_GREEN

/obj/structure/mechanical/source/is_mechanical_source()
	return TRUE

/obj/structure/mechanical/source/get_mechanical_connection_dirs()
	return list(dir)

/obj/structure/mechanical/source/mechanical_can_connect(obj/structure/mechanical/connecting)
	. = connecting.z == z && istype(connecting, /obj/structure/mechanical/axle) && (get_dir(src, connecting) == dir)
