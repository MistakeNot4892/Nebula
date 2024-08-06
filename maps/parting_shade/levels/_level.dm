/datum/level_data/player_level/parting_shade
	use_global_exterior_ambience = FALSE
	base_area = null
	base_turf = /turf/floor/natural/dirt
	abstract_type = /datum/level_data/player_level/parting_shade
	ambient_light_level = 1
	ambient_light_color = "#f3e6ca"
	exterior_atmosphere = list(
		/decl/material/gas/oxygen =   MOLES_O2STANDARD,
		/decl/material/gas/nitrogen = MOLES_N2STANDARD
	)

/datum/level_data/player_level/parting_shade/testing
	name = "Parting Shade - Test Level"

/obj/abstract/level_data_spawner/parting_shade_testing
	level_data_type = /datum/level_data/player_level/parting_shade/testing
