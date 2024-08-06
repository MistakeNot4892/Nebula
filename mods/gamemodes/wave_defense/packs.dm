/datum/wave_defense_pack
	abstract_type = /datum/wave_defense_pack
	var/name         = "Abstract Pack"
	var/leader_min   = 1
	var/leader_max   = 1
	var/special_min  = 1
	var/special_max  = 3
	var/special_prob = 20
	var/grunt_min    = 3
	var/grunt_max    = 5
	var/boss_min     = 1
	var/boss_max     = 1
	var/spawn_type   = WAVE_SPAWN_BASIC
	var/list/pack_mobs
	var/weakref/leader_ref

/datum/wave_defense_pack/proc/get_leader()
	var/mob/leader = leader_ref?.resolve()
	if(istype(leader) && !QDELETED(leader) && leader.stat != UNCONSCIOUS)
		return leader
	// TODO: prioritize bosses, then leaders, then special, then grunt.
	for(var/weakref/pack_ref in pack_mobs)
		leader = pack_ref.resolve()
		if(istype(leader) && !QDELETED(leader) && leader.stat != UNCONSCIOUS)
			leader_ref = pack_ref
			return leader

/datum/wave_defense_pack/proc/is_defeated()
	for(var/weakref/mob_ref in pack_mobs)
		var/mob/pack_mob = mob_ref.resolve()
		if(istype(pack_mob) && !QDELETED(pack_mob) && pack_mob.stat != DEAD)
			return FALSE
	return TRUE

/datum/wave_defense_pack/proc/place_mob(mob_type, obj/abstract/wave_defense_spawnpoint/spawnpoint)
	// Create the mob.
	var/mob/placing = new mob_type(get_turf(spawnpoint))

	// Assign it pack AI if it hasn't already got it.
	var/datum/mob_controller/aggressive/pack/assigned_ai
	if(istype(placing.ai, /datum/mob_controller/aggressive/pack))
		assigned_ai = placing.ai
	else if(ispath(placing.ai, /datum/mob_controller/aggressive/pack))
		assigned_ai = new placing.ai(placing)
	else
		assigned_ai = new /datum/mob_controller/aggressive/pack(placing)

	// Give it a reference to its pack.
	assigned_ai.pack_ref = weakref(src)

	// TODO: move into clear space near spawn
	return weakref(placing)

/datum/wave_defense_pack/proc/get_pack_leader_types()
	return

/datum/wave_defense_pack/proc/get_pack_special_types()
	return

/datum/wave_defense_pack/proc/get_pack_grunt_types()
	return

/datum/wave_defense_pack/proc/get_pack_boss_types()
	return

/datum/wave_defense_pack/proc/tick()
	if(is_defeated())
		qdel(src)
	return TRUE

/datum/wave_defense_pack/proc/populate_pack(obj/abstract/wave_defense_spawnpoint/spawnpoint, boss_wave = FALSE)
	if(!istype(spawnpoint))
		return

	pack_mobs = list()

	if(leader_min > 0)
		var/list/leader_types = get_pack_leader_types()
		if(length(leader_types))
			var/leader_amount = rand(leader_min, leader_max)
			for(var/_ = 1 to leader_amount)
				pack_mobs += place_mob(pickweight(leader_types), spawnpoint)

	if(special_min && prob(special_prob))
		var/list/special_types = get_pack_special_types()
		if(length(special_types))
			var/special_amount = rand(special_min, special_max)
			for(var/_ = 1 to special_amount)
				pack_mobs += place_mob(pickweight(special_types), spawnpoint)

	if(grunt_min)
		var/list/grunt_types = get_pack_grunt_types()
		if(length(grunt_types))
			var/grunt_amount = rand(grunt_min, grunt_max)
			for(var/_ = 1 to grunt_amount)
				pack_mobs += place_mob(pickweight(grunt_types), spawnpoint)

	if(boss_wave && boss_min)
		var/list/boss_types = get_pack_boss_types()
		if(length(boss_types))
			var/boss_amount = rand(boss_min, boss_max)
			for(var/_ = 1 to boss_amount)
				pack_mobs += place_mob(pickweight(boss_types), spawnpoint)

// Notes:
// Wave lasts for 5 minutes or until all mobs are killed.
// Unspent time at wave end is taken off the win timer (ship is having an easier time finding a landing site)

// DEBUG STUFF BELOW
/datum/wave_defense_pack/debug

/datum/wave_defense_pack/debug/get_pack_boss_types()
	var/static/list/boss_types = list(
		/mob/living/simple_animal/hostile/parrot/space
	)
	return boss_types

/datum/wave_defense_pack/debug/get_pack_leader_types()
	var/static/list/leader_types = list(
		/mob/living/simple_animal/fowl/chicken
	)
	return leader_types

/datum/wave_defense_pack/debug/get_pack_special_types()
	var/static/list/special_types = list(
		/mob/living/simple_animal/fowl/duck
	)
	return special_types

/datum/wave_defense_pack/debug/get_pack_grunt_types()
	var/static/list/grunt_types = list(
		/mob/living/simple_animal/chick
	)
	return grunt_types
