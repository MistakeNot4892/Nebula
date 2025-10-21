/decl/modular_map_generator/aqueduct
	name = "Aqueducts"
	grid_cell_size = 9
	cell_templates = list(
		/datum/map_template/modular_map/aqueduct/chamber,
		/datum/map_template/modular_map/aqueduct/junction,
		/datum/map_template/modular_map/aqueduct/ne,
		/datum/map_template/modular_map/aqueduct/nw,
		/datum/map_template/modular_map/aqueduct/se,
		/datum/map_template/modular_map/aqueduct/sw,
		/datum/map_template/modular_map/aqueduct/vertical,
		/datum/map_template/modular_map/aqueduct/horizontal,
		/datum/map_template/modular_map/aqueduct/esw,
		/datum/map_template/modular_map/aqueduct/swn,
		/datum/map_template/modular_map/aqueduct/wne,
		/datum/map_template/modular_map/aqueduct/nes,
		/datum/map_template/modular_map/aqueduct/end/n,
		/datum/map_template/modular_map/aqueduct/end/s,
		/datum/map_template/modular_map/aqueduct/end/w,
		/datum/map_template/modular_map/aqueduct/end/e,
		/datum/map_template/modular_map/aqueduct/water/junction,
		/datum/map_template/modular_map/aqueduct/water/ne,
		/datum/map_template/modular_map/aqueduct/water/nw,
		/datum/map_template/modular_map/aqueduct/water/se,
		/datum/map_template/modular_map/aqueduct/water/sw,
		/datum/map_template/modular_map/aqueduct/water/horizontal,
		/datum/map_template/modular_map/aqueduct/water/vertical,
		/datum/map_template/modular_map/aqueduct/water/esw,
		/datum/map_template/modular_map/aqueduct/water/swn,
		/datum/map_template/modular_map/aqueduct/water/wne,
		/datum/map_template/modular_map/aqueduct/water/nes,
		/datum/map_template/modular_map/aqueduct/water/end/n,
		/datum/map_template/modular_map/aqueduct/water/end/s,
		/datum/map_template/modular_map/aqueduct/water/end/e,
		/datum/map_template/modular_map/aqueduct/water/end/w,
		/datum/map_template/modular_map/aqueduct/bridge/vertical,
		/datum/map_template/modular_map/aqueduct/bridge/horizontal
	)

/datum/map_template/modular_map/aqueduct
	generator = /decl/modular_map_generator/aqueduct
	abstract_type = /datum/map_template/modular_map/aqueduct
	template_flags = TEMPLATE_FLAG_CLEAR_CONTENTS | TEMPLATE_FLAG_NO_RUINS
	connection_flag = MFC_HALL
	cell_width = 1
	cell_height = 1

/datum/map_template/modular_map/aqueduct/junction
	name = "Aqueduct - Passage Junction"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_junction.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/junction/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/ne
	name = "Aqueduct - Passage NE"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_ne.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/ne/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/nw
	name = "Aqueduct - Passage NW"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_nw.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/nw/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/se
	name = "Aqueduct - Passage SE"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_se.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/se/New()
	cell_connections = list(
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/sw
	name = "Aqueduct - Passage SW"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_sw.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/sw/New()
	cell_connections = list(
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/vertical
	name = "Aqueduct - Passage Vertical"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_vertical.dmm")

/datum/map_template/modular_map/aqueduct/vertical/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_ROOM | MFC_BRIDGE)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_ROOM | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/horizontal
	name = "Aqueduct - Passage Horizontal"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_horizontal.dmm")

/datum/map_template/modular_map/aqueduct/horizontal/New()
	cell_connections = list(
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_ROOM | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_ROOM | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/esw
	name = "Aqueduct - Passage ESW"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_esw.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/esw/New()
	cell_connections = list(
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/swn
	name = "Aqueduct - Passage SWN"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_swn.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/swn/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/wne
	name = "Aqueduct - Passage WNE"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_wne.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/wne/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/nes
	name = "Aqueduct - Passage NES"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_nes.dmm")
	connection_flag = MFC_HALL_BEND

/datum/map_template/modular_map/aqueduct/nes/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/end
	abstract_type = /datum/map_template/modular_map/aqueduct/end
	is_terminator = TRUE

/datum/map_template/modular_map/aqueduct/end/n
	name = "Aqueduct - Passage End N"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_end_n.dmm")
	cell_connections = list(
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
	)

/datum/map_template/modular_map/aqueduct/end/n/New()
	..()

/datum/map_template/modular_map/aqueduct/end/s
	name = "Aqueduct - Passage End S"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_end_s.dmm")

/datum/map_template/modular_map/aqueduct/end/s/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/end/w
	name = "Aqueduct - Passage End W"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_end_w.dmm")

/datum/map_template/modular_map/aqueduct/end/w/New()
	cell_connections = list(
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/end/e
	name = "Aqueduct - Passage End E"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/passage_end_e.dmm")

/datum/map_template/modular_map/aqueduct/end/e/New()
	cell_connections = list(
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/chamber
	name = "Aqueduct - Large Chamber"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/chamber_large.dmm")
	cell_width = 3
	cell_height = 3
	connection_flag = MFC_ROOM

/datum/map_template/modular_map/aqueduct/chamber/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 1, 2, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("SOUTH", 1, 0, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 2, 1, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 1, (MFC_HALL | MFC_HALL_BEND | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/bridge
	abstract_type = /datum/map_template/modular_map/aqueduct/bridge
	connection_flag = MFC_BRIDGE

/datum/map_template/modular_map/aqueduct/bridge/vertical
	name = "Aqueduct - Bridge Vertical"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/bridge_vertical.dmm")

/datum/map_template/modular_map/aqueduct/bridge/vertical/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_ROOM)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_ROOM)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT)),
	)
	..()

/datum/map_template/modular_map/aqueduct/bridge/horizontal
	name = "Aqueduct - Bridge Horizontal"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/bridge_horizontal.dmm")

/datum/map_template/modular_map/aqueduct/bridge/horizontal/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_ROOM)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_HALL | MFC_HALL_BEND | MFC_ROOM)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water
	abstract_type = /datum/map_template/modular_map/aqueduct/water
	connection_flag = MFC_AQUEDUCT

