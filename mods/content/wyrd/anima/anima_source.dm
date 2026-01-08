/datum/extension/anima_source
	expected_type = /atom/movable
	var/radiant_range = 1
	var/alist/anima_contribution // Can also be negatives for anima suppression.
	var/list/affecting_turfs = list()

/datum/extension/anima_source/New(datum/holder)
	. = ..()
	if(istype(holder, expected_type))
		events_repository.register(/decl/observ/moved, holder, src, PROC_REF(update_radiant_anima))

/datum/extension/anima_source/Destroy()
	for(var/turf/turf in affecting_turfs)
		turf.remove_affecting_anima(src)
		affecting_turfs.Cut()
	events_repository.unregister(/decl/observ/moved, holder, src)
	. = ..()

/datum/extension/anima_source/proc/update_radiant_anima()
	var/turf/my_turf = get_turf(holder)
	var/list/new_turfs = istype(my_turf) ? RANGE_TURFS(my_turf, radiant_range) : null
	for(var/turf/turf in affecting_turfs)
		if(turf in new_turfs)
			new_turfs -= turf
		else
			turf.remove_affecting_anima(src)
	for(var/turf/turf in new_turfs)
		turf.add_affecting_anima(src)
