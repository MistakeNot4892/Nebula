/mob/living/silicon/robot/platform/attack_hand(mob/user)

	if(recharging)
		recharging.dropInto(loc)
		user.put_in_hands(user)
		user.visible_message(SPAN_NOTICE("\The [user] pops \the [recharging] out of \the [src]'s recharging port."))
		recharging = null
		return TRUE

	if(length(stored_atoms))
		var/weakref/remove_ref = stored_atoms[length(stored_atoms)]
		var/atom/movable/removing = remove_ref?.resolve()
		if(!istype(removing) || QDELETED(removing) || removing.loc != src)
			LAZYREMOVE(stored_atoms, remove_ref)
		else
			user.visible_message(SPAN_NOTICE("\The [user] begins unloading \the [removing] from \the [src]'s cargo compartment."))
			if(do_after(user, 3 SECONDS, src) && !QDELETED(removing) && removing.loc == src)
				drop_stored_atom(removing, user)
		return TRUE

	. = ..()

/mob/living/silicon/robot/platform/attackby(obj/item/W, mob/user)

	if(istype(W, /obj/item/cell))
		if(recharging)
			to_chat(user, SPAN_WARNING("\The [src] already has a cell inserted into its recharging port."))
		else if(user.unEquip(W, src))
			recharging = W
			recharge_complete = FALSE
			user.visible_message(SPAN_NOTICE("\The [user] slots \the [recharging] into \the [src]'s recharging port."))
		return TRUE

	if(istype(W, /obj/item/paint_sprayer))
		return FALSE // Paint sprayer wil call try_paint() in afterattack()

	. = ..()

/mob/living/silicon/robot/platform/attack_ghost(mob/observer/ghost/user)
	if(client || key || stat == DEAD)
		return ..()

	if(jobban_isbanned(user, "Robot"))
		to_chat(user, SPAN_WARNING("You are banned from synthetic roles and cannot take control of \the [src]."))
		return 

	if(user.mind)
		user.mind.transfer_to(src)
	if(key != user.key)
		key = user.key
	updatename()
	qdel(user)
