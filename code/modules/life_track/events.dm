/decl/life_event
	var/name
	var/event_type
	var/description =   "This is a placeholder life event. If you can see this in your life track, please make a bug report."
	var/modifiers =     "No changes."
	var/rand_age_step = 0
	var/min_age_step =  1
	var/min_age = 0
	var/max_age = INFINITY
	var/list/denied_flags
	var/list/requires_flags
	var/list/removes_flags
	var/list/grants_flags
	var/availablility_chance = 100
	var/list/remove_links
	var/list/linked_to
	var/list/modify_skills

/decl/life_event/New()
	..()
	if(remove_links && linked_to)
		linked_to -= remove_links

/decl/life_event/proc/get_possible_links(var/list/flags, var/age, var/check_availability = TRUE)
	. = list()
	for(var/event in linked_to)
		var/skip = FALSE
		var/decl/life_event/event_datum = get_decl(event)
		if(event_datum.max_age < age || event_datum.min_age > age)
			continue
		if(length(event_datum.requires_flags))
			if(!length(flags))
				continue
			for(var/flag in event_datum.requires_flags)
				if(!(flag in flags))
					skip = TRUE
					break
		if(!skip && length(flags))
			for(var/flag in event_datum.denied_flags)
				if(flag in flags)
					skip = TRUE
					break
		if(!skip && (!check_availability || event == type || prob(event_datum.availablility_chance)))
			. += event_datum
