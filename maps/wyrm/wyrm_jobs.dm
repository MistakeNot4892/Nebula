/datum/map/wyrm
	allowed_jobs = list(
		/datum/job/captain,
		/datum/job/hop,
		/datum/job/hos,
		//datum/job/blueshield,
		/datum/job/logistics,
		/datum/job/logistics/salvage,
		/datum/job/scientist,
		/datum/job/scientist/roboticist,
		/datum/job/doctor/surgeon,
		/datum/job/doctor,
		/datum/job/engineer/head,
		/datum/job/engineer,
		/datum/job/ai,
		/datum/job/cyborg
		)

var/global/list/latejoin_cryo_captain = list()

/obj/effect/landmark/latejoin/cryo_captain/add_loc()
	global.latejoin_cryo_captain |= get_turf(src)

/datum/spawnpoint/cryo/captain
	display_name = "Captain Compartment"
	msg = "has completed revival in the captain compartment"
	restrict_job = list("Captain")

/datum/spawnpoint/cryo/captain/New()
	..()
	turfs = global.latejoin_cryo_captain