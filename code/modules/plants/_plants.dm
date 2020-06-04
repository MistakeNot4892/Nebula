#define CHEM_DOSE_MAX 10
#define CHEM_DOSE_CONSTANT 0.1

/atom/proc/get_plants()
	for(var/atom/thing in contents)
		var/plants = thing.get_plants()
		if(length(plants))
			LAZYDISTINCTADD(., plants)

/obj/effect/plant/get_plants()
	if(!plant_is_uprooted)
		LAZYDISTINCTADD(., src)

/obj/effect/plant
	name = "plant"
	desc = "Some kind of plant."

	var/max_health = 100
	var/health = 100
	var/age = 0

	var/list/chem_doses
	var/list/chem_effects

	var/time_plant_last_produced = 0
	var/plant_has_been_sampled =   FALSE
	var/plant_is_uprooted =        FALSE
	var/plant_is_dead =            FALSE
	var/plant_ready_for_harvest =  FALSE
	var/plant_is_on_wall

	var/obj/effect/plant/parent
	var/vine_spread_chance = 30
	var/vine_spread_distance = 4
	var/vine_possible_children = 20

	var/datum/seed/plant_type

/obj/effect/plant/external/Process()
	return PROCESS_KILL

/obj/effect/plant/external/finalize_plant()
	return

/obj/effect/plant/proc/adjust_chem_effect(var/effect, var/value)
	LAZYINITLIST(chem_effects)
	chem_effects[effect] = chem_effects[effect] + value
	if(chem_effects[effect] == 0)
		LAZYREMOVE(chem_effects, effect)

/obj/effect/plant/Initialize(ml, seed, var/obj/effect/plant/new_parent)
	. = ..(ml)
	if(ispath(seed, /datum/seed) || istype(seed, /datum/seed))
		plant_type = seed
	if(plant_type && !istype(plant_type))
		plant_type = SSplants.seeds[plant_type]
	if(!istype(plant_type))
		return INITIALIZE_HINT_QDEL
	SetName(plant_type.seed_name)
	if(istype(new_parent))
		parent = new_parent
	finalize_plant()
	update_icon()
	
/obj/effect/plant/proc/finalize_plant()
	chem_doses = list(
		/decl/plant_effect/consumption =       100,
		/decl/plant_effect/consumption/water = 100
	)
	START_PROCESSING(SSplants, src)

/obj/effect/plant/Destroy()
	parent = null
	STOP_PROCESSING(SSplants, src)
	. = ..()

/obj/effect/plant/proc/die(var/destroy)
	if(!plant_is_dead)
		plant_is_dead = TRUE
		. = TRUE
	if(destroy)
		qdel(src)
	else
		queue_icon_update()

/obj/effect/plant/proc/adjust_health(var/amt)
	if(amt <= 0 && plant_is_dead)
		qdel(src)
		return
	health = Clamp((health-amt), 0, max_health)
	if(health == 0)
		die()
	update_icon()

/atom/proc/get_reagents_for_plant(var/obj/effect/plant/plant)
	. = reagents

/obj/effect/plant/Process()

	chem_effects = null

	if(plant_is_dead)
		return PROCESS_KILL

	if(plant_is_uprooted)
		adjust_health(-(1))
		return

	var/atom/holder = loc
	if(istype(holder))
		var/datum/reagents/plantfood = holder.get_reagents_for_plant(src)
		for(var/rtype in plantfood?.reagent_volumes)
			var/decl/material/reagent = decls_repository.get_decl(rtype)
			var/used = reagent.affect_plant(src, REAGENT_VOLUME(plantfood, rtype), plantfood)
			if(used)
				plantfood.remove_reagent(rtype, used)

		// Handle any environmental conditions such as weeds or pest levels on our holder, if they are configured for this.
		var/datum/extension/plantable/planter = get_extension(holder, /datum/extension/plantable)
		if(planter)
			for(var/peffect in subtypesof(/decl/planter_effect))
				var/decl/planter_effect/planter_effect = decls_repository.get_decl(peffect)
				var/adjust_planter = planter_effect.affect_plant(src, LAZYACCESS(planter.planter_effects, peffect))
				if(adjust_planter != 0)
					var/val = LAZYACCESS(planter.planter_effects, peffect) - adjust_planter 
					if(val <= 0)
						LAZYREMOVE(planter.planter_effects, peffect)
					else
						LAZYSET(planter.planter_effects, peffect, val)

	for(var/ceffect in chem_effects)
		var/val = chem_effects[ceffect] * CHEM_DOSE_CONSTANT
		var/chem_dose = LAZYACCESS(chem_doses, ceffect)
		if (chem_dose)
			val += chem_dose
		val = min(CHEM_DOSE_MAX, val)
		LAZYSET(chem_doses, ceffect, val)

	for(var/ceffect in subtypesof(/decl/plant_effect))
		var/decl/plant_effect/effect = decls_repository.get_decl(ceffect)
		var/dose_available = LAZYACCESS(chem_doses, ceffect)
		var/dose_used = effect.handle_dosage(src, dose_available)
		if(dose_used && dose_available)
			chem_doses[ceffect] -= dose_used
			if(chem_doses[ceffect] <= 0)
				chem_doses -= ceffect
				UNSETEMPTY(chem_doses)

	var/health_loss = plant_type.handle_plant_environment(loc)
	if(health_loss != 0)
		adjust_health(health_loss)

	if(prob(30)) 
		age += HYDRO_SPEED_MULTIPLIER
		queue_icon_update()

	if(age > plant_type.get_trait(TRAIT_MATURATION) && (age - time_plant_last_produced) > plant_type.get_trait(TRAIT_PRODUCTION))
		if(!plant_ready_for_harvest && !plant_is_dead)
			plant_ready_for_harvest = TRUE
			time_plant_last_produced = age
			queue_icon_update()

	if(plant_type.can_self_harvest && plant_ready_for_harvest && prob(5))
		harvest()

