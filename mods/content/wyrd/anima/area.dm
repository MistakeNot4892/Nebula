/area
	var/alist/background_anima = alist(
		/decl/anima/sky    = /decl/anima::ANIMA_NEGLIGIBLE,
		/decl/anima/waning = /decl/anima::ANIMA_NEGLIGIBLE,
		/decl/anima/deep = /decl/anima::ANIMA_NEGLIGIBLE,
		/decl/anima/blood  = /decl/anima::ANIMA_NEGLIGIBLE
	)

/area/New()
	..()
	// Outside areas have a higher minimum value of Sky Sign.
	if(is_outside == OUTSIDE_YES)
		background_anima[/decl/anima/sky] = max(background_anima[/decl/anima/sky], /decl/anima::ANIMA_DENSE)

/area/proc/get_background_anima()
	RETURN_TYPE(/alist)
	return background_anima

/area/proc/adjust_background_anima(_anima, _amount)
	// Update our ambient background anima list.
	if(!background_anima)
		background_anima = alist()
	background_anima[_anima] += _amount
	// Invalidate cache for our turfs.
	for(var/turf/area_turf in contents)
		area_turf.last_anima = null
