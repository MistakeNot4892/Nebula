/decl/life_event/young_adulthood
	name = "Ordinary Young Adulthood"
	description = "You became a normal young adult."
	min_age = 16
	max_age = 22

/decl/life_event/young_adulthood/sanitize_age(var/pref_age)
	. = max(..(), max_age)

/decl/life_event/young_adulthood/Initialize()
	linked_to = subtypesof(/decl/life_event/job)
	if(!length(linked_to))
		linked_to = list(/decl/life_event/job)
	. = ..()
