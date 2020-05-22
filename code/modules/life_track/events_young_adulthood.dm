/decl/life_event/young_adulthood
	min_age = 17
	max_age = 22
	linked_to = list(
		/decl/life_event/career/job/labourer,
		/decl/life_event/career/job/academics,
		/decl/life_event/career/job/medicine,
		/decl/life_event/career/job/engineering,
		/decl/life_event/career/job/spacer,
		/decl/life_event/career/job/corporate,
		/decl/life_event/career/job/military
	)

/decl/life_event/young_adulthood/farmhand
	name = "Farm Hand"
	description = "You worked as a farm hand on an agrarian colony."
	denied_flags = list(LE_SECONDARY_SCHOOL, LE_PRIVILEGED)
	modify_skills = list(
		"athletics" = 1,
		"botany" = 1
	)

/decl/life_event/young_adulthood/streetkid
	name = "Street Kid"
	description = "You spent your formative teenage years on the street, relying on petty crime to get by."
	denied_flags = list(LE_SECONDARY_SCHOOL, LE_PRIVILEGED)
	grants_flags = list(LE_CRIMINAL_RECORD)
	modify_skills = list(
		"combat" = 1,
		"athletics" = 1
	)

/decl/life_event/young_adulthood/foundation
	name = "Foundation Ward"
	description = "Under the sheltering wing of the Foundation, you trained hard and developed your psionic abilities, alongside receiving a comprehensive formal education."
	requires_flags = list(LE_PSIONIC)
	grants_flags = list(LE_OPERANT)
	modify_skills = list(
		"science" = 1,
		"devices" = 1
	)

/decl/life_event/young_adulthood/datarunner
	name = "Data Runner" 
	description = "You made your living running data for the various gangs in your home city, getting by with a few narrow scrapes but no jail time."
	denied_flags = list(LE_PRIVILEGED)
	grants_flags = list(LE_CRIMINAL_RECORD)
	modify_skills = list(
		"devices" = 1,
		"combat" = 1
	)

/decl/life_event/young_adulthood/retail
	name = "Retail Worker"
	description = "You found retail work at a young age, gaining a loose education in the ins and outs of sales."
	denied_flags = list(LE_PRIVILEGED)
	modify_skills = list(
		"finance" = 1,
		"devices" = 1
	)

/decl/life_event/young_adulthood/cadet
	name = "Cadet"
	description = "You took part in a cadet program alongside your secondary schooling, graduating with a path already laid to enter military service."
	requires_flags = list(LE_SECONDARY_SCHOOL)
	modify_skills = list(
		"combat" = 1,
		"weapons" = 1
	)

/decl/life_event/young_adulthood/cadet/New()
	..()
	linked_to -= /decl/life_event/career/job/military 
	linked_to |= /decl/life_event/career/job/military/commission

/decl/life_event/young_adulthood/injury
	name = "Old College Try"
	description = "You played a sport at a college-equivalent level, until a torn ACL took you out of the spotlight for good."
	requires_flags = list(LE_SECONDARY_SCHOOL)
	modify_skills = list(
		"athletics" = 2
	)

/decl/life_event/young_adulthood/university
	name = "Undergraduate Degree"
	description = "You attended a tertiary institution and obtained an undergraduate degree."
	requires_flags = list(LE_SECONDARY_SCHOOL)
	grants_flags = list(LE_TERTIARY_EDUCATION)
	modify_skills = list(
		"science" = 2,
	)
