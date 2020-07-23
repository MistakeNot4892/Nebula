/mob/living/simple_animal/spiderling
	name = "spiderling"
	desc = "It never stays still for long."
	icon = 'icons/mob/spiderlings.dmi'
	icon_state = "brown"
	anchored = 0
	layer = BELOW_OBJ_LAYER
	health = 3
	max_gas = list(
		/decl/material/gas/methyl_bromide = 0,
		/decl/material/gas/chlorine = 1, 
		/decl/material/gas/carbon_dioxide = 5
	)
	response_harm = "stomps on"
	density = FALSE
	can_escape = TRUE
	can_pull_size = ITEM_SIZE_TINY
	can_pull_mobs = MOB_PULL_NONE

	var/dormant = FALSE
	var/mob/living/simple_animal/hostile/giant_spider/greater_form
	var/last_itch = 0
	var/amount_grown = -1
	var/obj/machinery/atmospherics/unary/vent_pump/entry_vent
	var/travelling_in_vent = 0
	var/growth_chance = 50 // % chance of beginning growth, and eventually become a beautiful death machine
	var/shift_range = 6
	var/castes = list(
		/mob/living/simple_animal/hostile/giant_spider = 2,
		/mob/living/simple_animal/hostile/giant_spider/guard = 2,
		/mob/living/simple_animal/hostile/giant_spider/nurse = 2,
		/mob/living/simple_animal/hostile/giant_spider/spitter = 2,
		/mob/living/simple_animal/hostile/giant_spider/hunter = 1
	)

/mob/living/simple_animal/spiderling/Initialize(var/mapload, var/atom/parent)
	. = ..()
	pixel_x = rand(-shift_range, shift_range)
	pixel_y = rand(-shift_range, shift_range)
	if(prob(growth_chance))
		amount_grown = 1
		greater_form = pickweight(castes)
		icon_state = initial(greater_form.icon_state)
		dormant = FALSE
	else
		icon_state = pick(icon_states(icon))
	icon_living = icon_state
	icon_dead = icon_state
	if(dormant)
		STOP_PROCESSING(SSmobs, src)
		GLOB.moved_event.register(src, src, /mob/living/simple_animal/spiderling/proc/disturbed)
	if(parent)
		color = parent.color

/mob/living/simple_animal/spiderling/attackby(var/obj/item/W, var/mob/user)
	. = ..()
	disturbed()

/mob/living/simple_animal/spiderling/Crossed(var/mob/living/L)
	if(istype(L) && L.mob_size > MOB_SIZE_TINY)
		disturbed()

/mob/living/simple_animal/spiderling/Destroy()
	if(dormant)
		GLOB.moved_event.unregister(src, src, /mob/living/simple_animal/spiderling/proc/disturbed)
	. = ..()
	
/mob/living/simple_animal/spiderling/proc/disturbed()
	if(dormant)
		dormant = FALSE
		GLOB.moved_event.unregister(src, src, /mob/living/simple_animal/spiderling/proc/disturbed)
		START_PROCESSING(SSmobs, src)

/mob/living/simple_animal/spiderling/proc/check_vent(obj/machinery/atmospherics/unary/vent_pump/exit_vent)
	if(QDELETED(exit_vent) || exit_vent.welded) // If it's qdeleted we probably were too, but in that case we won't be making this call due to timer cleanup.
		forceMove(get_turf(entry_vent))
		entry_vent = null
		return TRUE

/mob/living/simple_animal/spiderling/proc/start_vent_moving(obj/machinery/atmospherics/unary/vent_pump/exit_vent, var/travel_time)
	if(check_vent(exit_vent))
		return
	if(prob(50))
		src.visible_message(SPAN_NOTICE("You hear something squeezing through the ventilation ducts."),2)
	forceMove(exit_vent)
	addtimer(CALLBACK(src, .proc/end_vent_moving, exit_vent), travel_time)

