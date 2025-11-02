/world
	turf = /turf/floor/seafloor

/datum/map/signal
	name =         "Yonaguni Dome"
	station_name = "Yonaguni Dome"
	full_name =    "Yonaguni Dome"
	path =         "signal"

	lobby_screens = list('maps/signal/lobby.png')
	lobby_tracks = list(
		/decl/music_track/torn,
		/decl/music_track/martiancowboy,
		/decl/music_track/nebula,
		/decl/music_track/monument
	)

	full_name     = "Yonaguni Dome"
	station_short = "Yonaguni"
	dock_name     = "Rhadamanthus Docks"
	boss_name     = "Administration"
	boss_short    = "Admin"
	company_name  = "Sol Colonial Administration"
	company_short = "CSA-CA"

	allowed_latejoin_spawns = list(
		/decl/spawnpoint/arrivals
	)

	shuttle_docked_message =           "The crew transfer vessel has docked at the Escape arm. Traffic control reports that departure will occur in approximately %ETD%."
	shuttle_leaving_dock =             "The crew transfer vessel has left the Escape arm. Estimate %ETA% until arrival at %dock_name%."
	shuttle_called_message =           "A crew transfer has been scheduled for this shift and a vessel has been dispatched from %dock_name%. Estimated arrival time is %ETA%."
	shuttle_recall_message =           "The crew transfer has been cancelled."
	emergency_shuttle_docked_message = "The evacuation vessel has docked at the Escape arm. Traffic control reports that departure will occur in approximately %ETD%."
	emergency_shuttle_leaving_dock =   "The evacuation vessel has left the Escape arm; escape pods now launching. Estimate %ETA% until arrival at %dock_name%."
	emergency_shuttle_called_message = "An emergency evacuation has been initiated and a submersible is en route from %dock_name%. It will arrive in %ETA%"
	emergency_shuttle_recall_message = "The emergency evacuation has been cancelled."

	available_background_info = list(
		/decl/background_category/citizenship = list(
			/decl/background_detail/citizenship/other
		),
		/decl/background_category/homeworld   = list(
			/decl/background_detail/location/mercury,
			/decl/background_detail/location/venus,
			/decl/background_detail/location/earth,
			/decl/background_detail/location/earth/luna,
			/decl/background_detail/location/mars,
			/decl/background_detail/location/asteroids,
			/decl/background_detail/location/jupiter,
			/decl/background_detail/location/saturn,
			/decl/background_detail/location/uranus,
			/decl/background_detail/location/neptune,
			/decl/background_detail/location/kuiperbelt,
			/decl/background_detail/location/oort/eris,
			/decl/background_detail/location/other
		),
		/decl/background_category/faction     = list(
			/decl/background_detail/faction/csa,
			/decl/background_detail/faction/ts,
			/decl/background_detail/faction/ltc,
			/decl/background_detail/faction/firstwave,
			/decl/background_detail/faction/outer,
			/decl/background_detail/faction/inner,
			/decl/background_detail/faction/cuchulain,
			/decl/background_detail/faction/posthuman,
			/decl/background_detail/faction/other
		),
		/decl/background_category/heritage    = list(
			/decl/background_detail/heritage/sol,
			/decl/background_detail/heritage/mercury,
			/decl/background_detail/heritage/venus,
			/decl/background_detail/heritage/earth,
			/decl/background_detail/heritage/luna,
			/decl/background_detail/heritage/mars,
			/decl/background_detail/heritage/asteroids,
			/decl/background_detail/heritage/jupiter,
			/decl/background_detail/heritage/saturn,
			/decl/background_detail/heritage/uranus,
			/decl/background_detail/heritage/neptune,
			/decl/background_detail/heritage/kuiperbelt,
			/decl/background_detail/heritage/oort
		),
		/decl/background_category/religion    = list(
			/decl/background_detail/religion/jewish,
			/decl/background_detail/religion/hindu,
			/decl/background_detail/religion/buddhist,
			/decl/background_detail/religion/jain,
			/decl/background_detail/religion/sikh,
			/decl/background_detail/religion/muslim,
			/decl/background_detail/religion/christian,
			/decl/background_detail/religion/bahai,
			/decl/background_detail/religion/agnostic,
			/decl/background_detail/religion/deist,
			/decl/background_detail/religion/atheist,
			/decl/background_detail/religion/thelemite,
			/decl/background_detail/religion/spiritualism,
			/decl/background_detail/religion/shinto,
			/decl/background_detail/religion/taoist,
			/decl/background_detail/religion/other
		)
	)

	default_background_info = list(
		/decl/background_category/citizenship = /decl/background_detail/citizenship/other,
		/decl/background_category/homeworld   = /decl/background_detail/location/jupiter/europa,
		/decl/background_category/faction     = /decl/background_detail/faction/outer,
		/decl/background_category/heritage    = /decl/background_detail/heritage/jupiter,
		/decl/background_category/religion    = /decl/background_detail/religion/other
	)

/datum/map/signal/get_map_info()
	return "<b>Yonaguni Dome</b>, bored into the ice plains of Puthiya Natu, is a permanent civilian research facility administered by \
	the Central Solar government. It is old, remote, and poorly funded, but hosts facilities dedicated to studying the sunken continent of \
	Lemuria, a mysterious expanse of alien ruins buried beneath kilometers of ice and dark water."
