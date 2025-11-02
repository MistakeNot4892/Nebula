/datum/level_data/main_level/signal
	exterior_atmos_temp = T0C - 35 // a bit chilly
	exterior_atmosphere = list(
		/decl/material/gas/oxygen = MOLES_O2STANDARD,
		/decl/material/gas/nitrogen = MOLES_N2STANDARD,
	)

/obj/abstract/level_data_spawner/signal_level_one
	level_data_type = /datum/level_data/main_level/signal/level_one

/datum/level_data/main_level/signal/level_one
	name = "Yonaguni - Level One"
	level_generators = list(
		/datum/random_map/noise/seafloor
	)

/datum/level_data/main_level/signal/level_two
	name = "Yonaguni - Level Two"

/obj/abstract/level_data_spawner/signal_level_two
	level_data_type = /datum/level_data/main_level/signal/level_one

/datum/level_data/main_level/signal/level_three
	name = "Yonaguni - Level Three"

/obj/abstract/level_data_spawner/signal_level_three
	level_data_type = /datum/level_data/main_level/signal/level_three

/datum/level_data/main_level/signal/level_four
	name = "Yonaguni - Level Four"
	level_generators = list(
		/datum/random_map/automata/cave_system/ice_sheet/flooded
	)

/obj/abstract/level_data_spawner/signal_level_four
	level_data_type = /datum/level_data/main_level/signal/level_four

/datum/level_data/main_level/signal/surface
	name = "Yonaguni - Lemurian Plain"
	level_generators = list(
		/datum/random_map/noise/ice_plain
	)

/obj/abstract/level_data_spawner/signal_surface
	level_data_type = /datum/level_data/main_level/signal/surface

/datum/level_data/main_level/signal/heights
	name = "Yonaguni - Lemurian Heights"

/obj/abstract/level_data_spawner/signal_heights
	level_data_type = /datum/level_data/main_level/signal/heights
