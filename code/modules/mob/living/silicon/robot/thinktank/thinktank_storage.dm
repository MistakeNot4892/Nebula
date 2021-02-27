/mob/living/silicon/robot/platform/death(gibbed, deathmessage, show_dead_message)
	if(gibbed)
		if(recharging)
			recharging.dropInto(loc)
			recharging.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(1,3),30)
		for(var/weakref/stored_ref in stored_atoms)
			var/atom/movable/dropping = stored_ref.resolve()
			if(istype(dropping) && !QDELETED(dropping) && dropping.loc == src)
				dropping.dropInto(loc)
				dropping.throw_at(get_edge_target_turf(src,pick(GLOB.alldirs)),rand(1,3),30)
	. = ..()

/mob/living/silicon/robot/platform/proc/can_store_atom(var/atom/movable/storing, var/mob/user)

	if(!istype(storing))
		var/storing_target = (user == src) ? "yourself" : "\the [src]"
		to_chat(user, SPAN_WARNING("You cannot store that inside [storing_target]."))
		return FALSE

	if(storing == src)
		var/storing_target = (user == src) ? "yourself" : "\the [src]"
		to_chat(user, SPAN_WARNING("You cannot store [storing_target] inside [storing_target]!"))
		return FALSE

	if(length(stored_atoms) >= max_stored_atoms)
		var/storing_target = (user == src) ? "Your" : "\The [src]'s"
		to_chat(user, SPAN_WARNING("[storing_target] cargo compartment is full."))
		return FALSE

	for(var/store_type in can_store_types)
		if(istype(storing, store_type))
			return TRUE

	var/storing_target = (user == src) ? "yourself" : "\the [src]"
	to_chat(user, SPAN_WARNING("You cannot store \the [storing] inside [storing_target]."))
	return FALSE

/mob/living/silicon/robot/platform/proc/store_atom(var/atom/movable/storing, var/mob/user)
	if(istype(storing))
		storing.forceMove(src)
		LAZYDISTINCTADD(stored_atoms, weakref(storing))

/mob/living/silicon/robot/platform/proc/drop_stored_atom(var/atom/movable/ejecting, var/mob/user)

	if(!ejecting)
		if(length(stored_atoms))
			var/weakref/stored_ref = stored_atoms[1]
			if(!istype(stored_ref))
				LAZYREMOVE(stored_atoms, stored_ref)
			else
				ejecting = stored_ref?.resolve()

	LAZYREMOVE(stored_atoms, weakref(ejecting))
	if(istype(ejecting) && !QDELETED(ejecting) && ejecting.loc == src)
		ejecting.dropInto(loc)
		if(user == src)
			visible_message(SPAN_NOTICE("\The [src] ejects \the [ejecting] from its cargo compartment."))
		else
			user.visible_message(SPAN_NOTICE("\The [user] pulls \the [ejecting] from \the [src]'s cargo compartment."))

/mob/living/silicon/robot/platform/proc/drop_stored_atom_verb()
	set name = "Eject Cargo"
	set category = "Silicon Commands"
	set desc = "Drop something from your internal storage."
	if(length(stored_atoms))
		drop_stored_atom(user = src)
	else
		to_chat(src, SPAN_WARNING("You have nothing in your cargo compartment."))

/mob/living/silicon/robot/platform/receive_mouse_drop(atom/movable/storing, mob/user)
	if(!can_store_atom(storing, user))
		return FALSE
	if(user == src)
		visible_message(SPAN_NOTICE("\The [src] begins loading \the [storing] into \his cargo compartment."))
	else
		user.visible_message(SPAN_NOTICE("\The [user] begins loading \the [storing] into \the [src]'s cargo compartment."))
	if(do_after(user, 3 SECONDS, src) && storing.can_mouse_drop(src, user))
		store_atom(storing, user)
	return FALSE
