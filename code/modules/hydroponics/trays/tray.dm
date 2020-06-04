/obj/machinery/portable_atmospherics/hydroponics
	name = "hydroponics tray"
	desc = "A mechanical basin designed to nurture plants. It has various useful sensors."
	icon = 'icons/obj/hydroponics/hydroponics_machines.dmi'
	icon_state = "hydrotray3"
	density = 1
	anchored = 1
	atom_flags = ATOM_FLAG_OPEN_CONTAINER
	volume = 100
	construct_state = /decl/machine_construction/default/panel_closed
	uncreated_component_parts = null
	stat_immune = 0

	var/base_name = "tray"
	var/mechanical = TRUE      // Set to 0 to stop it from drawing the alert lights.
	var/tray_light = 5         // Supplied lighting.
	var/closed_system = FALSE  // If set, the tray will attempt to take atmos from a pipe.

/obj/machinery/portable_atmospherics/hydroponics/return_air()
	if(closed_system && (connected_port || holding))
		. = air_contents
	else
		. = ..()

/obj/machinery/portable_atmospherics/hydroponics/on_update_icon()
	. = ..()

	var/list/new_overlays
	var/toxins = 0
	var/can_harvest =   FALSE
	var/lowest_health = INFINITY
	var/nutrilevel =    INFINITY
	var/waterlevel =    INFINITY

	for(var/obj/effect/plant/plant in src)
		LAZYADD(new_overlays, plant)
		lowest_health = min(lowest_health, plant.health)
		if(plant.plant_ready_for_harvest)
			can_harvest = TRUE
		toxins =     max(toxins,     LAZYACCESS(plant.chem_doses, /decl/plant_effect/poison))
		nutrilevel = min(nutrilevel, LAZYACCESS(plant.chem_doses, /decl/plant_effect/consumption))
		waterlevel = min(waterlevel, LAZYACCESS(plant.chem_doses, /decl/plant_effect/consumption/water))

	if(mechanical)
		if(closed_system)
			LAZYADD(new_overlays, "hydrocover2")
		if(lowest_health <= 25)
			LAZYADD(new_overlays, "over_lowhealth3")
		var/datum/extension/plantable/planter = get_extension(src, /datum/extension/plantable)
		if(toxins >= 40 || (planter && LAZYACCESS(planter.planter_effects, /decl/planter_effect/invaders) >= 5 || LAZYACCESS(planter.planter_effects, /decl/planter_effect/invaders/weeds) >= 5))
			LAZYADD(new_overlays, "over_alert3")
		if(can_harvest)
			LAZYADD(new_overlays, "over_harvest3")
		if(waterlevel <= 10)
			LAZYADD(new_overlays, "over_lowwater3")
		if(nutrilevel <= 2)
			LAZYADD(new_overlays, "over_lownutri3")
	overlays = new_overlays

/obj/machinery/portable_atmospherics/hydroponics/get_lumcount(var/minlum, var/maxlum)
	if(closed_system)
		. = Clamp(tray_light, minlum, maxlum)
	. = max(..(), .)

/obj/machinery/portable_atmospherics/hydroponics/Initialize()
	set_extension(src, /datum/extension/plantable)
	. = ..()
	
/obj/machinery/portable_atmospherics/hydroponics/AltClick()
	if(mechanical && !usr.incapacitated() && Adjacent(usr))
		close_lid(usr)
		return 1
	return ..()

/obj/machinery/portable_atmospherics/hydroponics/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1
	if(istype(mover) && mover.checkpass(PASS_FLAG_TABLE))
		return 1
	else
		return !density

/obj/machinery/portable_atmospherics/hydroponics/verb/setlight()
	set name = "Set Light"
	set category = "Object"
	set src in view(1)

	if(usr.incapacitated())
		return
	if(ishuman(usr) || istype(usr, /mob/living/silicon/robot))
		var/new_light = input("Specify a light level.") as null|anything in list(0,1,2,3,4,5,6,7,8,9,10)
		if(new_light)
			tray_light = new_light
			to_chat(usr, "You set the tray to a light level of [tray_light] lumens.")
	return

/obj/machinery/portable_atmospherics/hydroponics/attackby(var/obj/item/O, var/mob/user)
	if(mechanical && isWrench(O))
		//If there's a connector here, the portable_atmospherics setup can handle it.
		if(locate(/obj/machinery/atmospherics/portables_connector) in loc)
			return ..()
		playsound(loc, 'sound/items/Ratchet.ogg', 50, 1)
		anchored = !anchored
		to_chat(user, "You [anchored ? "wrench" : "unwrench"] \the [src].")
		return TRUE
	. = ..()
	if(mechanical && !.)
		return component_attackby(O, user)

/obj/machinery/portable_atmospherics/hydroponics/verb/close_lid_verb()
	set name = "Toggle Tray Lid"
	set category = "Object"
	set src in view(1)
	if(usr.incapacitated())
		return

	if(ishuman(usr) || istype(usr, /mob/living/silicon/robot))
		close_lid(usr)
	return

/obj/machinery/portable_atmospherics/hydroponics/proc/close_lid(var/mob/living/user)
	closed_system = !closed_system
	to_chat(user, "You [closed_system ? "close" : "open"] the tray's lid.")
	update_icon()
