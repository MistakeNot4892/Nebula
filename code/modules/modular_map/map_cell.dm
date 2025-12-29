/datum/mm_cell
	var/c_x
	var/c_y
	var/alist/_neighbors = alist()
	var/blocked = FALSE
	var/datum/mm_room/c_room

/datum/mm_cell/New(_x, _y)
	c_x = _x
	c_y = _y

/datum/mm_cell/proc/print(label)
	to_world("[label] cell: [c_x],[c_y]")
	for(var/dir,n in _neighbors)
		var/datum/mm_cell/neighbor = n
		to_world("- [dir_name(dir)]: [neighbor.c_x],[neighbor.c_y]")
