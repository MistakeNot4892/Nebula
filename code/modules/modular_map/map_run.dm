/datum/mm_run
	var/list/_grid
	var/g_mx
	var/g_my
	var/list/_pending

/datum/mm_run/New(_x, _y)
	g_mx = _x
	g_my = _y

	// Build our basic grid structure.
	_grid = new /list(TRANSLATE_MODMAP_COORD(g_mx, g_my, g_mx))
	for(var/x = 0 to g_mx)
		for(var/y = 0 to g_my)
			_grid[TRANSLATE_MODMAP_COORD(x, y, g_mx)] = new /datum/mm_cell(x, y)

	// TODO: when applying to a real map, check the corresponding sector of the real map for blockage and set blocked to TRUE

	// Connect every cell to every neighboring cell for ease of grid traversal later.
	for(var/datum/mm_cell/cell as anything in _grid)
		for(var/dir,offset in global._mm_offsets_by_dir)
			var/o_x = cell.c_x + offset[MM_X]
			var/o_y = cell.c_y + offset[MM_Y]
			if(INVALID_MODMAP_COORDS(o_x, o_y, g_mx, g_my))
				continue
			var/datum/mm_cell/neighbor = _grid[TRANSLATE_MODMAP_COORD(o_x, o_y, g_mx)]
			if(neighbor.blocked)
				continue
			cell._neighbors[dir] = neighbor

/datum/mm_run/proc/place_room(_room_type, _x, _y)

	// Write our room instance to the relevant cells.
	var/datum/mm_room/room = new _room_type(_x, _y, g_mx, _grid)
	for(var/x = 0 to (room.r_w-1))
		for(var/y = 0 to (room.r_h-1))
			// Coords are pre-validated, write the room to this cell.
			var/t_x = _x+x
			var/t_y = _y+y
			var/datum/mm_cell/cell = _grid[TRANSLATE_MODMAP_COORD(t_x, t_y, g_mx)]
			cell.c_room = room
			LAZYDISTINCTADD(room.r_cells, cell)

	// Return any unoccupied connections for further iteration.
	. = list()
	for(var/datum/mm_connection/conn in room.r_connections)
		to_world("checking conn at [conn.c_cell.c_x],[conn.c_cell.c_y] pointing [dir_name(conn.c_dir)] to [conn.c_target.c_x],[conn.c_target.c_y]")
		if(!conn.c_target.c_room)
			to_world("adding conn at [conn.c_cell.c_x],[conn.c_cell.c_y] pointing [dir_name(conn.c_dir)] to [conn.c_target.c_x],[conn.c_target.c_y] to pending")
			. += conn

/datum/mm_run/proc/generate_map()

	var/list/new_connections
	if(isnull(_pending))
		to_world("First run, placing initial central chamber.")
		_pending = try_place_room(/datum/mm_room/chamber, round(g_mx / 2), round(g_my / 2))
	else if(!length(_pending))
		to_world("No more pending connections, initial gen is done.")
	else

		to_world("Placing connected room.")
		var/datum/mm_connection/conn = _pending[1]
		_pending -= conn
		if(conn.c_target.c_room)
			to_world("Connection already in use, skipping.")
			return generate_map()

		var/placed_room = FALSE
		for(var/room_type in shuffle(conn.c_room_types))

			var/datum/mm_room/room = _mm_get_reference_room(room_type)

			for(var/alist/conn_data in shuffle(room.get_initial_connections()))

				// We can only connect to potential connections facing us.
				if(conn_data[MC_DIR] != global.reverse_dir[conn.c_dir])
					continue

				// A connection at 0,0 (or a room with dimensions 1,1) will sit neatly in the target cell for the connection we're processing.
				// Otherwise we need to offset so our new room will align connections.
				// Target cell coord - connection offset = origin, hopefully
				new_connections = try_place_room(room_type, conn.c_target.c_x - conn_data[MC_O_X], conn.c_target.c_y - conn_data[MC_O_Y])
				if(!isnull(new_connections))
					placed_room = TRUE
					break

			if(placed_room)
				break

		if(length(new_connections))
			_pending += new_connections

/datum/mm_run/proc/print_map()
	for(var/y = g_my; y >= 0; y--)
		var/line = ""
		for(var/x = 0 to g_mx)
			var/datum/mm_cell/cell = _grid[TRANSLATE_MODMAP_COORD(x, y, g_mx)]
			var/use_label
			for(var/datum/mm_connection/conn in _pending)
				if(conn.c_cell == cell && !conn.c_target.c_room)
					if(!conn.c_cell.c_room)
						use_label = "?"
					else if(isnull(use_label))
						switch(conn.c_dir)
							if(NORTH)
								use_label = "^"
							if(SOUTH)
								use_label = "v"
							if(EAST)
								use_label = ">"
							if(WEST)
								use_label = "<"
					else
						use_label = "X"
			line += use_label || (cell.blocked ? "#" : (cell.c_room?.debug_label || "."))
		to_world(line)

