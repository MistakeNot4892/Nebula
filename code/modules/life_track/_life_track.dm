#define LIFE_EVENT_BIRTH            1
#define LIFE_EVENT_EARLY_CHILDHOOD  2
#define LIFE_EVENT_LATE_CHILDHOOD   3
#define LIFE_EVENT_YOUNG_ADULTHOOD  4
#define LIFE_EVENT_CAREER           5

var/list/decls = list()
/proc/get_decl(var/decl)
	if(!global.decls[decl])
		global.decls[decl] = new decl
	. = global.decls[decl]

/client/verb/generate_random_track()
	gen_track(TRUE)

/client/verb/generate_manual_track()
	gen_track(FALSE)

/client/proc/gen_track(random_track)
	. = list()
	var/list/current_flags = list()
	var/list/current_skills = list()
	var/list/experienced_events = list()
	var/decl/life_event/last_event
	if(random_track)
		last_event = pick(typesof(/decl/life_event/birth)-/decl/life_event/birth)
	else
		last_event = input("Select a birth event.", "Life Track") as null|anything in (typesof(/decl/life_event/birth)-/decl/life_event/birth)
	if(!last_event)
		return
	last_event = get_decl(last_event)

	experienced_events += last_event
	if(last_event.grants_flags)
		current_flags |= last_event.grants_flags

	var/age = last_event.max_age
	var/list/possible_events = last_event.get_possible_links(current_flags, age, random_track)
	. += "<b>Birth - [last_event.name]</b>"
	. += last_event.description
	for(var/skill in last_event.modify_skills)
		if(!current_skills[skill])
			current_skills[skill] = last_event.modify_skills[skill]
		else
			current_skills[skill] += last_event.modify_skills[skill]
		if(!current_skills[skill])
			current_skills -= skill

	while(length(possible_events))
		var/decl/life_event/next_event = (!random_track && input("Select the next event.", "Life Track") as null|anything in possible_events + "Random") || "Random"
		if(!next_event)
			break
		var/age_step = INFINITY
		if(next_event == "Random")
			next_event = pick(possible_events)
			possible_events -= next_event
		if(next_event.rand_age_step && next_event.min_age_step)
			age_step = next_event.min_age_step + (rand() * next_event.rand_age_step)
		else if(next_event.rand_age_step && next_event.min_age_step)
			age_step = next_event.min_age_step + next_event.rand_age_step

		experienced_events += next_event
		if(length(next_event.grants_flags))
			current_flags |= next_event.grants_flags
		if(length(next_event.removes_flags))
			current_flags -= next_event.removes_flags

		for(var/skill in last_event.modify_skills)
			if(!current_skills[skill])
				current_skills[skill] = last_event.modify_skills[skill]
			else
				current_skills[skill] += last_event.modify_skills[skill]
			if(!current_skills[skill])
				current_skills -= skill

		. += "<br>"
		if(last_event == next_event)
			. += "<b>Age [age] - continued with [last_event]</b>"
		else 
			. += "<b>Age [age] - [next_event.name]</b>"
			. += next_event.description

		age = round(max(next_event.min_age+1, min(next_event.max_age+1, age + age_step)))
		possible_events = next_event.get_possible_links(current_flags, age, random_track)
		last_event = next_event

	. += "Final flags: [json_encode(current_flags)]"
	. += "Final skills: [json_encode(current_skills)]"
	for(var/line in .)
		usr << line
