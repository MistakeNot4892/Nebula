// Spawnpoint marker.
/obj/abstract/wave_defense_spawnpoint
	abstract_type = /obj/abstract/wave_defense_spawnpoint
	var/spawn_category

/obj/abstract/wave_defense_spawnpoint/Initialize()
	. = ..()
	if(!spawn_category || !istext(spawn_category))
		return INITIALIZE_HINT_QDEL
	LAZYADD(SSwave_defense.spawnpoints[spawn_category], src)

/obj/abstract/wave_defense_spawnpoint/Destroy()
	if(spawn_category && istext(spawn_category))
		LAZYREMOVE(SSwave_defense.spawnpoints[spawn_category], src)
	return ..()

/obj/abstract/wave_defense_spawnpoint/proc/spawn_pack(pack_type, boss_wave = FALSE)
	var/datum/wave_defense_pack/pack = new pack_type
	pack.populate_pack(src, boss_wave)
	return pack

/obj/abstract/wave_defense_spawnpoint/basic
	spawn_category = WAVE_SPAWN_BASIC
