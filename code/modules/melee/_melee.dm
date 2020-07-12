/decl/weapon_attack
	var/name = "strike"
	var/strike_past_tense = "struck"
	var/delay = 0.4 SECONDS
	var/strike_icon_state = "slash"
	var/marker_type = /obj/effect/melee_marker
	var/list/strike_area

/decl/weapon_attack/thrust
	name = "thrust"
	delay = 0.4 SECONDS
	strike_past_tense = "pierced"
	strike_area = list(
		list(0,1),
		list(0,2)
	)

/decl/weapon_attack/slash
	name = "slash"
	delay = 0.4 SECONDS
	strike_past_tense = "slashed"
	strike_area = list(
		list(-1,1),
		list(0,1),
		list(1,1)
	)

/obj/effect/melee_marker
	name = "approaching melee attack"
	desc = "Watch out!"
	icon = 'icons/effects/melee_marker.dmi'
	icon_state = "marker"
	alpha = 0
	simulated = FALSE

/obj/effect/melee_marker/Initialize(var/ml, var/attack_delay)
	. = ..(ml)
	color = COLOR_YELLOW
	animate(src, alpha = 255, color = COLOR_RED, time = attack_delay)

/obj/effect/strike_marker
	icon = 'icons/effects/melee_marker.dmi'
	icon_state = "blank"
	simulated = FALSE

/obj/effect/strike_marker/proc/do_strike(var/decl/weapon_attack/pending_attack, var/mob/pending_attacker, var/obj/item/pending_attacking_with)
	set waitfor = FALSE
	name = pending_attack.name
	flick(pending_attack.strike_icon_state, src)
	for(var/mob/M in loc)
		pending_attacking_with.resolve_attackby(M, pending_attacker)
	sleep(1 SECOND)
	qdel(src)
	
/decl/weapon_attack/proc/mark_strike_area(var/mob/attacker, var/atom/movable/attacking_with, var/atom/target)

	attacking_with = attacking_with || attacker
	var/turf/origin = get_turf(attacker)
	var/turf/last_turf = origin
	var/attack_dir = (target && get_dist(origin, get_turf(target))) || attacker.dir
	for(var/point = 1 to length(strike_area))

		var/list/point_to_strike = strike_area[point]
		var/use_x = attacker.x
		var/use_y = attacker.y
		if(attack_dir & NORTH)
			use_x += point_to_strike[1]
			use_y += point_to_strike[2]
		else if(attack_dir & SOUTH)
			use_x -= point_to_strike[1]
			use_y -= point_to_strike[2]
		else if(attack_dir & EAST)
			use_x += point_to_strike[2]
			use_y += point_to_strike[1]
		else if(attack_dir & WEST)
			use_x -= point_to_strike[2]
			use_y -= point_to_strike[1]

		var/turf/marking = locate(use_x, use_y, attacker.z)
		if(marking && last_turf.CanPass(attacking_with, marking) && origin.CanPass(attacking_with, marking))
			last_turf = marking
			var/image/I = image(null)
			I.appearance = attacking_with
			I.pixel_x = 0
			I.pixel_y = 0
			I.pixel_z = 0
			I.pixel_w = 0
			I.layer = FLOAT_LAYER
			var/obj/effect/marker = new marker_type(marking, src)
			I.plane = marker.plane
			marker.overlays += I
			LAZYADD(., marker)

/decl/weapon_attack/proc/show_message(var/atom/target, var/atom/target)
	return

/mob/Bump(var/atom/A)
	if(a_intent == I_HURT && !incapacitated())
		var/obj/item/weapon = get_active_hand()
		if(weapon?.try_special_attack(src, A))
			return
	. = ..()

/obj/item
	var/performing_special_attack = FALSE
	var/list/special_attack_types

/obj/item/sword
	special_attack_types = list(/decl/weapon_attack/slash)

/obj/item/twohanded/spear
	special_attack_types = list(/decl/weapon_attack/thrust)

/obj/item/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(performing_special_attack || proximity_flag || !try_special_attack(user, target))
		return ..()

/obj/item/proc/try_special_attack(var/mob/user, var/atom/target)
	if(!length(special_attack_types))
		return FALSE
	var/attack_type = pick(special_attack_types)
	var/decl/weapon_attack/pending_attack = decls_repository.get_decl(attack_type)
	var/list/markers = pending_attack.mark_strike_area(user, src)
	if(!length(markers))
		return FALSE
	performing_special_attack = TRUE
	var/initial_attacker_loc = user.loc
	var/initial_attacker_dir = user.dir
	var/attack_delay = pending_attack.delay // todo: modify by combat skill
	addtimer(CALLBACK(src, /obj/item/proc/finish_special_attack, markers, user, pending_attack), attack_delay)
	while(performing_special_attack)
		if(QDELETED(src) || QDELETED(user))
			break
		if(user.get_active_hand() != src)
			break
		if(user.loc != initial_attacker_loc || user.dir != initial_attacker_dir)
			break
		if(user.incapacitated())
			break
		sleep(1)

	performing_special_attack = FALSE
	for(var/atom/movable/marker in markers)
		if(!QDELETED(marker))
			qdel(marker)
	return TRUE

/obj/item/proc/finish_special_attack(var/list/markers, var/mob/user, var/decl/weapon_attack/pending_attack)
	performing_special_attack = FALSE
	var/hit_something
	for(var/atom/movable/marker in markers)
		if(!QDELETED(marker))
			hit_something = get_turf(marker)
			var/obj/effect/strike_marker/strike = new(get_turf(marker))
			strike.do_strike(pending_attack, user, src)
			qdel(marker)
	if(hit_something)
		user.do_attack_animation(hit_something, src)