/datum/map_template/modular_map/aqueduct/water/junction
	name = "Aqueduct - Water Junction"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_junction.dmm")

/datum/map_template/modular_map/aqueduct/water/junction/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/ne
	name = "Aqueduct - Water NE"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_ne.dmm")

/datum/map_template/modular_map/aqueduct/water/ne/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/nw
	name = "Aqueduct - Water NW"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_nw.dmm")

/datum/map_template/modular_map/aqueduct/water/nw/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/se
	name = "Aqueduct - Water SE"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_se.dmm")

/datum/map_template/modular_map/aqueduct/water/se/New()
	cell_connections = list(
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/sw
	name = "Aqueduct - Water SW"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_sw.dmm")

/datum/map_template/modular_map/aqueduct/water/sw/New()
	cell_connections = list(
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/horizontal
	name = "Aqueduct - Water Horizontal"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_horizontal.dmm")

/datum/map_template/modular_map/aqueduct/water/horizontal/New()
	cell_connections = list(
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/vertical
	name = "Aqueduct - Water Vertical"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_vertical.dmm")

/datum/map_template/modular_map/aqueduct/water/vertical/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/esw
	name = "Aqueduct - Water ESW"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_esw.dmm")

/datum/map_template/modular_map/aqueduct/water/esw/New()
	cell_connections = list(
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/swn
	name = "Aqueduct - Water SWN"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_swn.dmm")

/datum/map_template/modular_map/aqueduct/water/swn/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/wne
	name = "Aqueduct - Water WNE"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_wne.dmm")

/datum/map_template/modular_map/aqueduct/water/wne/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/nes
	name = "Aqueduct - Water NES"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_nes.dmm")

/datum/map_template/modular_map/aqueduct/water/nes/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/end
	abstract_type = /datum/map_template/modular_map/aqueduct/water/end
	is_terminator = TRUE

/datum/map_template/modular_map/aqueduct/water/end/n
	name = "Aqueduct - Water End N"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_end_n.dmm")

/datum/map_template/modular_map/aqueduct/water/end/n/New()
	cell_connections = list(
		new /datum/modular_map_connection("SOUTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/end/s
	name = "Aqueduct - Water End S"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_end_s.dmm")

/datum/map_template/modular_map/aqueduct/water/end/s/New()
	cell_connections = list(
		new /datum/modular_map_connection("NORTH", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/end/e
	name = "Aqueduct - Water End E"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_end_e.dmm")

/datum/map_template/modular_map/aqueduct/water/end/e/New()
	cell_connections = list(
		new /datum/modular_map_connection("WEST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()

/datum/map_template/modular_map/aqueduct/water/end/w
	name = "Aqueduct - Water End W"
	mappaths = list("maps/shaded_hills/dungeon_gen/submaps/aqueduct/aqueduct_end_w.dmm")

/datum/map_template/modular_map/aqueduct/water/end/w/New()
	cell_connections = list(
		new /datum/modular_map_connection("EAST", 0, 0, (MFC_AQUEDUCT | MFC_BRIDGE)),
	)
	..()
