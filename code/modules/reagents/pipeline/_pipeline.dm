/obj/structure/reagent_pipe/debugone
	pipe_layer = -1
	connection_type = /obj/structure/reagent_pipe/debugone
	color = COLOR_BEIGE

/obj/structure/reagent_pipe/debugtwo
	pipe_layer = 0
	connection_type = /obj/structure/reagent_pipe/debugtwo
	color = COLOR_COPPER

/obj/structure/reagent_pipe/debugthree
	pipe_layer = 1
	connection_type = /obj/structure/reagent_pipe/debugthree
	color = COLOR_OFF_WHITE

/obj/structure/reagent_pipe
	name = "poop pipe"
	icon = 'icons/obj/structures/reagent_pipes.dmi'
	icon_state = "pipe"
	layer = PIPE_LAYER

	var/connection_type = /obj/structure/reagent_pipe
	var/pipe_layer = 0
	var/list/connections
	var/tmp/const/pixel_offset_value = 3
	var/datum/graph/pipenet/pipenet

/obj/structure/reagent_pipe/Initialize(ml, _mat, _reinf_mat, _layer)
	. = ..()
	if(!isnull(_layer))
		pipe_layer = _layer
	for(var/obj/structure/reagent_pipe/pipe in loc)
		if(pipe != src && (pipe.connection_type == type || pipe.pipe_layer == pipe_layer))
			return INITIALIZE_HINT_QDEL
	update_pipenet()

/obj/structure/reagent_pipe/proc/get_available_pipenet_capacity()
	. = 0
	//if(pipenet)
	// for var/storage tank in network
	//     add storage space to result

/obj/structure/reagent_pipe/proc/take_from_turf(var/turf/T, var/amount)
	if(!pipenet)
		return amount
	var/obj/effect/fluid/F = locate() in T
	if(!F)
		return
	if(F.reagents)
		// for var/storage tank in network
		//     if tank space >= 0
		//         transfer min(amount, tank space) into tank
		//         amount -= tank space
		//     if amount <= 0
		//         return
		F.reagents.remove_any(min(amount, F.reagents.total_volume))

/obj/structure/reagent_pipe/Destroy()
	var/list/oldconnections = LAZYCOPY(connections)
	clear_pipenet()
	. = ..()
	for(var/obj/structure/reagent_pipe/pipe in oldconnections)
		pipe.update_pipenet()

/obj/structure/reagent_pipe/proc/clear_pipenet()
	for(var/obj/structure/reagent_pipe/pipe in connections)
		disconnect(pipe)
	if(pipenet)
		pipenet.Disconnect(src)
		pipenet = null
	LAZYCLEARLIST(connections)
	queue_icon_update()

/obj/structure/reagent_pipe/proc/disconnect(var/obj/structure/reagent_pipe/pipe)
	LAZYREMOVE(connections, pipe)
	LAZYREMOVE(pipe.connections, src)
	queue_icon_update()
	pipe.queue_icon_update()
	// update graph

/obj/structure/reagent_pipe/proc/connect(var/obj/structure/reagent_pipe/pipe)
	LAZYDISTINCTADD(connections, pipe)
	LAZYDISTINCTADD(pipe.connections, src)
	queue_icon_update()
	pipe.queue_icon_update()
	// update graph

/obj/structure/reagent_pipe/proc/update_pipenet()

	clear_pipenet()
	LAZYCLEARLIST(connections)

	for(var/checkdir in GLOB.cardinal)
		var/turf/T = get_step(get_turf(src), checkdir)
		if(!istype(T))
			continue
		for(var/obj/structure/reagent_pipe/pipe in T)
			if(connection_type && pipe.type == connection_type && pipe.pipe_layer == pipe_layer)
				connect(pipe)
	/*
	for(var/obj/structure/reagent_pipe/pipe in connections)
		if(pipe.pipenet)
			if(pipenet)
				pipenet.Merge(pipe.pipenet)
				pipe.pipenet = pipenet
			else
				pipenet = pipe.pipenet
				pipenet.Connect(src, connections)
		else
			if(pipenet)
				pipe.pipenet = pipenet
				pipe.pipenet.Connect(pipe, pipe.connections)
	*/

	queue_icon_update()

/obj/structure/reagent_pipe/on_update_icon()
	. = ..()

	var/list/pipe_images
	for(var/obj/structure/reagent_pipe/pipe in connections)
		LAZYADD(pipe_images, image(icon, "[icon_state][get_dir(src, pipe)]"))
	set_overlays(pipe_images)
	pixel_x = -6 + (pipe_layer * pixel_offset_value)
	pixel_y = -6 + (pipe_layer * pixel_offset_value)
