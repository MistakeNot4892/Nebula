/datum/map/signal
	name = "Signal"
	full_name = "The Signal"
	path = "signal"

	lobby_screens = list('maps/signal/lobby.png')
	lobby_tracks = list(/music_track/absconditus)

	station_levels = list(1, 2, 3)
	contact_levels = list(1, 2, 3)
	player_levels = list(1, 2, 3)

	allowed_spawns = list("Arrivals Shuttle")

	shuttle_docked_message = "The shuttle has docked."
	shuttle_leaving_dock = "The shuttle has departed from home dock."
	shuttle_called_message = "A scheduled transfer shuttle has been sent."
	shuttle_recall_message = "The shuttle has been recalled"
	emergency_shuttle_docked_message = "The emergency escape shuttle has docked."
	emergency_shuttle_leaving_dock = "The emergency escape shuttle has departed from %dock_name%."
	emergency_shuttle_called_message = "An emergency escape shuttle has been sent."
	emergency_shuttle_recall_message = "The emergency shuttle has been recalled"

	available_cultural_info = list(
		TAG_HOMEWORLD = list(
			/decl/cultural_info/location/mercury,
			/decl/cultural_info/location/venus,
			/decl/cultural_info/location/earth,
			/decl/cultural_info/location/earth/luna,
			/decl/cultural_info/location/mars,
			/decl/cultural_info/location/asteroids,
			/decl/cultural_info/location/jupiter,
			/decl/cultural_info/location/saturn,
			/decl/cultural_info/location/uranus,
			/decl/cultural_info/location/neptune,
			/decl/cultural_info/location/kuiperbelt,
			/decl/cultural_info/location/oort/eris,
			/decl/cultural_info/location/other
		),
		TAG_FACTION = list(
			/decl/cultural_info/faction/csa,
			/decl/cultural_info/faction/ts,
			/decl/cultural_info/faction/ltc,
			/decl/cultural_info/faction/firstwave,
			/decl/cultural_info/faction/outer,
			/decl/cultural_info/faction/inner,
			/decl/cultural_info/faction/cuchulain,
			/decl/cultural_info/faction/posthuman,
			/decl/cultural_info/faction/other
		),
		TAG_CULTURE = list(
			/decl/cultural_info/culture/sol,
			/decl/cultural_info/culture/mercury,
			/decl/cultural_info/culture/venus,
			/decl/cultural_info/culture/earth,
			/decl/cultural_info/culture/luna,
			/decl/cultural_info/culture/mars,
			/decl/cultural_info/culture/asteroids,
			/decl/cultural_info/culture/jupiter,
			/decl/cultural_info/culture/saturn,
			/decl/cultural_info/culture/uranus,
			/decl/cultural_info/culture/neptune,
			/decl/cultural_info/culture/kuiperbelt,
			/decl/cultural_info/culture/oort
		),
		TAG_RELIGION = list(
			/decl/cultural_info/religion/jewish,
			/decl/cultural_info/religion/hindu,
			/decl/cultural_info/religion/buddhist,
			/decl/cultural_info/religion/jain,
			/decl/cultural_info/religion/sikh,
			/decl/cultural_info/religion/muslim,
			/decl/cultural_info/religion/christian,
			/decl/cultural_info/religion/bahai,
			/decl/cultural_info/religion/agnostic,
			/decl/cultural_info/religion/deist,
			/decl/cultural_info/religion/atheist,
			/decl/cultural_info/religion/thelemite,
			/decl/cultural_info/religion/spiritualism,
			/decl/cultural_info/religion/shinto,
			/decl/cultural_info/religion/taoist,
			/decl/cultural_info/religion/other
		)
	)

	default_cultural_info = list(
		TAG_HOMEWORLD = /decl/cultural_info/location/saturn,
		TAG_FACTION =   /decl/cultural_info/faction/outer,
		TAG_CULTURE =   /decl/cultural_info/culture/saturn,
		TAG_RELIGION =  /decl/cultural_info/religion/other
	)
