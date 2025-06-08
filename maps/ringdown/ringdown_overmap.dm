/datum/map/ringdown
	overmap_ids = list(OVERMAP_ID_RINGDOWN_PLANET = /datum/overmap/ringdown)

/datum/overmap/ringdown
	name = OVERMAP_ID_RINGDOWN_PLANET
	map_size_x = 150
	map_size_y = 150
	var/static/list/static_sites = list(
		/datum/map_template/ruin/ringdown/khakrikita_kha,
		/datum/map_template/ruin/ringdown/far_shore,
		/datum/map_template/ruin/ringdown/coppercreche,
		/datum/map_template/ruin/ringdown/breakwater,
		/datum/map_template/ruin/ringdown/atonal_waterfall
	)

/datum/overmap/ringdown/New()
	..()
	for(var/template in static_sites)
		var/datum/map_template/template_load = template
		var/template_name = initial(template_load.name)
		template_load = SSmapping.get_template(template_name)
		if(!istype(template_load))
			PRINT_STACK_TRACE("Failed to locate static template '[template_name]'.")
			continue
		log_debug("Loading overmap static site '[template_load.name]'.")
		template_load?.load_new_z(TRUE, TRUE)
