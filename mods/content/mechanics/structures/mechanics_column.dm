/obj/structure/mechanical/column
	name = "vertical axle"
	icon = 'mods/content/mechanics/icons/column.dmi'
	icon_state = "column"

/obj/structure/mechanical/column/mechanical_can_connect(obj/structure/mechanical/connecting)
	. = istype(connecting, /obj/structure/mechanical/column) || istype(connecting, /obj/structure/mechanical/junction)
	if(. && connecting.z != z && !IsMultiZAdjacent(connecting))
		return FALSE

/obj/structure/mechanical/column/get_mechanical_connection_dirs()
	return global.dir_up_down

/obj/structure/mechanical/column/mapped
	anchored = TRUE
