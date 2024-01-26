/obj/item/stock_parts/circuitboard/exotic_matter_condenser
	name = "circuitboard (exotic matter condenser)"
	build_path = /obj/machinery/exotic_matter_condenser
	board_type = "machine"
	origin_tech = @'{"wormholes":2,"exoticmatter":6,"magnets":4,"powerstorage":6}'
	additional_spawn_components = list(
		/obj/item/stock_parts/power/terminal = 1
	)
	req_components = list(
		/obj/item/stock_parts/manipulator/pico = 2,
		/obj/item/stock_parts/micro_laser/ultra = 1,
		/obj/item/stock_parts/subspace/crystal = 1,
		/obj/item/stock_parts/console_screen = 1,
		/obj/item/stack/cable_coil = 5
	)
