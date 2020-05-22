/decl/life_event/birth
	name = "Ordinary Birth"
	description = "You were born $species$, conceived and delivered on $location$ in the standard manner. You were assigned $gender$ at birth."
	max_age = 1

/decl/life_event/birth/sanitize_age(var/pref_age)
	. = max(..(), max_age)

/decl/life_event/birth/Initialize()
	. = ..()
	linked_to = subtypesof(/decl/life_event/early_childhood)
	if(!length(linked_to))
		linked_to = list(/decl/life_event/early_childhood)

/decl/life_event/birth/validate_against_parent(var/datum/life_event_instance/parent)
	return !istype(parent) // ironic