/obj/effect/plant/proc/mutate(var/severity)
	if(length(plant_type.mutants) && severity > 1)
		var/previous_plant = plant_type.display_name
		plant_type = plant_type.get_mutant_variant()
		plant_is_dead = FALSE
		age *= Floor(0.5)
		health = plant_type.get_trait(TRAIT_ENDURANCE)
		plant_ready_for_harvest = FALSE
		visible_message(SPAN_NOTICE("The <b>[previous_plant]</b> has suddenly mutated into <b>[plant_type.display_name]</b>!"))
	else
		plant_type = plant_type.diverge()
		plant_type.mutate(severity, loc)

/obj/effect/plant/proc/harvest(var/mob/user)
	if(plant_ready_for_harvest)
		. = plant_type.harvest(user || loc, LAZYACCESS(chem_effects, /decl/plant_effect/yield_modifier))
		if(!plant_type.get_trait(TRAIT_HARVEST_REPEAT))
			qdel(src)
		else
			plant_ready_for_harvest = FALSE

/obj/effect/plant/attack_hand(var/mob/user)
	
	if(plant_is_uprooted)
		return ..()

	if(buckled_mob)
		manual_unbuckle(user)
		return TRUE

	if(plant_is_dead)
		qdel(src)
		to_chat(user, SPAN_NOTICE("You remove the dead plant."))
		return TRUE

/obj/effect/plant/attack_ghost(var/mob/observer/ghost/user)
	if(!plant_type.has_mob_product || !plant_ready_for_harvest)
		return
	if(!user.can_admin_interact())
		return
	var/response = alert(user, "Are you sure you want to harvest this [plant_type.display_name]?", "Living plant request", "Yes", "No")
	if(response == "Yes")
		harvest()

/obj/effect/plant/attackby(var/obj/item/O, var/mob/user)

	if(O.edge && O.w_class < ITEM_SIZE_NORMAL && user.a_intent != I_HURT)

		if(plant_has_been_sampled)
			to_chat(user, SPAN_WARNING("There are no convenient sections to sample from \the [src]."))
			return TRUE

		if(plant_is_dead)
			to_chat(user, SPAN_WARNING("\The [src] is dead."))
			return TRUE

		var/needed_skill = plant_type.mysterious ? SKILL_ADEPT : SKILL_BASIC
		if(prob(user.skill_fail_chance(SKILL_BOTANY, 90, needed_skill)))
			to_chat(user, SPAN_WARNING("You failed to take a usable sample."))
		else
			plant_type.harvest(user, LAZYACCESS(chem_effects, /decl/plant_effect/yield_modifier), 1)
		adjust_health(-(rand(30,55)))
		if(prob(30))
			plant_has_been_sampled = 1
		return TRUE

	if(O.force)
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		user.visible_message(SPAN_DANGER("\The [src] has been attacked by \the [user] with \the [O]!"))
		playsound(get_turf(src), O.hitsound, 100, 1)
		adjust_health(-(O.force))
		return TRUE
	
	. = ..()

/obj/effect/plant/is_burnable()
	return ..() && plant_type.get_trait(TRAIT_HEAT_TOLERANCE) < 1000

/obj/effect/plant/proc/manual_unbuckle(var/mob/user)

	set waitfor = FALSE

	if(!buckled_mob)
		return

	if(buckled_mob != user)
		to_chat(user, "<span class='notice'>You try to free \the [buckled_mob] from \the [src].</span>")
		var/chance = round(100/(20*plant_type.get_trait(TRAIT_POTENCY)/100))
		if(prob(chance))
			buckled_mob.visible_message(\
				"<span class='notice'>\The [user] frees \the [buckled_mob] from \the [src].</span>",\
				"<span class='notice'>\The [user] frees you from \the [src].</span>",\
				"<span class='warning'>You hear shredding and ripping.</span>")
			unbuckle_mob()
	else
		user.setClickCooldown(100)
		var/breakouttime = rand(600, 1200) //1 to 2 minutes.

		user.visible_message(
			"<span class='danger'>\The [user] attempts to get free from [src]!</span>",
			"<span class='warning'>You attempt to get free from [src].</span>")

		if(do_after(user, breakouttime, incapacitation_flags = INCAPACITATION_DEFAULT & ~INCAPACITATION_RESTRAINED))
			if(unbuckle_mob())
				user.visible_message(
					"<span class='danger'>\The [user] manages to escape [src]!</span>",
					"<span class='warning'>You successfully escape [src]!</span>")

/atom/attack_hand(mob/user)
	if(has_extension(src, /datum/extension/plantable))
		for(var/obj/effect/plant/plant in src)
			if(plant.attack_hand(user))
				return TRUE
	. = ..()
