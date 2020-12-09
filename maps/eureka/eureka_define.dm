/datum/map/eureka
	name = "Eureka"
	full_name = "Port Eureka"
	path = "eureka"
	ground_noun = "ground"

	default_currency = /decl/currency/trader/crown

	lobby_screens = list('maps/eureka/lobby.png')
	lobby_tracks = list(/music_track/absconditus)

	station_levels = list(1, 2, 3)
	contact_levels = list(1, 2, 3)
	player_levels = list(1, 2, 3)

	allowed_spawns = list("Landing Pad")

	shuttle_docked_message =           "The convoy has arrived."
	shuttle_leaving_dock =             "The convoy has departed from %dock_name%."
	shuttle_called_message =           "A scheduled transfer convoy is being assembled and will set out shortly."
	shuttle_recall_message =           "The convoy has been cancelled"
	emergency_shuttle_docked_message = "The evacuation convoy has arrived."
	emergency_shuttle_leaving_dock =   "The evacuation convoy has departed from %dock_name%."
	emergency_shuttle_called_message = "An evacuation convoy is being assembled and will set out shortly."
	emergency_shuttle_recall_message = "The evaciation convoy has cancelled."

	station_name  = "Port Eureka"
	station_short = "Eureka"

	dock_name     = "Mount Carmine"
	boss_name     = "Crown-Imperial Company"
	boss_short    = "Crown"
	company_name  = "Port Eureka"
	company_short = "Eureka"

	use_overmap = FALSE

	starting_money = 2500
	department_money = 0
	salary_modifier = 0.5

/datum/spawnpoint/arrivals
	display_name = "Landing Pad"
	msg = "has touched down on the Port Eureka landing pad"

/datum/map/eureka/get_map_info()
	return "Welcome to <b>[station_name]</b>, the smallest and dullest jewel in the Crown-Imperial; an isolated mining colony on the desolate backwater planet Nullius. Enjoy a canister of detoxified groundwater, admire the acid swamp, and relax under the radioactive glare of a monstrously swollen sun!"

/datum/map/eureka/perform_map_generation()
	. = ..()
	new /datum/random_map/automata/cave_system(null, 1, 1, 1, 90, 90)
	new /datum/random_map/noise/ore/rich(null, 1, 1, 1, 90, 90)
	new /datum/random_map/noise/ore(null, 1, 1, 2, 90, 90)
	for(var/turf/exterior/T in block(locate(1,1,1),locate(world.maxx, world.maxy, 1)))
		T.set_light(0.5, 0.1, 2, l_color = COLOR_GREEN_GRAY)
	for(var/turf/exterior/T in block(locate(1,1,2),locate(world.maxx, world.maxy, 2)))
		T.set_light(0.5, 0.1, 2, l_color = COLOR_GREEN_GRAY)

/decl/currency/trader/crown
	name = "company scrip"

/world
	turf = /turf/exterior/sand
	area = /area/eureka/outside

/datum/map/eureka
	exterior_atmos_temp = T0C - 4 
	exterior_atmos_composition = list(
		/decl/material/gas/oxygen =    MOLES_CELLSTANDARD * 0.16,
		/decl/material/gas/nitrogen =  MOLES_CELLSTANDARD * 0.83,
		/decl/material/gas/chlorine =  MOLES_CELLSTANDARD * 0.03
	)