/datum/mob_controller/aggressive/pack
	var/weakref/pack_ref

/datum/mob_controller/aggressive/pack/Destroy()
	var/datum/wave_defense_pack/pack = pack_ref?.resolve()
	if(istype(pack))
		LAZYREMOVE(pack.pack_mobs, weakref(src))
	pack_ref = null
	return ..()

/datum/mob_controller/aggressive/pack/do_process()
	. = ..()
	if(!. || body.stat)
		return
	if(stance != STANCE_IDLE)
		return
	var/datum/wave_defense_pack/pack = pack_ref?.resolve()
	if(!istype(pack))
		return
	var/mob/leader = pack.get_leader()
	if(leader != body)
		var/static/datum/automove_metadata/_pack_follow_leader_metadata = new(_acceptable_distance = 3)
		body.start_automove(leader, metadata = _pack_follow_leader_metadata)