/mob/living/simple_animal/spiderling/proc/end_vent_moving(obj/machinery/atmospherics/unary/vent_pump/exit_vent)
	if(check_vent(exit_vent))
		return
	forceMove(get_turf(exit_vent))
	travelling_in_vent = FALSE
	entry_vent = null

/mob/living/simple_animal/spiderling/Life()
	. = ..()

	if(!.)
		return FALSE

	if(travelling_in_vent)
		if(istype(src.loc, /turf))
			travelling_in_vent = 0
			entry_vent = null

	if(entry_vent)
		if(get_dist(src, entry_vent) <= 1)
			if(entry_vent.network && entry_vent.network.normal_members.len)
				var/list/vents = list()
				for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in entry_vent.network.normal_members)
					vents.Add(temp_vent)
				if(!vents.len)
					entry_vent = null
					return
				var/obj/machinery/atmospherics/unary/vent_pump/exit_vent = pick(vents)

				forceMove(entry_vent)
				var/travel_time = round(get_dist(loc, exit_vent.loc) / 2)
				addtimer(CALLBACK(src, .proc/start_vent_moving, exit_vent, travel_time), travel_time + rand(20,60))
				travelling_in_vent = TRUE
				return
			else
				entry_vent = null

	if(isturf(loc))

		if(amount_grown > 0)
			amount_grown += rand(0,1)
			if(amount_grown >= 100)
				new greater_form(src.loc, src)
				qdel(src)

		if(prob(25))
			var/list/nearby = RANGE_TURFS(src, 5) - loc
			if(nearby.len)
				var/target_atom = pick(nearby)
				walk_to(src, target_atom, 5)
				if(prob(10))
					src.visible_message(SPAN_NOTICE("\The [src] skitters[pick(" away"," around","")]."))
					// Reduces the risk of spiderlings hanging out at the extreme ranges of the shift range.
					var/min_x = pixel_x <= -shift_range ? 0 : -2
					var/max_x = pixel_x >=  shift_range ? 0 :  2
					var/min_y = pixel_y <= -shift_range ? 0 : -2
					var/max_y = pixel_y >=  shift_range ? 0 :  2
					pixel_x = Clamp(pixel_x + rand(min_x, max_x), -shift_range, shift_range)
					pixel_y = Clamp(pixel_y + rand(min_y, max_y), -shift_range, shift_range)
		else if(prob(5))
			//vent crawl!
			for(var/obj/machinery/atmospherics/unary/vent_pump/v in view(7,src))
				if(!v.welded)
					entry_vent = v
					walk_to(src, entry_vent, 5)
					break

	else if(isorgan(loc))
		if(!amount_grown)
			amount_grown = 1
		if(amount_grown > 0)
			amount_grown += rand(1,2)
		var/obj/item/organ/external/O = loc
		if(!O.owner || O.owner.stat == DEAD || amount_grown > 80)
			amount_grown = 20 //reset amount_grown so that people have some time to react to spiderlings before they grow big
			O.implants -= src
			forceMove(O.owner ? O.owner.loc : O.loc)
			src.visible_message(SPAN_WARNING("\A [src] emerges from inside [O.owner ? "[O.owner]\'s [O.name]" : "\the [O]"]!"))
			if(O.owner)
				O.owner.apply_damage(5, BRUTE, O.organ_tag)
				O.owner.apply_damage(3, TOX, O.organ_tag)
		else if(prob(1))
			O.owner.apply_damage(1, TOX, O.organ_tag)
			if(world.time > last_itch + 30 SECONDS)
				last_itch = world.time
				to_chat(O.owner, SPAN_NOTICE("Your [O.name] itches..."))

	else if(prob(1))
		src.visible_message(SPAN_NOTICE("\The [src] skitters."))

/mob/living/simple_animal/spiderling/death(gibbed, deathmessage, show_dead_message)
	. = ..()
	if(!QDELETED(src) && isturf(loc))
		new /obj/effect/decal/cleanable/spiderling_remains(loc)
		qdel(src)

/mob/living/simple_animal/spiderling/dormant
	growth_chance = 0
	dormant = TRUE
