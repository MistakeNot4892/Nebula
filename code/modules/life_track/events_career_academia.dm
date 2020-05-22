/decl/life_event/career/job/academics
	name = "Doctorate"
	description = "You pursued further academic qualifications and achieved a PhD."
	requires_flags = list(LE_TERTIARY_EDUCATION)
	linked_to = list(
		/decl/life_event/career/job/academics/academia,
		/decl/life_event/career/job/academics/published,
		/decl/life_event/career/blacklisted
	)
	can_repeat = FALSE
	modify_skills = list(
		"science" = 2
	)

/decl/life_event/career/job/academics/academia
	name = "Academia"
	description = "You worked as an academic in a university, working on papers and running lectures in your field of expertise."

/decl/life_event/career/job/academics/published
	name = "Published Paper"
	description = "A paper you worked on was published in a prestigous journal."
	availablility_chance = 20

/decl/life_event/career/blacklisted
	name = "Blacklisted"
	description = "Your fringe views, argumentative nature and other flaws finally got you blacklisted from the academic world."
	availablility_chance = 5
