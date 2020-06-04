var/vines_spawned = FALSE

/datum/event/vines
	announceWhen	= 60

/datum/event/vines/start()
	//vines_infestation()
	global.vines_spawned = TRUE

/datum/event/vines/announce()
	level_seven_announcement()
