/datum/mm_connection
	var/c_dir
	var/datum/mm_cell/c_cell
	var/datum/mm_cell/c_target
	var/list/c_room_types

/datum/mm_connection/New(_cell, _target, _dir, _rooms)
	c_cell       = _cell
	c_target     = _target
	c_dir        = _dir
	c_room_types = _rooms
