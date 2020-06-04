/obj/machinery/portable_atmospherics/hydroponics/soil
	name = "soil"
	desc = "A mound of earth. You could plant some seeds here."
	icon_state = "soil"
	density = 0
	use_power = POWER_USE_OFF
	stat_immune = NOINPUT | NOSCREEN | NOPOWER
	mechanical = 0
	tray_light = 0

/obj/machinery/portable_atmospherics/hydroponics/soil/attackby(var/obj/item/O, var/mob/user)
	if(istype(O,/obj/item/tank))
		return
	else
		..()

/obj/machinery/portable_atmospherics/hydroponics/soil/Initialize()
	. = ..()
	verbs -= /obj/machinery/portable_atmospherics/hydroponics/verb/close_lid_verb
	verbs -= /obj/machinery/portable_atmospherics/hydroponics/verb/setlight

/obj/machinery/portable_atmospherics/hydroponics/soil/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/portable_atmospherics/hydroponics/soil/invisible
	name = "plant"
	desc = null
	icon = 'icons/obj/seeds.dmi'
	icon_state = "blank"
