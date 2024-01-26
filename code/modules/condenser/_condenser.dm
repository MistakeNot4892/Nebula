// Kinds of exotic matter the condenser can produce?
// - exotic matter:
//     negative mass, used for wormhole tech
//     nothing special to produce, just tons of power
// - dark matter:
//     gravitational effects, used for gravity manipulation
// - supermatter:
//     should need metallic hydrogen or something from a fusion core
//     some kind of handwavium that explains why it appears to be an infinite source of heat
// - degenerate matter:
//     very dense
// - metallic hydrogen:
//     room temperature superconductor
//     probably should be a fusion product

/obj/machinery/exotic_matter_condenser
	name = "\improper Casimir condenser"
	desc = "A large, bulbous machine that uses vast quantities of power to condense exotic matter out of raw firmament."
	icon = 'icons/obj/condenser.dmi'
	icon_state = ICON_STATE_WORLD
	pixel_x = -8
	layer = ABOVE_HUMAN_LAYER
	density = TRUE
	use_power = POWER_USE_IDLE
	idle_power_usage = 50
	active_power_usage = 150 KILOWATTS // it is absurdly power hungry
	anchored = FALSE
	construct_state = /decl/machine_construction/default/panel_closed
	base_type = /obj/machinery/exotic_matter_condenser
	stock_part_presets = list(/decl/stock_part_preset/terminal_setup)
	var/obj/abstract/condenser_glow/glow

/obj/abstract/condenser_glow
	icon = 'icons/obj/condenser.dmi'
	icon_state = "world_glow"
	alpha = 0
	invisibility = 0
	layer = ABOVE_LIGHTING_LAYER
	plane = ABOVE_LIGHTING_PLANE

/obj/machinery/exotic_matter_condenser/Initialize()
	glow = new
	add_vis_contents(src, glow)
	return ..()

/obj/machinery/exotic_matter_condenser/Destroy()
	clear_vis_contents(src)
	QDEL_NULL(glow)
	return ..()

/obj/machinery/exotic_matter_condenser/proc/get_offline_glow_color()
	return COLOR_NAVY_BLUE

/obj/machinery/exotic_matter_condenser/proc/get_idle_glow_color()
	return pick(COLOR_NAVY_BLUE, COLOR_PURPLE, COLOR_INDIGO, COLOR_BLUE)

/obj/machinery/exotic_matter_condenser/proc/get_active_glow_color()
	return pick(COLOR_CYAN, COLOR_SKY_BLUE, COLOR_VIOLET, COLOR_CYAN_BLUE)

/obj/machinery/exotic_matter_condenser/on_update_icon()
	. = ..()
	switch(use_power)
		if(POWER_USE_OFF)
			animate(glow, time = SSobj.wait, color = get_offline_glow_color(), alpha = 0)
		if(POWER_USE_IDLE)
			animate(glow, time = SSobj.wait, color = get_idle_glow_color(), alpha = 45)
		if(POWER_USE_ACTIVE)
			animate(glow, time = SSobj.wait, color = get_active_glow_color(), alpha = rand(90, 180))

/obj/machinery/exotic_matter_condenser/attack_hand(mob/user)
	if(user.a_intent != I_HURT)
		playsound(src, "switch", 30)
		var/on = (use_power != POWER_USE_OFF)
		update_use_power(on ? POWER_USE_OFF : POWER_USE_IDLE)
		return TRUE
	return ..()

/obj/machinery/exotic_matter_condenser/attackby()
	if(use_power != POWER_USE_OFF)
		update_use_power(use_power == POWER_USE_IDLE ? POWER_USE_ACTIVE : POWER_USE_IDLE)
	return ..()

/obj/machinery/exotic_matter_condenser/power_change()
	. = ..()
	if(use_power == POWER_USE_OFF || (stat & (BROKEN|NOPOWER)))
		set_light(0)
	else if(use_power == POWER_USE_IDLE)
		set_light(2, 0.3, get_idle_glow_color())
	else if(use_power == POWER_USE_ACTIVE)
		set_light(3, 0.5, get_active_glow_color())

/obj/machinery/exotic_matter_condenser/Process()
	. = ..()
	update_icon()
