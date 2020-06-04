/decl/plant_effect/proc/handle_dosage(var/obj/effect/plant/plant, var/available_dosage)
	return

/decl/plant_effect/consumption
	var/require_trait = TRAIT_REQUIRES_NUTRIENTS 
	var/consume_trait = TRAIT_NUTRIENT_CONSUMPTION

/decl/plant_effect/consumption/handle_dosage(var/obj/effect/plant/plant, var/available_dosage)
	. = 0
	var/need_nutrients = plant.plant_type.get_trait(consume_trait) * HYDRO_SPEED_MULTIPLIER
	if(need_nutrients && plant.plant_type.get_trait(require_trait))
		var/health_change = rand(1,3) * HYDRO_SPEED_MULTIPLIER
		if(available_dosage >= need_nutrients)
			. = max(0, need_nutrients)
		else
			health_change = -(health_change)
		plant.adjust_health(health_change)

/decl/plant_effect/consumption/water
	consume_trait = TRAIT_WATER_CONSUMPTION
	require_trait = TRAIT_REQUIRES_WATER

/decl/plant_effect/mutagen/handle_dosage(var/obj/effect/plant/plant, var/available_dosage)
	var/immutable = plant.plant_type.get_trait(TRAIT_IMMUTABLE)
	if(immutable == 1)
		return 0
	var/mutation_chance = available_dosage
	if(immutable == -1)
		mutation_chance *= 1.5
	if(prob(mutation_chance))
		plant.mutate(prob(15) ? 2 : 1)
		return available_dosage

/decl/plant_effect/poison/handle_dosage(var/obj/effect/plant/plant, var/available_dosage)
	if(available_dosage > 0 && available_dosage > plant.plant_type.get_trait(TRAIT_TOXINS_TOLERANCE))
		plant.adjust_health(-(max(1, round(available_dosage * 0.1))))
		return available_dosage

/decl/plant_effect/yield_modifier
