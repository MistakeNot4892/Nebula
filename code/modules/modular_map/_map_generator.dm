/decl/modular_map_generator
	abstract_type = /decl/modular_map_generator
	/// Human-readable identifier.
	var/name
	/// A level data type to pass to the new-z proc if needed.
	var/level_data_type = /datum/level_data/empty
	/// Turfs per cell - functionally the grid size of the modular map.
	var/grid_cell_size
	/// Flag to avoid regenerating the template list unnecessarily.
	var/templates_are_setup = FALSE
	/// A list of template types that are available to this map generator.
	var/list/cell_templates
	/// A cache of template instances by their connection category for use in template selection.
	var/list/templates_by_category = list()
	/// A maximum number of templates forming a given path. <= 0 indicates no max.
	var/max_generation = 0 //8
	/// A minimum number of templates forming a given path. <= 0 indicates no max.
	var/min_generation = 0 //5

/decl/modular_map_generator/proc/setup_templates()
	if(templates_are_setup || !SSmapping.initialized)
		return
	var/list/template_instances = list()
	for(var/i = 1 to length(cell_templates))
		var/template_type = cell_templates[i]
		var/datum/map_template/modular_map/template_instance = SSmapping.map_templates_by_type[template_type]
		if(!istype(template_instance))
			PRINT_STACK_TRACE("Map generator [type] has template type [template_type] with no instance on SSmapping.")
		else
			if(!template_instance.connection_flag)
				PRINT_STACK_TRACE("Map generator [type] has template [template_instance.type] with unset connection_flag.")
			if(!length(template_instance.cell_connections))
				PRINT_STACK_TRACE("Map generator [type] has template [template_instance.type] with empty cell_connections.")
			LAZYDISTINCTADD(templates_by_category["[template_instance.connection_flag]"], template_instance)
			template_instances |= template_instance
	cell_templates = template_instances
	templates_are_setup = TRUE

/decl/modular_map_generator/validate()
	. = ..()
	setup_templates()
	if(!name)
		. += "no name set"
	if(!length(cell_templates))
		. += "no templates to place"
	if(!templates_by_category["[MFC_ROOM]"])
		. += "no rooms to place"
	if(!templates_by_category["[MFC_HALL]"])
		. += "no hallways to place"
	if(!isnum(grid_cell_size) || grid_cell_size < 0)
		. += "invalid grid cell size ([grid_cell_size || "NULL"])"
	if(!level_data_type)
		. += "no level data type set"

#define TRANSLATE_MODMAP_COORD(X, Y, WIDTH) ((((Y) - 1) * WIDTH) + (X))

