PROCESSING_SUBSYSTEM_DEF(wave_defense)
	wait = 1 SECOND
	priority = SS_PRIORITY_DEFAULT
	init_order = SS_INIT_MISC_LATE
	flags = SS_BACKGROUND

	var/prep_time          = 30 SECONDS //10 MINUTES
	var/intermission_time  = 15 SECONDS //2 MINUTES
	var/wave_time          = 45 SECONDS //8 MINUTES
	var/boss_wave_interval = 2
	var/wave_num           = 6

	var/list/wave_packs    = list()
	var/list/spawnpoints   = list()
	var/static/list/all_pack_types = list(
		/datum/wave_defense_pack/debug
	)

	var/tmp/controller_state = WAVE_CONTROL_STATE_PREP
	var/tmp/prep_started     = 0
	var/tmp/current_wave     = 0
	var/tmp/wave_start_time  = 0
	var/tmp/map_validated    = FALSE
	var/tmp/prep_time_string
	var/tmp/wave_time_string
	var/tmp/map_validation_failed = FALSE

/datum/controller/subsystem/processing/wave_defense/Initialize(start_timeofday)
	. = ..()
	if(!length(spawnpoints))
		to_world("Wave defense cannot start, no spawnpoints found!")
		map_validation_failed = TRUE

/datum/controller/subsystem/processing/wave_defense/fire(resumed = 0)

	if(map_validation_failed)
		suspend()

	..()

	// Cache invalidation.
	prep_time_string = null
	wave_time_string = null

	switch(controller_state)

		// The round has completed, we are done.
		if(WAVE_CONTROL_STATE_ROUNDEND)
			return PROCESS_KILL

		// The round is still preparing to begin.
		if(WAVE_CONTROL_STATE_PREP)
			if(!prep_started)
				prep_started = world.time
			else if(world.time >= prep_started + prep_time)
				start_wave()

		// A wave is in progress.
		if(WAVE_CONTROL_STATE_RUNNING)
			if(world.time < wave_start_time + wave_time || length(wave_packs))
				//if(length(wave_packs))
					// path them all aggressively towards the objective so they don't
					// linger on the outskirts for whatever reason
				tick_wave()
			else
				end_wave()

		// A wave has ended, but may still have mobs or prep time to go through.
		if(WAVE_CONTROL_STATE_CLEANUP)
			if(world.time >= wave_start_time + intermission_time + wave_time)
				start_wave()

/datum/controller/subsystem/processing/wave_defense/stat_entry(msg)
	. = ..("W:[current_wave] P:[length(wave_packs)]")

/datum/controller/subsystem/processing/wave_defense/proc/end_wave()
	to_world("Wave #[current_wave] has ended!")
	if(length(wave_packs))
		to_world("[length(wave_packs)] enemy group\s remain!")
	controller_state = WAVE_CONTROL_STATE_CLEANUP

/datum/controller/subsystem/processing/wave_defense/proc/start_wave()
	current_wave++
	if(current_wave <= wave_num)
		controller_state = WAVE_CONTROL_STATE_RUNNING
		to_world("Wave #[current_wave] has begun!")
		spawn_wave()
	else
		to_world("The enemy is exhausted!")
		SSevac.evacuation_controller.call_evacuation(null, TRUE, TRUE)

/datum/controller/subsystem/processing/wave_defense/proc/tick_wave()
	for(var/datum/wave_defense_pack/pack in wave_packs)
		if(!pack.tick())
			qdel(pack)
			wave_packs -= pack

/datum/controller/subsystem/processing/wave_defense/proc/spawn_wave()
	wave_start_time = world.time
	var/list/packs_to_spawn = get_packs_to_spawn()
	var/boss_wave = (current_wave % boss_wave_interval == 0)
	while(length(packs_to_spawn))
		var/datum/wave_defense_pack/pack_type = pick(packs_to_spawn)
		var/list/spawns = spawnpoints[initial(pack_type.spawn_type)]
		spawns = shuffle(spawns.Copy())
		var/spawned_pack = FALSE
		while(length(spawns))
			var/obj/abstract/wave_defense_spawnpoint/spawnpoint = spawns[1]
			pack_type = spawnpoint.spawn_pack(pack_type, boss_wave)
			if(istype(pack_type))
				wave_packs += pack_type
				spawned_pack = TRUE
				break
		packs_to_spawn -= istype(pack_type) ? pack_type.type : pack_type
		if(!spawned_pack)
			log_debug("Failed to spawn [pack_type], continuing.")

/datum/controller/subsystem/processing/wave_defense/proc/get_prep_time_string()
	if(!prep_time_string)
		prep_time_string = deciseconds2string(max(0, prep_time - (world.time - prep_started)), show_seconds = TRUE)
	return prep_time_string

/datum/controller/subsystem/processing/wave_defense/proc/get_wave_time_string()
	if(!wave_time_string)
		wave_time_string = deciseconds2string(max(0, wave_time - (world.time - wave_start_time)), show_seconds = TRUE)
	return wave_time_string

/datum/controller/subsystem/processing/wave_defense/proc/get_packs_to_spawn()
	// TODO: escalating pack size/difficulty
	return list(
		/datum/wave_defense_pack/debug,
		/datum/wave_defense_pack/debug,
		/datum/wave_defense_pack/debug
	)
