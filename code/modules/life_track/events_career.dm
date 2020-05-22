/decl/life_event/job
	name = "Ordinary Job"
	description = "You worked at a normal job."
	min_age = 22
	max_age = 50
	rand_age_step = 5
	min_age_step =  1
	linked_to = list(
		/decl/life_event/fired,
		/decl/life_event/quit,
		/decl/life_event/died
	)
	var/can_repeat = TRUE

/decl/life_event/job/Initialize()
	. = ..()
	if(can_repeat)
		linked_to |= type

/decl/life_event/fired
	name = "Fired"
	description = "You lost your job, whether by error, redundancy or just by simple grinding economics."
	rand_age_step = 0
	min_age_step = 0
	availablility_chance = 10

/decl/life_event/quit
	name = "Quit"
	description = "You left your job to seek out a more rewarding way to spend your life."
	rand_age_step = 0
	min_age_step = 0
	availablility_chance = 10

/decl/life_event/died
	name = "Died"
	description = "Through accident or ill health, you died, and your story ended here."
	rand_age_step = 0
	min_age_step = 0
	availablility_chance = 5

/decl/life_event/died/sanitize_age(pref_age)
	return pref_age
	
/decl/life_event/died/can_continue()
	return FALSE
