/decl/planter_effect/proc/handle_planter_process(var/datum/extension/plantable/planter, var/effect_amount)
	return 0

/decl/planter_effect/proc/affect_plant(var/obj/effect/plant/plant, var/effect_level)
	return 0

/decl/planter_effect/invaders
	var/tolerance_trait =      TRAIT_PEST_TOLERANCE
	var/consume_trait =        TRAIT_CARNIVOROUS
	var/tick_increase_chance = 3

/decl/planter_effect/invaders/affect_plant(var/obj/effect/plant/plant, var/effect_level)
	. = 0
	if(effect_level > 0)
		var/health_mod = HYDRO_SPEED_MULTIPLIER
		if(plant.plant_type.get_trait(consume_trait))
			. = HYDRO_SPEED_MULTIPLIER
		else if (effect_level >= plant.plant_type.get_trait(tolerance_trait))
			health_mod = -(health_mod)
		plant.adjust_health(health_mod)

/decl/planter_effect/invaders/handle_planter_process(var/datum/extension/plantable/planter, var/effect_amount)
	if(prob(tick_increase_chance))
		. = HYDRO_SPEED_MULTIPLIER

/decl/planter_effect/invaders/weeds
	tolerance_trait =      TRAIT_WEED_TOLERANCE
	consume_trait =        TRAIT_PARASITE
	tick_increase_chance = 5

/decl/planter_effect/invaders/weeds/handle_planter_process(var/datum/extension/plantable/planter, var/effect_amount)
	. = ..()
	if(locate(/obj/effect/plant) in planter.holder)
		. *= 0.5
		for(var/obj/effect/plant/plant in planter.holder)
			if(plant.plant_is_dead || (effect_amount + .) < plant.plant_type.get_trait(tolerance_trait))
				return

	for(var/obj/effect/plant/plant in planter.holder)
		qdel(plant)
	var/obj/effect/plant/weed = new(planter.holder, SSplants.seeds[pick(list("reishi", "nettles", "amanita", "mushrooms", "plumphelmet", "corkwood", "harebells", "weeds"))])
	weed.visible_message(SPAN_NOTICE("\The [planter.holder] has been overtaken by \the [weed]."))
	. = -(effect_amount)

/decl/planter_effect/vine_spread/handle_planter_process(var/datum/extension/plantable/planter, var/effect_amount)
	if(locate(/obj/effect/plant) in get_turf(planter.holder))
		return
	for(var/obj/effect/plant/plant in planter.holder)
		if(plant.plant_type.get_trait(TRAIT_SPREAD) != 2)
			continue
		if(plant.age < plant.plant_type.get_trait(TRAIT_MATURATION) * 0.5)
			continue
		if(prob(2 * plant.plant_type.get_trait(TRAIT_POTENCY)))
			new /obj/effect/plant(get_turf(planter.holder), plant.plant_type)
