/decl/life_event/late_childhood
	min_age = 12
	max_age = 16

/decl/life_event/late_childhood/New()
	linked_to = typesof(/decl/life_event/young_adulthood)-/decl/life_event/young_adulthood
	linked_to -= /decl/life_event/young_adulthood/foundation
	..()

/decl/life_event/late_childhood/feral
	name = "Misspent Youth"
	description = "You were a righteous terror as a child, preferring to cause trouble whenever possible. You were frequently lectured and even arrested by law enforcement."
	denied_flags = list(LE_PRIVILEGED)
	grants_flags = list(LE_CRIMINAL_RECORD)
	remove_links = list(
		/decl/life_event/young_adulthood/cadet,
		/decl/life_event/young_adulthood/injury
	)
	modify_skills = list(
		"combat" = 1,
		"athletics" = 1
	)

/decl/life_event/late_childhood/worker
	name = "Child Worker"
	description = "Your family struggled to put food on the table, and you worked at menial jobs instead of attending school."
	denied_flags = list(LE_PRIVILEGED)
	modify_skills = list(
		"athletics" = 1,
		"finance" = 1
	)

/decl/life_event/late_childhood/military
	name = "Military Upbringing"
	description = "You were groomed to go into the military, following after your family. The military schools you attended were strict, but effective."
	denied_flags = list(LE_ILLEGITIMATE)
	requires_flags = list(LE_PRIMARY_SCHOOL)
	grants_flags = list(LE_SECONDARY_SCHOOL)
	remove_links = list(
		/decl/life_event/young_adulthood/farmhand,
		/decl/life_event/young_adulthood/streetkid,
		/decl/life_event/young_adulthood/datarunner,
		/decl/life_event/young_adulthood/retail
	)
	modify_skills = list(
		"athletics" = 1,
		"weapons" = 1
	)

/decl/life_event/late_childhood/prodigy
	name = "Academic Prodigy"
	description = "You were an academic prodigy, excelling at your education and studying far ahead of your peers."
	denied_flags = list(LE_ILLEGITIMATE)
	requires_flags = list(LE_PRIMARY_SCHOOL)
	grants_flags = list(LE_SECONDARY_SCHOOL)
	remove_links = list(
		/decl/life_event/young_adulthood/farmhand,
		/decl/life_event/young_adulthood/streetkid,
		/decl/life_event/young_adulthood/datarunner,
		/decl/life_event/young_adulthood/retail
	)
	modify_skills = list(
		"science" = 1,
		"devices" = 1
	)

/decl/life_event/late_childhood/schooling
	name = "Secondary Education"
	description = "You were enrolled in public schooling, and although you didn't excel, you also didn't flounder."
	requires_flags = list(LE_PRIMARY_SCHOOL)
	grants_flags = list(LE_SECONDARY_SCHOOL)
	modify_skills = list(
		"science" = 1,
		"finance" = 1
	)

/decl/life_event/late_childhood/foundation
	name = "Foundation Student"
	description = "You were registered with and enrolled in the Foundation to develop your psionic abilities."
	denied_flags = list(LE_ILLEGITIMATE)
	requires_flags = list(LE_PSIONIC)
	grants_flags = list(LE_SECONDARY_SCHOOL)
	remove_links = list(
		/decl/life_event/young_adulthood/farmhand,
		/decl/life_event/young_adulthood/streetkid
	)
	modify_skills = list(
		"science" = 1,
		"devices" = 1
	)

/decl/life_event/late_childhood/foundation/New()
	..()
	linked_to |= /decl/life_event/young_adulthood/foundation