/decl/modular_map_generator/proc/place_on_grid(datum/map_template/modular_map/placing, list/grid, place_x, place_y, bound_x, bound_y, generation)

	if(max_generation > 0 && generation >= max_generation && !placing.is_terminator)
		return null
	if(min_generation > 0 && generation < min_generation && placing.is_terminator)
		return null

	// We will be returning a list of connections resulting from this placement.
	// An empty/null return means a failed placement.
	// Cell width/height are absolute, not an offset.
	var/place_x_m = place_x + (placing.cell_width-1)
	var/place_y_m = place_y + (placing.cell_height-1)

	// We always go bottom left to top right, and will never be given a negative origin, so only check the top right bound.
	if(place_x_m >= bound_x || place_y_m >= bound_y)
		return null

	// Quick check to make sure there's actually room for us to be placed here.
	for(var/x = place_x to place_x_m)
		for(var/y = place_y to place_y_m)
			if(!isnull(grid[TRANSLATE_MODMAP_COORD(x, y, bound_x)]))
				return null

	// Check what connections will be free after this tile is placed.
	// Connection targets with no corresponding cell are valid.
	// Connection targets which match the type and orientation of the corresponding cell are valid.
	var/list/available_connections
	for(var/i in 1 to length(placing.cell_connections))

		var/datum/modular_map_connection/connection = placing.cell_connections[i]

		// Work out the coords for the cell we're trying to connect to.
		var/target_x = place_x + connection.offset_x + connection.target_x
		var/target_y = place_y + connection.offset_y + connection.target_y

		// Connection target is outside of map bounds - this room cannot be placed here if we want our map to be complete.
		if(target_x < 1 || target_y < 1 || target_x >= bound_x || target_y >= bound_y)
			return null

		// What is in the cell we're targeting?
		var/datum/modular_map_cell/target_cell = grid[TRANSLATE_MODMAP_COORD(target_x, target_y, bound_x)]

		// Connection target is free, we don't need to check existing connections...
		if(isnull(target_cell))
			// It's unoccupied and we aren't blocking a connection, we can use this spot.
			LAZYADD(available_connections, connection)
			continue

		// Connection target has no connections (wall, or all connections used)
		if(!length(target_cell.available_connections))
			return null

		// We need to find a potential match for all our connections in the target connections.
		var/found_cell = FALSE
		for(var/con_i = 1 to length(target_cell.available_connections))
			var/datum/modular_map_connection/target_connection = target_cell.available_connections[con_i]
			if(!connection.can_connect_to(target_connection))
				continue
			// This one is possible! Mark it down for later and continue evaluation.
			found_cell = TRUE
			LAZYSET(available_connections, connection, target_connection)
			break

		// No partner/space for this connection, so this template is unplacable.
		if(!found_cell)
			return null

	// We have not been able to find a partner or empty cell for all of our outgoing connections.
	if(length(available_connections) != length(placing.cell_connections))
		return null

	// This room is placable - populate the cells in the grid with it.
	for(var/x = place_x to place_x_m)
		for(var/y = place_y to place_y_m)
			grid[TRANSLATE_MODMAP_COORD(x, y, bound_x)] = new /datum/modular_map_cell(x, y, placing, (x != place_x || y != place_y), generation+1)

	for(var/i = 1 to length(available_connections))
		var/datum/modular_map_connection/connection = available_connections[i]
		var/datum/modular_map_connection/target_connection = available_connections[connection]
		var/dangling_x = place_x + connection.offset_x
		var/dangling_y = place_y + connection.offset_y
		if(istype(target_connection))
			// Retrieve our target cell and remove the now-linked connection from the list.
			var/target_x = dangling_x + connection.target_x
			var/target_y = dangling_y + connection.target_y
			var/datum/modular_map_cell/target_cell = grid[TRANSLATE_MODMAP_COORD(target_x, target_y, bound_x)]
			LAZYREMOVE(target_cell.available_connections, target_connection)

		else
			// Add connections with no neighbor to the return list, and make sure their cell is aware of them..
			var/datum/modular_map_cell/dangling_cell = grid[TRANSLATE_MODMAP_COORD(dangling_x, dangling_y, bound_x)]
			LAZYDISTINCTADD(dangling_cell.available_connections, connection)

			// Enter this node into the queue.
			var/datum/modular_map_node/node = new(dangling_cell, connection, target_connection, generation+1)
			LAZYADD(., node)

/decl/modular_map_generator/proc/get_initial_template()
	return pick(templates_by_category["[MFC_ROOM]"])

