/decl/life_event/birth
	max_age = 1

/decl/life_event/birth/New()
	linked_to = typesof(/decl/life_event/early_childhood)-/decl/life_event/early_childhood
	..()

/decl/life_event/birth/baseline
	name = "Baseline Human"
	description = "You are an unmodified human, conceived and delivered in the standard manner."

/decl/life_event/birth/illegal
	name = "Illegal Birth"
	description = "You were born against the population laws of your home and legally do not exist."
	grants_flags = list(LE_ILLEGITIMATE)

/decl/life_event/birth/designer
	name = "Genemodded"
	description = "You are a custom-designed or cloned child; a test tube baby in a literal sense."
	grants_flags = list(LE_GENEMOD)

/decl/life_event/birth/neocorvid
	name = "Corvid Uplift"
	description = "You are a neo-corvid uplift."
	grants_flags = list(LE_CORVID)

/decl/life_event/birth/octopus
	name = "Octopus Uplift"
	description = "You are an octopus uplift."
	grants_flags = list(LE_OCTOPUS)
