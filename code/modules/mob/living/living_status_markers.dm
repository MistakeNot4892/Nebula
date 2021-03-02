/decl/status_condition
	var/icon = 'icons/screen/status_markers.dmi'
	var/icon_state = "status"
	var/list/marker_objs

/decl/status_condition/proc/get_status_marker(var/mob/living/victim)
	if(icon && icon_state)
		var/weakref/victim_ref = weakref(victim)
		. = LAZYACCESS(marker_objs, victim_ref)
		if(!.)
			var/obj/marker = new
			marker.icon = icon
			marker.icon_state = icon_state
			marker.appearance_flags |= KEEP_TOGETHER
			. = marker
			LAZYSET(marker_objs, victim_ref, .)

/mob/living
	var/image/status_marker
	var/list/status_markers

/mob/living/Initialize()
	. = ..()
	status_marker = new /image
	status_marker.appearance_flags |= KEEP_TOGETHER
	status_marker.loc = src
	global.all_status_markers += status_marker

/mob/living/Destroy()
	global.all_status_markers -= status_marker
	if(status_marker)
		status_marker.vis_contents.Cut()
	QDEL_NULL(status_marker)
	QDEL_NULL_LIST(status_markers)
	. = ..()
	
/mob/living/handle_status_effects()
	. = ..()

	var/list/current_status_markers
	for(var/condition in status_counters)
		var/decl/status_condition/status = decls_repository.get_decl(condition)
		var/marker = status.get_status_marker(src)
		if(marker)
			LAZYADD(current_status_markers, marker)
	set_status_markers(current_status_markers)

/mob/living/proc/set_status_markers(var/list/new_markers)
	var/list/removing_markers
	var/list/adding_markers
	for(var/marker in new_markers)
		if(marker in status_markers)
			continue
		LAZYADD(adding_markers, marker)
	for(var/marker in status_markers)
		if(marker in new_markers)
			continue
		LAZYADD(removing_markers, marker)

	// calc offsets for the markers, animate entering and leaving the marker
	status_markers = new_markers
	for(var/marker in removing_markers)
		status_markers.vis_contents -= marker
	for(var/marker in adding_markers)
		status_markers.vis_contents += marker