/decl/modular_map_generator/proc/generate()

	set waitfor = FALSE

	if(!SSmapping.initialized)
		to_chat(usr, SPAN_WARNING("Please wait until SSmapping initialization so template setup can complete."))
		return TRUE

	setup_templates()
	var/initial_template = get_initial_template()
	if(!initial_template)
		to_world("No initial template, generation failed.")
		return FALSE

	// Declare a list for tracking our occupied space and pre-build our graph.
	var/cell_max_x = floor(world.maxx / grid_cell_size)-1
	var/cell_max_y = floor(world.maxy / grid_cell_size)-1
	var/list/grid = new /list(TRANSLATE_MODMAP_COORD(cell_max_x, cell_max_y, cell_max_x))

	var/const/LOOP_SANITY = 100000
	// Place our central room and keep track of the connections it provides for the main loop.
	var/sanity = LOOP_SANITY
	var/list/nodes = place_on_grid(initial_template, grid, round(rand(cell_max_x * 0.3, cell_max_x * 0.6)), round(rand(cell_max_y * 0.3, cell_max_y * 0.6)), cell_max_x, cell_max_y)
	while(length(nodes) && sanity)

		// Pick one of our remaining connections.
		var/datum/modular_map_node/node             = pick(nodes)
		var/datum/modular_map_connection/connection = node.origin
		var/datum/modular_map_cell/cell             = node.origin_cell

		// Try to find a template that we can connect to this spot.
		shuffle(global._mm_all_connection_flags)
		for(var/con_i = 1 to length(global._mm_all_connection_flags))

			var/connection_flag = global._mm_all_connection_flags[con_i]

			if(!(connection.connection_flags & connection_flag))
				continue

			// Dummy connection, skip.
			if(connection_flag & MFC_NONE)
				continue

			// Determine the bottom-left corner of the space needed to fit this template from this connection.
			var/list/templates = templates_by_category[connection_flag]
			if(!islist(templates))
				continue

			// Randomise template order to avoid always placing a northeast corner or whatever.
			templates = shuffle(templates)
			for(var/t_i = 1 to length(templates))

				var/datum/map_template/modular_map/template = templates[t_i]
				// Coarse parse; find all connections in this template that are facing the right way
				// and have the right connection type to match up with our outgoing connection.
				var/list/possible_connections = list()
				for(var/pc_i = 1 to length(template.cell_connections))
					var/datum/modular_map_connection/possible_connection = template.cell_connections[pc_i]
					if(connection.can_connect_to(possible_connection))
						// Nominally compatible; it will fail placement if it overlaps with an existing cell.
						possible_connections += possible_connection
					CHECK_TICK

				// Not even remotely possible.
				if(!length(possible_connections))
					continue

				possible_connections = shuffle(possible_connections)
				var/connection_x = (cell.cell_x + connection.target_x)
				var/connection_y = (cell.cell_y + connection.target_y)
				for(var/pc_i = 1 to length(possible_connections))

					var/datum/modular_map_connection/possible_connection = possible_connections[pc_i]

					// Get base template origin coords, then adjust for template size.
					var/place_x = connection_x
					var/place_y = connection_y
					// Note to future self: cell width/height are absolute, not an offset, hence -1.
					switch(connection.direction_string)
						if("NORTH")
							place_x -= possible_connection.offset_x
						if("SOUTH")
							place_x -= possible_connection.offset_x
							place_y -= (template.cell_height-1)
						if("EAST")
							place_y -= possible_connection.offset_y
						if("WEST")
							place_x -= (template.cell_width-1)
							place_y -= possible_connection.offset_y

					// Immediately out of bounds, no thank you.
					if(place_x < 1 || place_y < 1)
						continue

					CHECK_TICK

					// Actually try to place this template from our connection.
					var/list/placement_results = place_on_grid(template, grid, place_x, place_y, cell_max_x, cell_max_y, node.generation)
					if(length(placement_results))
						nodes -= node
						for(var/n_i = 1 to length(placement_results))
							nodes |= placement_results[n_i]
						connection = null
						sanity = LOOP_SANITY // reset our failure counter
						break

				// Connection is null, we're done.
				if(!connection)
					break
				CHECK_TICK
			if(!connection)
				break
			CHECK_TICK

		// If connection has not been cleared, then we failed to place a template.
		if(connection)
			sanity--
		CHECK_TICK

	// Keep track of load operations to run after we finalize our map.
	var/target_z = world.maxz+1
	while(world.maxz < target_z)
		SSmapping.increment_world_z_size(level_data_type)

	var/list/load_operations = list()
	for(var/c_i in 1 to length(grid))
		var/datum/modular_map_cell/cell = grid[c_i]
		// Non-origin cell; disregard.
		if(cell.filler_cell)
			continue
		var/turf/cell_origin = locate((cell.cell_x * grid_cell_size), (cell.cell_y * grid_cell_size), target_z)
		if(istype(cell_origin))

			load_operations[cell_origin] = cell.template
		CHECK_TICK

	if(!length(load_operations))
		to_world("No load operations (grid count is [length(grid)]).")
		return FALSE

	global._gag_report_progress++ // disable template load subsystem spam.
	try
		var/announced = FALSE
		for(var/i = 1 to length(load_operations))
			var/turf/load_turf = load_operations[i]
			var/datum/map_template/template = load_operations[load_turf]
			template.load(load_turf)
			if(!announced)
				announced = TRUE
				admin_notice("<span class='boldannounce'>Placed modular generated map (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[load_turf.x];Y=[load_turf.y];Z=[load_turf.z]'>JMP</a>)</span>", R_DEBUG)
				to_world_log("Placed modular generated map at [load_turf.x],[load_turf.y],[load_turf.z]")
	catch(var/exception/E)
		log_error("Exception during final DMMS load of [type]: [EXCEPTION_TEXT(E)]")
	global._gag_report_progress-- // enable subsystem spam.

	QDEL_LIST(grid)

	// DMMS and mapload alters wall connection behavior, give it a poke to ensure they blend correctly.
	for(var/turf/turf as anything in block(locate(1, 1, target_z), locate(world.maxx, world.maxy, target_z)))
		if(!turf.simulated)
			continue
		if(istype(turf, /turf/wall))
			var/turf/wall/wall = turf
			wall.update_material(FALSE)
		else
			turf.update_icon()

	return TRUE
