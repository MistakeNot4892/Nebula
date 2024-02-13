/obj/structure/mechanical/sink
	name = "mechanical power sink"
	icon = 'mods/content/mechanics/icons/debug.dmi'
	icon_state = "junction"
	color = COLOR_RED

/obj/structure/mechanical/sink/mapped
	anchored = TRUE

/obj/structure/mechanical/sink/on_update_icon()
	. = ..()
	color = COLOR_RED

/obj/structure/mechanical/sink/is_mechanical_sink()
	return TRUE

/obj/structure/mechanical/sink/get_mechanical_connection_dirs()
	return list(dir)

/obj/structure/mechanical/sink/mechanical_can_connect(obj/structure/mechanical/connecting)
	. = connecting.z == z && istype(connecting, /obj/structure/mechanical/axle) && (get_dir(src, connecting) == dir)
