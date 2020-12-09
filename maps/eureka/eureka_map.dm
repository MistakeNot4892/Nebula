/world
	turf = /turf/exterior/sand
	area = /area/eureka/outside

/datum/random_map/automata/cave_system/eureka
	wall_type =    /turf/simulated/wall/natural/volcanic
	mineral_turf = /turf/simulated/wall/natural/random/volcanic
	floor_type =   /turf/exterior/barren

/datum/random_map/noise/eureka_caves
	descriptor = "Eureka caves"
	smoothing_iterations = 3
	target_turf_type = /turf/exterior/barren

/datum/random_map/noise/eureka_caves/get_appropriate_path(var/value)
	switch(noise2value(value))
		if(1 to 2)
			return /turf/exterior/lava
		if(3)
			return /turf/exterior/volcanic
		if(5 to 6)
			return /turf/exterior/dirt
		if(7 to 9)
			return /turf/exterior/mud/dark

/datum/random_map/noise/eureka_surface
	descriptor = "Eureka surface"
	smoothing_iterations = 3
	target_turf_type = /turf/exterior/sand 

/datum/random_map/noise/eureka_surface/get_appropriate_path(var/value)
	switch(noise2value(value))
		if(1 to 2)
			return /turf/exterior/barren
		if(5 to 6)
			return /turf/exterior/mud
		if(7 to 9)
			return /turf/exterior/mud/dark

/datum/random_map/noise/eureka_surface/get_additional_spawns(var/value, var/turf/T)
	switch(noise2value(value))
		if(3,4)
			if(prob(20))
				new /obj/structure/flora/seaweed(T)
		if(5)
			if(prob(30))
				new /obj/structure/flora/seaweed(T)
			else if(prob(60))
				new /obj/structure/flora/seaweed/large(T)
			else if(prob(10))
				new /obj/structure/flora/seaweed/glow(T)
		if(6)
			if(prob(20))
				new /obj/structure/flora/seaweed(T)
			else if(prob(30))
				new /obj/structure/flora/seaweed/large(T)
			else if (prob(5))
				new /obj/structure/flora/seaweed/glow(T)
		if(7,9)
			if(prob(35))
				new /obj/structure/flora/seaweed/large(T)
			else if(prob(1))
				new /obj/structure/flora/seaweed/glow(T)

/datum/map/eureka/perform_map_generation()
	. = ..()

	// Apply randmaps.
	new /datum/random_map/automata/cave_system/eureka(null, 1, 1, 1, world.maxx, world.maxy)
	new /datum/random_map/noise/ore/rich(             null, 1, 1, 1, world.maxx, world.maxy)
	new /datum/random_map/noise/eureka_caves(         null, 1, 1, 1, world.maxx, world.maxy)
	new /datum/random_map/noise/ore(                  null, 1, 1, 2, world.maxx, world.maxy)
	new /datum/random_map/noise/eureka_surface(       null, 1, 1, 2, world.maxx, world.maxy)

	// Drill sinkholes.
	var/sanity = 1000
	var/sinkholes = 5
	for(var/i = 1 to sinkholes)
		var/turf/T
		while(sanity && (isnull(T) || istype(GetBelow(T), /turf/simulated/wall) || !istype(T, /turf/exterior)))
			sanity--
			T = locate(rand(1,world.maxx), rand(1,world.maxy), 2)
		if(!sanity || !istype(T))
			to_world_log("ERROR: Aborting sinkhole generation early due to sanity clause.")
			break
		
		T.ChangeTurf(/turf/exterior/open)
		for(var/dir in GLOB.cardinal)
			if(prob(33))
				continue
			var/turf/next = get_step(T, dir)
			if(istype(next, /turf/exterior) && !istype(GetBelow(next), /turf/simulated/wall))
				next.ChangeTurf(/turf/exterior/open)

	for(var/turf/exterior/T in block(locate(1,1,2), locate(world.maxx, world.maxy, 3)))
		T.set_light(0.2, 0.1, 2, l_color = COLOR_GREEN_GRAY)
