/decl/life_event/career/jailed
	name = "Jailed"
	description = "The law, and the consequences of your actions, finally caught up to you. Luckily, you were taken alive."
	requires_flags = list(LE_WANTED)
	removes_flags =  list(LE_WANTED)
	grants_flags =   list(LE_CRIMINAL_RECORD)

/decl/life_event/career/job/criminal
	name = "Career Criminal"
	description = "You pursued a life of crime in the underbelly of known space."
	denied_flags = null
	requires_flags = list(LE_CRIMINAL_RECORD)
	grants_flags = list(LE_WANTED)
	linked_to = list(
		/decl/life_event/career/jailed,
		/decl/life_event/career/died
	)
	modify_skills = list(
		"combat" =  1,
		"devices" = 1
	)

/decl/life_event/career/job/criminal/New()
	..()
	linked_to |= /decl/life_event/career/job/criminal/syndicate

/decl/life_event/career/job/criminal/syndicate
	name = "Syndicated"
	description = "You joined a local crime syndicate, getting involved in their inner workings."

/decl/life_event/career/job/criminal/syndicate/New()
	..()
	linked_to |= /decl/life_event/career/job/criminal/made_man

/decl/life_event/career/job/criminal/made_man
	name = "Syndicate Captain"
	description = "You're a man on the inside now, privy to the wheelings and dealings of the largest crime syndicate in your area."

/decl/life_event/career/job/criminal/made_man/New()
	..()
	linked_to |= /decl/life_event/career/job/criminal/crime_lord

/decl/life_event/career/job/criminal/crime_lord
	name = "Syndicate Leader"
	description = "You're large and in charge. The head honcho. The big cheese. (PLACEHOLDER)"
