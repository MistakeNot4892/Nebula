/decl/life_event/career/job/military
	name = "Enlisted"
	description = "You signed up for a tour with the military."
	denied_flags = list(LE_DISCHARGED, LE_CRIMINAL_RECORD)
	linked_to = list(
		/decl/life_event/career/job/military/service,
		/decl/life_event/career/job/military/medal,
		/decl/life_event/career/job/military/promotion,
		/decl/life_event/career/job/military/promotion,
		/decl/life_event/career/job/military/wounded,
		/decl/life_event/career/discharged,
		/decl/life_event/career/discharged_dishonourable,
		/decl/life_event/career/died
	)
	modify_skills = list(
		"athletics" =  1,
		"weapons" = 1
	)

/decl/life_event/career/job/military/commission
	name = "Officer Commission"
	description = "You entered the military as a commissioned officer."

/decl/life_event/career/job/military/service
	name = "Military Service"
	description = "You did your job as a member of the military. (PLACEHOLDER)"

/decl/life_event/career/job/military/medal
	name = "Service Medal"
	description = "You received a medal for exemplary conduct. Good job, you. (PLACEHOLDER)"
	availablility_chance = 5
	can_repeat = FALSE

/decl/life_event/career/job/military/promotion
	name = "Promoted"
	description = "You got promoted. Hooray. (PLACEHOLDER)"
	availablility_chance = 5
	can_repeat = FALSE

/decl/life_event/career/job/military/promotion
	name = "Demoted"
	description = "You got demoted. Oh no. (PLACEHOLDER)"
	availablility_chance = 5
	can_repeat = FALSE

/decl/life_event/career/job/military/wounded
	name = "Wounded"
	description = "You were wounded in action. (PLACEHOLDER)"
	availablility_chance = 15
	can_repeat = FALSE

/decl/life_event/career/job/military/wounded/New()
	..()
	linked_to -= type
	linked_to |= /decl/life_event/career/discharged_medical

/decl/life_event/career/discharged
	name = "Honourable Discharge"
	description = "You left the military at the end of the tour, seeking new work in the civilian sector."
	availablility_chance = 25
	grants_flags = list(LE_DISCHARGED)

/decl/life_event/career/discharged_medical
	name = "Medical Discharge"
	description = "You were found unfit for military service after your health deteriorated, and were discharged."
	grants_flags = list(LE_DISCHARGED)

/decl/life_event/career/discharged_dishonourable
	name = "Dishonourable Discharge"
	description = "You were kicked out of the military following a court martial, narrowly avoiding jail time for your reprehensible behavior."
	availablility_chance = 25
	grants_flags = list(LE_DISCHARGED, LE_CRIMINAL_RECORD)
