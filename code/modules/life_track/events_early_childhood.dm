/decl/life_event/early_childhood
	name = "Ordinary Childhood"
	description = "You grew up as normal for $culture$."
	min_age = 1
	max_age = 11

/decl/life_event/early_childhood/sanitize_age(var/pref_age)
	. = max(..(), max_age)

/decl/life_event/early_childhood/Initialize()
	linked_to = subtypesof(/decl/life_event/late_childhood)
	if(!length(linked_to))
		linked_to = list(/decl/life_event/late_childhood)
	. = ..()
