/datum/map/ringdown

	name = "The Plate"
	full_name = "The Plate"
	station_name = "The Plate"
	path = "ringdown"

	lobby_screens = list(
		'maps/ringdown/lobby/lobby.png'
	)

	lobby_tracks = list(
		/decl/music_track/andy_g_cohen/mul_div/space
	)

	default_spawn = /decl/spawnpoint/drifting
	allowed_latejoin_spawns = list(
		/decl/spawnpoint/drifting
	)

	default_job_title = "Drifter"
	default_job_type = /datum/job/ringdown/drifter
	allowed_jobs = list(
		/datum/job/ringdown/drifter,
		/datum/job/ringdown/breakwater,
		/datum/job/ringdown/breakwater/salvager,
		/datum/job/ringdown/breakwater/worker,
		/datum/job/ringdown/mantid,
		/datum/job/ringdown/mantid/hunter,
		/datum/job/ringdown/mantid/auxiliary,
		/datum/job/ringdown/khakrikita_kha,
		/datum/job/ringdown/khakrikita_kha/arktender,
		/datum/job/ringdown/khakrikita_kha/auxiliary,
		/datum/job/ringdown/far_shore,
		/datum/job/ringdown/far_shore/keeper,
		/datum/job/ringdown/far_shore/geist,
		/datum/job/ringdown/chrysoarmis,
		/datum/job/ringdown/chrysoarmis/denizen,
		/datum/job/ringdown/chrysoarmis/visitor
	)

	available_background_info = list(
		/decl/background_category/homeworld = list(
			/decl/background_detail/location/ringdown_wasteland,
			/decl/background_detail/location/ringdown_breakwater,
			/decl/background_detail/location/ringdown_far_shore,
			/decl/background_detail/location/ringdown_coppercreche,
			/decl/background_detail/location/ringdown_atonal_waterfall,
			/decl/background_detail/location/ringdown_khakrikita_kha
		),
		/decl/background_category/faction =   list(
			/decl/background_detail/faction/ringdown_drifter,
			/decl/background_detail/faction/ringdown_coursers,
			/decl/background_detail/faction/ringdown_raiders,
			/decl/background_detail/faction/ringdown_psionics,
			/decl/background_detail/faction/ringdown_shoaler_aux,
			/decl/background_detail/faction/ringdown_feline_aux,
			/decl/background_detail/faction/ringdown_veiled_aux
		),
		/decl/background_category/heritage =  list(/decl/background_detail/heritage/other),
		/decl/background_category/religion =  list(/decl/background_detail/religion/other)
	)

	default_background_info = list(
		/decl/background_category/homeworld = /decl/background_detail/location/ringdown_wasteland,
		/decl/background_category/faction =   /decl/background_detail/faction/ringdown_drifter,
		/decl/background_category/heritage =  /decl/background_detail/heritage/other,
		/decl/background_category/religion =  /decl/background_detail/religion/other
	)

/datum/level_data/ringdown
	base_turf = /turf/floor/ringfall
	level_flags = ZLEVEL_PLAYER
	use_global_exterior_ambience = FALSE
	ambient_light_level = 0.3
	ambient_light_color = "#aca4ce"
	exterior_atmosphere = list(
		/decl/material/gas/oxygen =   MOLES_O2STANDARD,
		/decl/material/gas/nitrogen = MOLES_N2STANDARD
	)
	level_generators = list(
		/datum/random_map/noise/ringdown_dustlands
	)
	base_area = /area/ringdown/wastes
