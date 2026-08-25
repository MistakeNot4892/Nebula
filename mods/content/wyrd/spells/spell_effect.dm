/decl/wyrd_effect
	abstract_type = /decl/wyrd_effect
	var/name
	var/description
	var/cost = 1
	var/arcana_skill = SKILL_SCIENCE // TODO: arcana or magic skill
	var/stamina_cost = 20
	var/alist/minimum_anima
	var/alist/maximum_anima
	var/cast_sound = 'sound/effects/bamf.ogg'
	var/cast_volume = 60

	var/const/WYRD_AOE            = 0
	var/const/WYRD_MELEE          = 1
	var/const/WYRD_RANGED         = 2
	var/const/ANIMA_INSUFFICIENT  = 0
	var/const/ANIMA_SUITABLE      = 1
	var/const/ANIMA_OVERSATURATED = 2

/decl/wyrd_effect/proc/evoke_spell(mob/user, atom/target, obj/item/runestone/runestone, caster_effect, caster_strength, in_proximity, deliberate = TRUE)
	// Get our spell parameters.
	var/spent_cost     = runestone ? min(runestone.potentia_density, cost) : cost
	var/evoke_effect   = caster_effect   || runestone?.stored_spell?.effect_type || WYRD_AOE
	if(!in_proximity && evoke_effect == WYRD_MELEE)
		evoke_effect = WYRD_RANGED
	var/evoke_strength = caster_strength || runestone?.potentia_density || 1

	// Cast the actual spell.
	do_evocation(user, target, evoke_effect, evoke_strength, deliberate)

	// Expend resources.
	if(runestone)
		if(runestone.potentia_density > spent_cost && evoke_effect != WYRD_AOE)
			runestone.potentia_density -= spent_cost
			runestone.update_icon()
			runestone.update_strings()
		else if(!QDELETED(runestone))
			to_chat(user, SPAN_DANGER("Your runestone crumbles to dust!"))
			qdel(runestone)
	else if(stamina_cost)
		user.adjust_stamina(-(stamina_cost))

/decl/wyrd_effect/proc/show_runestone_primed_message(mob/user, obj/item/runestone/stone)
	to_chat(user, SPAN_NOTICE("Raw potentia wisps from \the [stone] and wreathes your [parse_zone(user.get_active_held_item_slot())], ready to be directed."))

/decl/wyrd_effect/proc/do_evocation(mob/user, atom/target, evoke_effect = WYRD_AOE, evoke_strength = 1, deliberate = TRUE)
	SHOULD_CALL_PARENT(TRUE)
	if(cast_sound && cast_volume)
		playsound(get_turf(user), cast_sound, cast_volume)

/decl/wyrd_effect/proc/can_be_worked_at(mob/user, turf/location)

	// TODO: compare against user and target anima
	if(!length(minimum_anima) && !length(maximum_anima))
		return ANIMA_SUITABLE

	var/alist/local_anima = location.get_ambient_anima()
	if(length(maximum_anima))
		for(var/atype,avalue in maximum_anima)
			if(local_anima[atype] > maximum_anima[atype])
				return ANIMA_OVERSATURATED
	if(length(minimum_anima))
		for(var/atype,avalue in minimum_anima)
			if(local_anima[atype] < minimum_anima[atype])
				return ANIMA_INSUFFICIENT

	return ANIMA_SUITABLE

/decl/wyrd_effect/flash
	name = "Flash"
	description = "Release the channeled potentia in a blinding flash of light."

/decl/wyrd_effect/flash/do_evocation(mob/user, atom/target, evoke_effect = WYRD_AOE, evoke_strength = 1, deliberate = TRUE)
	. = ..()
	if(evoke_effect == WYRD_AOE)
		user.visible_message(SPAN_DANGER("\The [user] emits a blinding flash of light!"))
		for(var/mob/living/victim in view(evoke_strength, user))
			if(deliberate && victim == user)
				continue
			victim.handle_flashed(rand(evoke_strength, evoke_strength*2 + 1)) // min is 1 to 2, max is 3 to 7; base flash is 2 to 7 in a range of 3 tiles
	else
		user.visible_message(SPAN_DANGER("\The [user] drowns \the [target] in a blinding flash of light!"))
		if(isliving(target))
			var/mob/living/victim = target
			victim.handle_flashed(evoke_strength * 2 + 1) // since we're only attacking one target, we just go with the max instead of a random value
	return TRUE

/decl/wyrd_effect/gloom
	name = "Gloom"
	description = "Burn the channeled potentia to create a burst of cloying darkness."

/decl/wyrd_effect/gloom/do_evocation(mob/user, atom/target, evoke_effect = WYRD_AOE, evoke_strength = 1, deliberate = TRUE)
	. = ..()
	if(evoke_effect == WYRD_AOE)
		user.visible_message(SPAN_DANGER("\The [user] emits a burst of cloying darkness!"))
		var/atom/movable/gloom/gloom = new(target, evoke_strength) // with AOE spell, target is user's turf
		QDEL_IN_CLIENT_TIME(gloom, evoke_strength * 5 SECONDS)
	else
		user.visible_message(SPAN_DANGER("\The [user] drowns \the [target] in darkness!"))
		if(isliving(target))
			var/mob/living/victim = target
			victim.overlay_fullscreen("gloom", /obj/screen/fullscreen/blackout)
			addtimer(CALLBACK(victim, TYPE_PROC_REF(/mob, clear_fullscreen), "gloom"), evoke_strength * 3 SECONDS)
	return TRUE

/atom/movable/gloom
	simulated = FALSE
	mouse_opacity = MOUSE_OPACITY_UNCLICKABLE

/atom/movable/gloom/Initialize(ml, strength)
	. = ..()
	set_light(strength, -10, "#ffffff") // negative light, cleared on destroy

/decl/wyrd_effect/flare
	name = "Flare"
	description = "Release the channeled potentia in an undirected burst of flame."

/decl/wyrd_effect/flare/do_evocation(mob/user, atom/target, evoke_effect = WYRD_AOE, evoke_strength = 1, deliberate = TRUE)
	. = ..()
	var/turf/source_turf = get_turf(user)
	// level 1 flare is hot enough to boil water. level 3 flare is hot enough to light a campfire and ignite wood
	// divided by 0.9 and plus one to ensure inefficiency doesn't stop us from lighting campfires
	var/fire_temperature = Interpolate(T100C, /decl/material/solid/organic/wood::ignition_point / 0.9 + 1, (evoke_strength - 1) / 3)
	if(evoke_effect == WYRD_AOE)
		user.visible_message(SPAN_DANGER("\The [user] is wreathed in a blast of fire!"))
		for(var/turf/T in RANGE_TURFS(source_turf, evoke_strength))
			T = T.resolve_to_actual_turf()
			new /obj/effect/fake_fire/variable/owned(T, fire_temperature, evoke_strength SECONDS, deliberate ? user : null)
	else
		user.visible_message(SPAN_DANGER("\The [user] hurls a blast of fire at \the [target]!"))
		var/obj/item/projectile/fireball/projectile = new(source_turf)
		projectile.fire_lifetime = evoke_strength SECONDS
		// level 1 flare is hot enough to boil water. level 3 flare is hot enough to light a campfire and ignite wood
		projectile.fire_temperature = Interpolate(T100C, projectile::fire_temperature, (evoke_strength - 1) / 3)
		projectile.launch_from_gun(target, user.get_target_zone(), user)
	return TRUE
