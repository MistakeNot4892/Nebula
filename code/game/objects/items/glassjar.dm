/obj/item/glass_jar
	name = "glass jar"
	desc = "A small empty jar."
	icon = 'icons/obj/items/jar.dmi'
	icon_state = "jar"
	w_class = ITEM_SIZE_SMALL
	material = /decl/material/solid/glass
	material_force_multiplier = 0.1
	item_flags = ITEM_FLAG_NO_BLUDGEON

/obj/item/glass_jar/Initialize()
	. = ..()
	update_icon()

/obj/item/glass_jar/afterattack(var/atom/A, var/mob/user, var/proximity)
	if(proximity && !length(contents) && istype(A, /mob))
		var/mob/L = A
		if(L.mob_size > MOB_SIZE_TINY)
			to_chat(user, SPAN_WARNING("\The [A] doesn't fit into \the [src]."))
			return
		user.visible_message(SPAN_NOTICE("\The [user] scoops [L] into \the [src]."), SPAN_NOTICE("You scoop \the [L] into \the [src]."))
		L.forceMove(src)
		update_icon()
		return TRUE

/obj/item/glass_jar/attack_self(var/mob/user)
	if(length(contents))
		for(var/atom/movable/AM in src)
			AM.dropInto(user.loc)
		to_chat(user, SPAN_NOTICE("You empty out \the [src]."))
		update_icon()
	return TRUE

/obj/item/glass_jar/attackby(var/obj/item/W, var/mob/user)
	if(istype(W, /obj/item/cash))
		var/obj/item/cash/cash = W
		var/obj/item/cash/tips = locate() in src
		if(tips && cash.currency != tips.currency)
			var/decl/currency/cur = decls_repository.get_decl(tips.currency)
			to_chat(user, SPAN_WARNING("\The [src] is already filled with [cur.name]."))
			return TRUE
		if(user.unEquip(cash))
			user.visible_message(SPAN_NOTICE("\The [user] puts \the [cash] into \the [src]."))
			if(tips)
				tips.adjust_worth(cash.absolute_worth)
				qdel(cash)
			else
				tips.forceMove(src)
			update_icon()
			return TRUE
	. = ..()

/obj/item/glass_jar/on_update_icon() // Also updates name and desc
	underlays.Cut()
	overlays.Cut()

	if(!length(contents))
		SetName(initial(name))
		desc = initial(desc)
		return

	var/obj/item/cash/cash = locate() in src
	if(cash)
		SetName("tip jar")
		desc = "A small jar with money inside."
		var/image/I = new
		I.appearance = cash
		I.plane = FLOAT_PLANE
		I.layer = FLOAT_LAYER
		I.pixel_x = rand(-2, 3)
		I.pixel_y = rand(-6, 6)
		var/matrix/M = I.transform || matrix()
		M.Scale(0.6)
		I.transform = M
		underlays += I
		return

	var/mob/trapped = locate() in src
	if(trapped)
		var/image/I = new
		I.appearance = trapped
		I.pixel_x = 0
		I.pixel_y = 6
		I.plane = FLOAT_PLANE
		I.layer = FLOAT_LAYER
		underlays += I
		SetName("glass jar with \a [trapped]")
		desc = "A small jar with \a [trapped] inside."
