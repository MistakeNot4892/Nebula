/obj/effect/stickyweb
	name = "cobweb"
	desc = "It's stringy and sticky."
	icon = 'icons/effects/spiders.dmi'
	icon_state = "stickyweb1"

/obj/effect/stickyweb/Initialize()
	. = ..()
	if(prob(50))
		icon_state = "stickyweb2"

/obj/effect/stickyweb/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) 
		return TRUE
	if(istype(mover, /mob/living/simple_animal/hostile/giant_spider) || istype(mover, /mob/living/simple_animal/spiderling))
		return TRUE
	if(isliving(mover) && prob(50))
		to_chat(mover, SPAN_WARNING("You get stuck in \the [src] for a moment."))
		return FALSE
	if(istype(mover, /obj/item/projectile))
		return prob(30)
	return TRUE

/obj/effect/decal/cleanable/spiderling_remains
	name = "spiderling remains"
	desc = "Green squishy mess."
	icon = 'icons/effects/effects.dmi'
	icon_state = "greenshatter"
	anchored = 1
	layer = BLOOD_LAYER

/obj/structure/cocoon
	name = "cocoon"
	desc = "Something wrapped in silky webbing."
	icon = 'icons/effects/spiders.dmi'
	icon_state = "cocoon1"
	maxhealth = 60
	density = FALSE
	opacity = FALSE

/obj/structure/cocoon/Initialize(var/ml, var/atom/movable/capturing)
	. = ..()
	if(istype(capturing))
		var/mob/M = locate() in capturing
		if(M)
			pixel_x = M.pixel_x
			pixel_y = M.pixel_y
			icon_state = pick("cocoon_large1","cocoon_large2","cocoon_large3")
		else
			pixel_x = capturing.pixel_x
			pixel_y = capturing.pixel_y
			icon_state = pick("cocoon1","cocoon2","cocoon3")
		for(var/atom/movable/AM in get_turf(capturing))
			if(AM.simulated && !AM.anchored)
				AM.forceMove(src)
				density = max(density, AM.density)
				opacity = max(density, AM.opacity)

/obj/structure/cocoon/physically_destroyed()
	visible_message(SPAN_WARNING("\The [src] splits open."))
	for(var/atom/movable/A in contents)
		A.dropInto(loc)
	. = ..()

/obj/effect/eggcluster
	name = "egg cluster"
	desc = "They seem to pulse slightly with an inner life."
	icon = 'icons/effects/spiders.dmi'
	icon_state = "eggs"
	var/amount_grown = 0

/obj/effect/eggcluster/Initialize(mapload, atom/parent)
	. = ..()
	color = parent?.color || color
	pixel_x = rand(3,-3)
	pixel_y = rand(3,-3)
	START_PROCESSING(SSobj, src)

/obj/effect/eggcluster/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(istype(loc, /obj/item/organ/external))
		var/obj/item/organ/external/O = loc
		O.implants -= src
	. = ..()

/obj/effect/eggcluster/Process()
	if(prob(80))
		amount_grown += rand(0,2)
	if(amount_grown >= 100)
		var/num = rand(3,9)
		var/obj/item/organ/external/O = null
		if(istype(loc, /obj/item/organ/external))
			O = loc

		for(var/i=0, i<num, i++)
			var/obj/item/holder/spider_holder = new
			var/mob/living/simple_animal/spiderling/spiderling = new(spider_holder, src)
			spider_holder.sync(spiderling)
			if(!QDELETED(spider_holder))
				O.implants += spider_holder
		qdel(src)