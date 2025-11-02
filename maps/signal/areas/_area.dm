/area/europa_exterior
	icon = 'maps/signal/icons/areas.dmi'
	icon_state = "ocean_deep"
	requires_power =   1
	always_unpowered = 1
	dynamic_lighting = TRUE
	power_light =   0
	power_equip =   0
	power_environ = 0
	area_flags = AREA_FLAG_EXTERNAL | AREA_FLAG_IS_NOT_PERSISTENT | AREA_FLAG_IS_BACKGROUND | AREA_FLAG_RAD_SHIELDED
	base_turf = /turf/floor/seafloor
	turf_initializer = /decl/turf_initializer/ocean
	open_turf = /turf/open/flooded
	color = COLOR_LIQUID_WATER
	is_outside = OUTSIDE_NO

/area/europa
	name = "\improper Construction Site"
	icon = 'maps/signal/icons/areas.dmi'
	icon_state = "built"
	base_turf = /turf/floor/plating
	color = COLOR_GRAY

/area/europa/Initialize()
	color = null
	. = ..()

// Commit ref for when areas are readded:
// maint: turf_initializer = /decl/turf_initializer/maintenance/ocean
