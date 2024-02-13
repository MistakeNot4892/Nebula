/obj/structure/mechanical
	material = /decl/material/solid/organic/wood
	material_alteration = MAT_FLAG_ALTERATION_COLOR | MAT_FLAG_ALTERATION_NAME
	var/list/mechanical_connections
	var/datum/node/physical/machine_node
	var/moving = FALSE

/obj/structure/mechanical/proc/is_mechanical_sink()
	return FALSE

/obj/structure/mechanical/proc/is_mechanical_source()
	return FALSE

/obj/structure/mechanical/proc/set_machine_moving(new_moving)
	if(moving == new_moving)
		return FALSE
	moving = new_moving
	update_icon()
	return TRUE

/obj/structure/mechanical/DblClick()
	set_machine_moving(!moving)
	for(var/datum/node/physical/node in machine_node?.graph?.GetNodes())
		var/obj/structure/mechanical/machine = node.holder
		if(istype(machine))
			machine.set_machine_moving(moving)

/obj/structure/mechanical/Initialize()
	machine_node = new(src)
	machine_node.graph = new /datum/graph/mechanical(list(machine_node))
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/mechanical/LateInitialize()
	..()
	var/list/graphs = list()
	for(var/datum/node/physical/node in collect_mechanical_connections())
		if(node.graph)
			LAZYADD(graphs[node.graph], node)
			node.holder?.queue_icon_update()
	for(var/datum/graph/graph as anything in graphs)
		graph.Connect(machine_node, graphs[graph])
	update_icon()

/obj/structure/mechanical/Destroy()
	var/list/update_nodes = machine_node?.ConnectedNodes()
	QDEL_NULL(machine_node)
	. = ..()
	if(length(update_nodes))
		for(var/datum/node/physical/node in update_nodes)
			node.holder?.update_icon()

/obj/structure/mechanical/Move()
	. = ..()
	if(.)
		machine_node?.Moved()

/obj/structure/mechanical/set_dir(ndir)
	. = ..()
	if(.)
		machine_node?.Moved()

/obj/structure/mechanical/set_anchored(new_anchored)
	. = ..()
	if(.)
		machine_node?.Moved()

/obj/structure/mechanical/proc/required_mechanical_effort()
	return 0

/obj/structure/mechanical/proc/get_mechanical_connection_dirs()
	return dir

/obj/structure/mechanical/proc/mechanical_can_connect(obj/structure/mechanical/connecting)
	return z == connecting.z && istype(connecting, /obj/structure/mechanical/junction)

/obj/structure/mechanical/proc/collect_mechanical_connections()
	if(!anchored)
		return
	var/turf/myturf = get_turf(src)
	if(!myturf)
		return
	var/list/connection_dirs = get_mechanical_connection_dirs()
	if(!length(connection_dirs))
		return
	for(var/stepdir in connection_dirs)
		for(var/obj/structure/mechanical/connected in get_step(myturf, stepdir))
			if(!Adjacent(connected))
				continue
			if(!(global.reverse_dir[stepdir] in connected.get_mechanical_connection_dirs()))
				continue
			if(connected.mechanical_can_connect(src) && mechanical_can_connect(connected) && connected.machine_node)
				LAZYDISTINCTADD(., connected.machine_node)

/obj/structure/mechanical/CheckNodeNeighbours()

	if(!machine_node)
		return TRUE
	
	var/list/old_connections = machine_node.ConnectedNodes()
	var/list/new_connections = collect_mechanical_connections()

	if(!length(old_connections) && !length(new_connections))
		return TRUE

	var/update_icon = FALSE
	var/list/removing_connections = old_connections ? (old_connections - new_connections) : null
	if(length(removing_connections))
		machine_node.Disconnect()
		for(var/datum/node/physical/neighbour in removing_connections)
			neighbour.holder?.queue_icon_update()
		update_icon = TRUE

	var/list/adding_connections = new_connections ? (new_connections - old_connections) : null
	if(length(adding_connections))
		machine_node.Connect(adding_connections[1])
		if(length(adding_connections) > 1)
			for(var/datum/node/physical/neighbour in adding_connections.Copy(2))
				neighbour.holder?.queue_icon_update()
				neighbour.Connect(machine_node)
		update_icon = TRUE

	if(update_icon)
		queue_icon_update()

	return TRUE

/obj/structure/mechanical/proc/get_mechanical_connection_overlay_modifier(obj/structure/mechanical/connected)
	return

/obj/structure/mechanical/proc/get_mechanical_connection_overlay(key, obj/structure/mechanical/connected)
	var/connection_state = "[icon_state]_connected_[key][get_mechanical_connection_overlay_modifier(connected)]"
	if(check_state_in_icon(connection_state, icon))
		return overlay_image(icon, connection_state)

/obj/structure/mechanical/on_update_icon()
	icon_state = initial(icon_state)
	if(moving)
		var/moving_state = "[icon_state]_turning"
		if(check_state_in_icon(moving_state, icon))
			icon_state = moving_state
	. = ..()
	for(var/datum/node/physical/neighbour in machine_node.ConnectedNodes())
		var/connection_overlay = get_mechanical_connection_overlay(get_dir(src, neighbour.holder), neighbour.holder)
		if(connection_overlay)
			add_overlay(connection_overlay)

/obj/structure/mechanical/examine(mob/user)
	. = ..()
	if(!machine_node)
		to_chat(user, "DEBUG: \The [src] has no node.")
	else if(!machine_node.graph)
		to_chat(user, "DEBUG: \The [src] has no graph.")
	else if(!istype(machine_node.graph, /datum/graph/mechanical))
		to_chat(user, "DEBUG: \The [src] has invalid graph type.")
	else
		var/datum/graph/mechanical/mech_graph = machine_node.graph
		to_chat(user, "DEBUG: \The [src] is connected to \ref[machine_node]-\ref[machine_node.graph].")
		to_chat(user, "DEBUG: Graph has [LAZYLEN(mech_graph.sinks)] sink\s and [LAZYLEN(mech_graph.sources)] source\s.")
