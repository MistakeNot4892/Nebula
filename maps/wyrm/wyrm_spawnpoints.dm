var/global/list/latejoin_cryo_captain = list()
var/global/list/latejoin_cryo_two = list()

/datum/map/wyrm
	allowed_spawns = list("Secondary Cryogenic Bay", "Primary Cryogenic Bay", "Robot Storage", "Captain Compartment")
	default_spawn = "Secondary Cryogenic Bay"

/datum/spawnpoint/cryo
	display_name = "Secondary Cryogenic Bay"
	msg = "has completed revival in the secondary cryogenics bay"
	disallow_job = list("Robot")

/obj/effect/landmark/latejoin/cryo_captain/add_loc()
	global.latejoin_cryo_captain |= get_turf(src)

/datum/spawnpoint/cryo/captain
	display_name = "Captain Compartment"
	msg = "has completed revival in the captain compartment"
	restrict_job = list("Captain")

/datum/spawnpoint/cryo/captain/New()
	..()
	turfs = global.latejoin_cryo_captain

/obj/effect/landmark/latejoin/cryo_two/add_loc()
	global.latejoin_cryo_two |= get_turf(src)

/datum/spawnpoint/cryo/two
	display_name = "Primary Cryogenic Bay"
	msg = "has completed revival in the primary cryogenics bay"
	disallow_job = list("Robot")

/datum/spawnpoint/cryo/two/New()
	..()
	turfs = global.latejoin_cryo_two