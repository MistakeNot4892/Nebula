/decl/life_event/career
	min_age = 18
	max_age = 50
	rand_age_step = 5
	min_age_step =  1
	linked_to = list(
		/decl/life_event/career/job/criminal,
		/decl/life_event/career/job/labourer,
		/decl/life_event/career/job/academics,
		/decl/life_event/career/job/medicine,
		/decl/life_event/career/job/engineering,
		/decl/life_event/career/job/spacer,
		/decl/life_event/career/job/corporate,
		/decl/life_event/career/job/military
	)

/decl/life_event/career/job
	denied_flags = list(LE_WANTED)
	linked_to = list(
		/decl/life_event/career/fired,
		/decl/life_event/career/quit,
		/decl/life_event/career/illness,
		/decl/life_event/career/died
	)
	var/can_repeat = TRUE

/decl/life_event/career/fired
	name = "Fired"
	description = "You lost your job, whether by error, redundancy or just by simple grinding economics."
	rand_age_step = 0
	min_age_step = 0
	availablility_chance = 10

/decl/life_event/career/quit
	name = "Quit"
	description = "You left your job to seek out a more rewarding way to spend your life."
	rand_age_step = 0
	min_age_step = 0
	availablility_chance = 10

/decl/life_event/career/illness
	name = "Health Scare"
	description = "A routine checkup ended with a diagnosis of a serious, potentially lethal, physically debilitating disease, cutting your dreams short."
	denied_flags = list(LE_ILLNESS)
	grants_flags = list(LE_ILLNESS)
	availablility_chance = 5

/decl/life_event/career/died
	name = "Died"
	description = "Through accident or ill health, you died, and your story ended here."
	min_age_step = INFINITY
	availablility_chance = 5

/decl/life_event/career/job/New()
	..()
	if(can_repeat)
		linked_to |= type

/*
Career event: Banned from the Bridge
Description: You were selected to lead security operations on a salvage operation in hostile territory.  After piloting your shuttlecraft into an obvious hazard, costing the company money, men, and resources, it has been decided you are better off following orders than giving them.
Mechanical: Ineligible for leadership roles, -1 piloting, +1 ranged weapons
Requires: Pilot

Gambling addiction

Involuntary Military service

Marooned

Lab Tech: You worked as a Lab Tech at a leading pharmaceutical company. The job involved exposure to chemicals and shady corporate secrets. Adds science points. Adds special exploitable information. Adds possible health decrease.

Golden Parachute
Description: You fucked up bad, and the company put you in charge of a backwater to get rid of you.
Mechanical: update exploitables, start with fancy equipment, Corporate Executive -> Disgraced Executive
Requires: Corporate Executive

Called up Gambling Debts
Description: You were once a professional gambler, until you lost all your gains piecemeal to various untrusty lenders.
Mechanical: Update Exploitables, lose professional gambler job.
Requires: Professional Gambler.

Early or late childhood event: Security Breach (Medical)
Description: Growing up on a ship means growing up surrounded by red tape.  Sometimes, that red tape was put there for a reason.  After wandering into an occupied autopsy room, you’re sure you’ll never forget witnessing what happens to a spacer when their suit ruptures.
Requires: Spacerborn or Adopted

Early or late childhood event: Security breach (Security)
Description: Growing up on a ship means growing up surrounded by red tape.  Sometimes, that red tape was put there for a reason.  Wandering into the security supply room with your guardian’s stolen ID might have been a pretty serious mistake, as evidenced by your accidental blinding when you set off a flashbang in your hand.
Mechanical: Prosthetic eyes
Requires: Spacerborn or Adopted

Early or late childhood event:  Security breach (Engineering)
Description: Growing up on a ship means growing up surrounded by red tape.  Sometimes, that red tape was put there for a reason.  When your friend promised you’d see something cool, you never once imagined he’d lead you astray.  That old engineer never quite looked at you the same after he caught you tossing around a glowing uranium rod you’d pulled out of the secure storage.  Certainly, he never would have approved of you being placed under his guidance and leadership when you came of age to take a job.
Requires: Spacerborn or Adopted.


/decl/life_event/career/whitecollar
	name = "White Collar Worker"
	description = "You found work as an office worker, showing up to a nine to five grind and learning the ins and outs of corporate culture."

/decl/life_event/career/pilot
	name = "Pilot"
	description = "You attended flight school and became a formally recognized spacecraft pilot."

/decl/life_event/career/psionic
	name = "Registered Psionic"
	description = "You worked as a formally recognized expert in psionics, both academically and in the field. Ultimately, your skills developed until you were considered a grandmaster of your faculty."

/decl/life_event/career/wildpsionic
	name = "Wild Psionic"
	description = "In your brilliance, or your madness, you spurned the shackles of the law and ran wild as a practicing unregistered psionic, selling or using your gifts as you saw fit."

/decl/life_event/career/company
	name = "Company Man"
	description = "You devoted yourself body and mind to your company, and the company rewarded you for it."

/decl/life_event/career/executive
	name = "Executive"
	description = "You reached the upper echelons of your company, entering the executive branch."

/decl/life_event/career/enlisted
	name = "Enlisted Military"
	description = "You enlisted in the military and started working your way up through the ranks."

/decl/life_event/career/officer
	name = "Commissioned Officer"
	description = "You entered the military as a commissioned officer."
*/