/datum/mm_run/proc/try_place_room(_room_type, _x, _y)

	// We're trying to place outside of map bounds for some reason.
	if(INVALID_MODMAP_COORDS(_x, _y, g_mx, g_my))
		return null

	var/datum/mm_room/room = _mm_get_reference_room(_room_type)
	// Check if there is fundamentally enough space on the grid to place this room at this position.
	for(var/x = 0 to (room.r_w-1))
		for(var/y = 0 to (room.r_h-1))
			var/t_x = _x + x
			var/t_y = _y + y
			if(INVALID_MODMAP_COORDS(t_x, t_y, g_mx, g_my))
				return null
			// Check if we are overlapping another room or a blocked area.
			var/datum/mm_cell/cell = _grid[TRANSLATE_MODMAP_COORD(t_x, t_y, g_mx)]
			if(cell.blocked || cell.c_room)
				return null

	// Check if placing a room here will block any pending cell connections from adjacent cells.
	// This also serves to validate our own connections.
	var/list/initial_connections = room.get_initial_connections()
	var/mx = (room.r_w-1)
	var/my = (room.r_h-1)
	for(var/o_x = 0 to mx)
		for(var/o_y = 0 to my)

			var/list/check_dirs = list()
			if(o_x == 0)
				check_dirs += WEST
			else if(o_x == mx)
				check_dirs += EAST

			if(o_y == 0)
				check_dirs += SOUTH
			else if(o_y == my)
				check_dirs += NORTH

			// Not on the boundary, don't care!
			if(!length(check_dirs))
				continue

			var/x = _x + o_x
			var/y = _y + o_y

			// Collect relevant connection data to avoid iterating the conn list repeatedly.
			var/datum/mm_cell/cell = _grid[TRANSLATE_MODMAP_COORD(x, y, g_mx)]
			var/list/cell_connections = list()
			for(var/alist/conn_data in initial_connections)
				if(conn_data[MC_O_X] == o_x && conn_data[MC_O_Y] == o_y)
					cell_connections += conn_data

			// Check if our pending connections can connect from here.
			for(var/alist/conn_data in cell_connections)
				var/datum/mm_cell/neighbor = cell._neighbors[conn_data[MC_DIR]]
				// Target cell does not exist, we can't connect here.
				if(!neighbor)
					return null
				// Target cell is blocked, we can't connect here.
				if(neighbor.blocked)
					return null
				// We don't need to recheck this dir for blocked neighbors after we assess it.
				check_dirs -= conn_data[MC_DIR]
				// Target cell is unoccupied, no worries.
				if(!neighbor.c_room)
					continue
				// Check incoming connections for an aligning connection.
				var/found_connection = FALSE
				for(var/datum/mm_connection/conn in neighbor.c_room.r_connections)
					// Not pointed at us.
					if(conn.c_target != cell)
						continue
					// We cannot connect to this connection.
					if(!(_room_type in conn.c_room_types))
						continue
					found_connection = TRUE
					break
				// Couldn't connect here, placement is invalid.
				if(!found_connection)
					return null

			// Check any remaining directions to make sure we aren't blocking any incoming connections.
			for(var/check_dir in check_dirs)
				var/datum/mm_cell/neighbor = cell._neighbors[check_dir]
				// Target cell does not exist, we can't block it.
				if(!neighbor)
					continue
				// Target cell is blocked, we can't block it.
				if(neighbor.blocked)
					continue
				// Target cell has no room, we can't block it.
				if(!neighbor.c_room)
					continue
				// Check neighbor connections to ensure we can join.
				for(var/datum/mm_connection/conn in neighbor.c_room.r_connections)
					// Not pointed at us.
					if(conn.c_target != cell)
						continue
					var/found_connection = FALSE
					for(var/alist/conn_data in cell_connections)
						// Not aligned with us, not relevant.
						if(conn.c_dir != global.reverse_dir[conn_data[MC_DIR]])
							continue
						// We cannot connect this connection.
						if(!(neighbor.c_room.type in conn_data[MC_ROOMS]))
							continue
						found_connection = TRUE
						break
					// Couldn't connect here, placement is invalid.
					if(!found_connection)
						return null

	return place_room(_room_type, _x, _y)
