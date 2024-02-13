/obj/structure/mechanical/junction
	name = "gear junction"
	icon = 'mods/content/mechanics/icons/junction.dmi'
	icon_state = "junction"
	material = /decl/material/solid/metal/steel

/obj/structure/mechanical/junction/get_mechanical_connection_dirs()
	return global.cardinal

/obj/structure/mechanical/junction/mechanical_can_connect(obj/structure/mechanical/connecting)
	. = !istype(connecting, /obj/structure/mechanical/junction)
	if(. && connecting.z != z)
		. = IsMultiZAdjacent(connecting)

/obj/structure/mechanical/junction/mapped
	anchored = TRUE