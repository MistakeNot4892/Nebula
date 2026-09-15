/mob/living/simple_animal
	var/ranged_charge               = 0
	var/max_ranged_charge           = RANGED_CHARGE_NO_COST
	var/next_ranged_recharge        = 0
	var/ranged_recharge_time        = 2 SECONDS
	var/const/RANGED_CHARGE_NO_COST = -1

/mob/living/simple_animal/Initialize()
	. = ..()
	if(max_ranged_charge != RANGED_CHARGE_NO_COST)
		ranged_charge = max_ranged_charge

/mob/living/simple_animal/has_ranged_attack(atom/target)
	. = !!projectiletype && get_ranged_attack_distance() > 0
	if(!.)
		return
	// No charges!
	if(max_ranged_charge && max_ranged_charge != RANGED_CHARGE_NO_COST && ranged_charge <= 0)
		return FALSE
	// Too close, use melee instead.
	if(Adjacent(target))
		return FALSE
	// They are down, beat them violently instead.
	if(isliving(target))
		var/mob/living/victim = target
		return !victim.current_posture?.prone

/mob/living/simple_animal/proc/shoot_wrapper(target, location, user)
	if(shoot_at(target, location, user) && casingtype)
		new casingtype(loc)

/mob/living/simple_animal/proc/shoot_at(var/atom/target, var/atom/start)
	if(max_ranged_charge && max_ranged_charge != RANGED_CHARGE_NO_COST && ranged_charge <= 0)
		return FALSE
	if(!start)
		start = get_turf(src)
	if(!can_act() || !istype(target) || !istype(start) || target == start || !has_ranged_attack(target))
		return FALSE
	var/obj/item/projectile/A = new projectiletype(get_turf(start))
	if(!A)
		return FALSE
	playsound(start, projectilesound, 100, 1)
	A.launch(target, get_exposed_defense_zone(target), src)
	return TRUE

/mob/living/simple_animal/get_ranged_attack_distance()
	return ranged_range

/mob/living/simple_animal/handle_ranged_attack(atom/target)
	if(!istype(target) || !has_ranged_attack())
		return
	visible_message(SPAN_DANGER("\The [src] [fire_desc] at \the [target]!"))
	if(burst_projectile)
		var/datum/callback/shoot_cb = CALLBACK(src, PROC_REF(shoot_wrapper), target, loc)
		addtimer(shoot_cb, 1)
		addtimer(shoot_cb, 4)
		addtimer(shoot_cb, 6)
	else
		shoot_at(target, loc, src)
	if(max_ranged_charge && max_ranged_charge != RANGED_CHARGE_NO_COST)
		ranged_charge = max(0, ranged_charge-1)

/mob/living/simple_animal/handle_regular_status_updates()
	if(!(. = ..()))
		return
	if(max_ranged_charge && max_ranged_charge != RANGED_CHARGE_NO_COST && ranged_charge <= max_ranged_charge && world.time > next_ranged_recharge)
		ranged_charge++
		next_ranged_recharge = world.time + ranged_recharge_time
