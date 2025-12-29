var/global/list/_room_reference_cache = alist()

/datum/mm_room
	var/r_x
	var/r_y
	var/r_w = 1
	var/r_h = 1
	var/debug_label
	var/list/r_cells
	var/list/r_connections

/datum/mm_room/proc/get_initial_connections()
	return null

/datum/mm_room/New(_x, _y, _mx, list/_grid)

	if(isnull(_x) || isnull(_y))
		return // reference copy

	r_x = _x
	r_y = _y

	// Non-null coords means it's not a reference copy, create our connection list.
	for(var/alist/conn_data in get_initial_connections())
		// These should have all been verified prior to room placement.
		var/alist/offset = global._mm_offsets_by_dir[conn_data[MC_DIR]]
		var/c_x = r_x + conn_data[MC_O_X]
		var/c_y = r_y + conn_data[MC_O_Y]
		var/t_x = c_x + offset[MM_X]
		var/t_y = c_y + offset[MM_Y]
		var/datum/mm_connection/conn = new(_grid[TRANSLATE_MODMAP_COORD(c_x, c_y, _mx)], _grid[TRANSLATE_MODMAP_COORD(t_x, t_y, _mx)], conn_data[MC_DIR], conn_data[MC_ROOMS])
		LAZYADD(r_connections, conn)

/datum/mm_room/hallway

/datum/mm_room/hallway/vertical
	debug_label = "|"
	r_h = 2

/datum/mm_room/hallway/vertical/get_initial_connections()
	var/static/list/conns = list(
		alist((MC_O_X) = 0, (MC_O_Y) = 0, (MC_DIR) = SOUTH, (MC_ROOMS) = list(/datum/mm_room/hallway/vertical, /datum/mm_room/chamber)),
		alist((MC_O_X) = 0, (MC_O_Y) = 1, (MC_DIR) = NORTH, (MC_ROOMS) = list(/datum/mm_room/hallway/vertical, /datum/mm_room/chamber)),
	)
	return conns

/datum/mm_room/hallway/horizontal
	debug_label = "-"
	r_w = 2

/datum/mm_room/hallway/horizontal/get_initial_connections()
	var/static/list/conns = list(
		alist((MC_O_X) = 0, (MC_O_Y) = 0, (MC_DIR) = WEST, (MC_ROOMS) = list(/datum/mm_room/hallway/horizontal, /datum/mm_room/chamber)),
		alist((MC_O_X) = 1, (MC_O_Y) = 0, (MC_DIR) = EAST, (MC_ROOMS) = list(/datum/mm_room/hallway/horizontal, /datum/mm_room/chamber)),
	)
	return conns

/datum/mm_room/chamber
	debug_label = "+"
	r_h = 3
	r_w = 3

/datum/mm_room/chamber/get_initial_connections()
	var/static/list/conns = list(
		alist((MC_O_X) = 1, (MC_O_Y) = 2, (MC_DIR) = NORTH, (MC_ROOMS) = list(/datum/mm_room/hallway/vertical)),
		alist((MC_O_X) = 1, (MC_O_Y) = 0, (MC_DIR) = SOUTH, (MC_ROOMS) = list(/datum/mm_room/hallway/vertical)),
		alist((MC_O_X) = 2, (MC_O_Y) = 1, (MC_DIR) = EAST,  (MC_ROOMS) = list(/datum/mm_room/hallway/horizontal)),
		alist((MC_O_X) = 0, (MC_O_Y) = 1, (MC_DIR) = WEST,  (MC_ROOMS) = list(/datum/mm_room/hallway/horizontal))
	)
	return conns
