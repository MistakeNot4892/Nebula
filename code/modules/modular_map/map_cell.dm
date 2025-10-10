
/datum/modular_map_cell
	var/cell_x
	var/cell_y
	var/datum/map_template/modular_map/template
	var/list/available_connections
	var/filler_cell
	var/generation

/datum/modular_map_cell/Destroy()
	LAZYCLEARLIST(available_connections)
	template = null
	return ..()

/datum/modular_map_cell/New(_x, _y, _template, _filler_cell, _generation)
	cell_x = _x
	cell_y = _y
	template = _template
	filler_cell = _filler_cell
	generation = _generation
