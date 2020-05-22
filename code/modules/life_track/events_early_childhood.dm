/decl/life_event/early_childhood
	min_age = 1
	max_age = 11
	denied_flags = list(LE_SYNTHETIC)

/decl/life_event/early_childhood/New()
	linked_to = typesof(/decl/life_event/late_childhood)-/decl/life_event/late_childhood
	..()

/decl/life_event/early_childhood/booster
	name = "Booster Child"
	description = "You are the child of fringe transhumans on a booster habitat, far out in the deep dark. You were encouraged from a young age to take control over your own genetic destiny."
	modify_skills = list(
		"science" =    1,
		"devices" =    1,
		"athletics" = -1
	)

/decl/life_event/early_childhood/dynasty
	name = "Dynasty Child"
	description = "You were raised amongst the children of one of the asteroid mining dynasties in the Kuiper belt, and attended the same private schooling as the other dynasty children."
	denied_flags = list(LE_ILLEGITIMATE, LE_SYNTHETIC)
	grants_flags = list(LE_PRIVILEGED, LE_PRIMARY_SCHOOL)
	modify_skills = list(
		"finance" = 1,
		"eva" =     1,
		"botany" = -1
	)

/decl/life_event/early_childhood/provincial
	name = "Provincial Child"
	description = "You were raised on a backwater world, growing up strong and healthy, but lacking in formal education."
	modify_skills = list(
		"botany" =    1,
		"athletics" = 1,
		"devices" =  -1
	)

/decl/life_event/early_childhood/spacer
	name = "Spacer Child"
	description = "You were raised in the belly of an independant spacecraft or orbital habitat. You learned the secrets of the technology keeping your community alive, but microgravity did your developing body no favours."
	grants_flags = list(LE_PRIMARY_SCHOOL)
	modify_skills = list(
		"engineering" = 1,
		"eva" =         1,
		"athletics" =  -1
	)

/decl/life_event/early_childhood/laboratory
	name = "Lab Child"
	description = "You were raised in a laboratory as the subject of experiments and study."
	modify_skills = list(
		"science" =   1,
		"medicine" =  1,
		"finance" =  -1
	)

/decl/life_event/early_childhood/adopted
	name = "Foster Child"
	description = "You were given up for adoption, and passed around through various middle-class families. It played merry hell with your schooling, but you did scrape through in the end, and you learned to take care of yourself."
	grants_flags = list(LE_PRIMARY_SCHOOL)
	modify_skills = list(
		"cooking" = 1
	)

/decl/life_event/early_childhood/adopted_crew
	name = "Crew Child"
	description = "You were given up for adoption, and taken in by a ragtag group of spacers as a mascot and helper on their ship."
	modify_skills = list(
		"piloting" =    1,
		"engineering" = 1,
		"athletics" =  -1
	)
	
/decl/life_event/early_childhood/noble
	name = "Rich Child"
	description = "You were raised by wealthy parents and grew up with a life of privilege. Private tutors, top of the line equipment, and flawless healthcare; no expense was spared."
	denied_flags = list(LE_ILLEGITIMATE, LE_SYNTHETIC)
	grants_flags = list(LE_PRIVILEGED, LE_PRIMARY_SCHOOL)
	modify_skills = list(
		"finance" = 1
	)
	
/decl/life_event/early_childhood/urban
	name = "Feral Child"
	description = "You were raised in an overcrowded, decaying city. You spent your time running with a pack of like-minded ferals."
	denied_flags = list(LE_PRIVILEGED, LE_SYNTHETIC)
	grants_flags = list(LE_UNDERCLASS)
	modify_skills = list(
		"combat" = 1
	)

/decl/life_event/early_childhood/military
	name = "Soldier Child"
	description = "You were raised by soldiers and spent your childhood on tour from ship to ship or base to base. Your early education was rough and you know a distressing amount about guns for a child, but the curriculum covered the basics."
	denied_flags = list(LE_ILLEGITIMATE, LE_SYNTHETIC)
	grants_flags = list(LE_PRIMARY_SCHOOL)
	modify_skills = list(
		"weapons" = 1
	)

/decl/life_event/early_childhood/fledgeling
	name = "Sky Child"
	description = "You were raised on one of the neo-corvid habitats and grew up amongst uplifts and winged gene-adapts. Most people don't attend primary school via hang-glider, but you thrived."
	grants_flags = list(LE_PRIMARY_SCHOOL)
	modify_skills = list(
		"piloting" = 1
	)

/decl/life_event/early_childhood/ocean
	name = "Ocean Child"
	description = "You were raised on an ocean world, and grew up playing in the boundless sea alongside aquatic gene-adapts and uplifts. The classrooms were largely underwater, but you still got an education."
	grants_flags = list(LE_PRIMARY_SCHOOL)
	modify_skills = list(
		"swimming" = 1
	)

/decl/life_event/early_childhood/signal
	name = "Star Child"
	description = "You were raised on the backwater fringes of Sol and never received an education. Whether by good luck, bad luck or random change, you were exposed to the Signal and developed latencies, at the cost of your physical wellbeing."
	grants_flags = list(LE_PSIONIC)
	modify_skills = list(
		"athletics" = -1
	)
