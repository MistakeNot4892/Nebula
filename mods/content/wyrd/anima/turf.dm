/turf
	var/alist/last_anima
	var/list/_affecting_anima

/turf/ChangeTurf(turf/N, tell_universe, force_lighting_update, keep_air, update_open_turfs_above, keep_height)
	. = ..()
	last_anima = null

/turf/proc/add_affecting_anima(datum/extension/anima_source/_source)
	LAZYDISTINCTADD(_affecting_anima, _source)
	LAZYDISTINCTADD(_source.affecting_turfs, src)
	last_anima = null

/turf/proc/remove_affecting_anima(datum/extension/anima_source/_source)
	LAZYREMOVE(_affecting_anima, _source)
	LAZYREMOVE(_source.affecting_turfs, src)
	last_anima = null

/turf/proc/update_anima_values()
	last_anima = alist()
	for(var/datum/extension/anima_source/source in _affecting_anima)
		for(var/atype,avalue in source.anima_contribution)
			last_anima[atype] += avalue
	var/area/my_area = get_area(src)
	for(var/atype,avalue in my_area?.get_background_anima())
		last_anima[atype] += avalue

/atom/proc/get_ambient_anima()
	var/turf/turf = get_turf(src)
	return turf?.get_ambient_anima()

/turf/get_ambient_anima()
	// If nothing is affecting our anima, don't even bother caching it.
	if(!length(_affecting_anima))
		var/area/area = get_area(src)
		return area?.get_background_anima()?.Copy()
	if(isnull(last_anima))
		last_anima = update_anima_values()
	return last_anima
