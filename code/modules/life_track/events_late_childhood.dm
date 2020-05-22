/decl/life_event/late_childhood
	name = "Ordinary Late Childhood"
	description = "You continued to grow up, eventually joining $faction$."
	min_age = 11
	max_age = 16

/decl/life_event/late_childhood/sanitize_age(var/pref_age)
	. = max(..(), max_age)

/decl/life_event/late_childhood/Initialize()
	linked_to = subtypesof(/decl/life_event/young_adulthood)
	if(!length(linked_to))
		linked_to = list(/decl/life_event/young_adulthood)
	. = ..()
