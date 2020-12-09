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
	emergency_shuttle_recall_message = "The evacuation convoy has cancelled."

	game_year = 2154
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
	return "Welcome to <b>[station_name]</b>, the smallest and dullest jewel in the Crown-Imperial; an isolated mining colony on the desolate backwater planet Nullius. Enjoy a canister of detoxified groundwater, admire the acid swamps, and relax under the radioactive glare of a monstrously swollen sun!"

/decl/currency/trader/crown
	name = "company scrip"
