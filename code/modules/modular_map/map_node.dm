/datum/modular_map_node
	var/generation
	var/datum/modular_map_cell/origin_cell
	var/datum/modular_map_connection/origin
	var/datum/modular_map_connection/target

/datum/modular_map_node/New(_cell, _origin, _target, _gen)
	origin_cell = _cell
	origin      = _origin
	target      = _target
	generation  = _gen

