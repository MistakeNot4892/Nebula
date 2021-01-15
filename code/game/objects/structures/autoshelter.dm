/datum/extension/autoshelter_component
	var/obj/structure/autoshelter_control/controller

/obj/item/autoshelter_control
	icon = 'icons/obj/items/autoshelter_controller.dmi'
	icon_state = ICON_STATE_WORLD
	var/obj/machinery/portable_atmospherics/canister/air_supply = /obj/machinery/portable_atmospherics/canister/air
	var/list/walls =  list()
	var/list/floors = list()
	var/list/doors =  list()
	var/deployed = FALSE
	var/floor_space_x = 3
	var/floor_space_y = 3
	var/num_doors = 1

	var/door_type =  /obj/structure/inflatable/door/autoshelter
	var/wall_type =  /obj/structure/inflatable/wall/autoshelter
	var/floor_type = /obj/structure/autoshelter_floor

/obj/item/autoshelter_control/Initialize(ml, material_key)
	. = ..()
	if(ispath(air_supply))
		air_supply = new air_supply(src)
	for(var/i = 1 to num_doors)
		doors += new door_type(src)
	for(var/i = 1 to (floor_space_x * floor_space_y))
		floors += new floor_type(src)
	for(var/i = 1 to ((floor_space_x+1) * (floor_space_y+1)) - (length(doors) + length(floors)))
		walls += new wall_type(src)

/obj/item/autoshelter_control/proc/can_deploy(var/mob/user)
	if(!deployed)
		var/atom/movable/test = pick(walls)
		for(var/checkdir in GLOB.alldirs)
			var/turf/neighbor = get_step(T, checkdir)
			if(!neighbor.CanPass(src, neighbor))
				return FALSE
		return TRUE
	return FALSE

/obj/structure/autoshelter_floor
	icon = 'icons/obj/structures/autoshelter_floor.dmi'
	icon_state = "floor"

/obj/structure/inflatable/wall/autoshelter
	icon = 'icons/obj/structures/autoshelter_wall.dmi'

/obj/structure/inflatable/wall/autoshelter/Initialize()
	. = ..()
	set_extension(src, /datum/extension/autoshelter_component)

/obj/structure/inflatable/door/autoshelter
	icon = 'icons/obj/structures/autoshelter_door.dmi'

/obj/structure/inflatable/door/autoshelter/Initialize()
	. = ..()
	set_extension(src, /datum/extension/autoshelter_component)