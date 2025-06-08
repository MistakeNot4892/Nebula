/area/ringdown/atonal_waterfall
	name = "Atonal Waterfall"

/decl/department/ringdown/mantids
	name = "Mantid Brood"
	colour = "#534b62"

/datum/job/ringdown/mantid
	title = "Drone"
	department_types = list(/decl/department/ringdown/mantids)

/datum/job/ringdown/mantid/hunter
	title = "Hunter"

/datum/job/ringdown/mantid/auxiliary
	title = "Brood Auxiliary"

/obj/effect/overmap/visitable/sector/ringdown/atonal_waterfall
	name = "Atonal Waterfall"

/datum/map_template/ruin/ringdown/atonal_waterfall
	name = "Ringdown - Atonal Waterfall"
	description = "The largest mantid exclave on the Plate."
	suffixes = list("atonal_waterfall/atonal_waterfall.dmm")
