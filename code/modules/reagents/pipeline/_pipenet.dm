/datum/graph/pipenet/New()
	..()
	SSfluids.pipenets |= src

/datum/graph/pipenet/Destroy()
	. = ..()
	SSfluids.pipenets -= src

/datum/graph/pipenet/proc/ProcessFluids()
	return

/datum/graph/pipenet/OnMerge(var/datum/graph/other)
	..()
