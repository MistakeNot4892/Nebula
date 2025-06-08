/datum/random_map/noise/ringdown_dustlands
	descriptor = "dustlands"
	smoothing_iterations = 2
	smooth_single_tiles = TRUE
	target_turf_type = /turf/floor/ringfall

/datum/random_map/noise/ringdown_dustlands/get_appropriate_path(var/value)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	switch(val)
		if(-INFINITY to 2)
			return /turf/floor/ringfall/concrete
		if(3 to 4)
			return /turf/floor/ringfall
		if(5 to 6)
			return /turf/floor/ringfall/sand
	return /turf/floor/ringfall/growth

/datum/random_map/noise/ringdown_dustlands/get_additional_spawns(var/value, var/turf/T)
	var/val = min(9,max(0,round((value/cell_range)*10)))
	if(val >= 9 && prob(12))
		new /obj/structure/flora/ringdown/pillar(T)
	else if(val >= 8 && prob(25))
		new /obj/structure/flora/ringdown(T)
