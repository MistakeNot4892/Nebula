/area/ringdown/breakwater
	name = "Breakwater"

/area/ringdown/breakwater/building
	is_outside = OUTSIDE_NO

/area/ringdown/breakwater/building/shack_one
	name = "Breakwater Shack #1"

/area/ringdown/breakwater/building/shack_two
	name = "Breakwater Shack #2"

/area/ringdown/breakwater/building/shack_three
	name = "Breakwater Shack #3"

/area/ringdown/breakwater/building/shack_four
	name = "Breakwater Shack #4"

/area/ringdown/breakwater/building/shack_five
	name = "Breakwater Shack #5"

/area/ringdown/breakwater/building/shack_six
	name = "Breakwater Shack #6"

/area/ringdown/breakwater/building/welcome_center
	name = "Breakwater Welcome Center"

/decl/department/ringdown/breakwater
	name = "Breakwater Union"
	colour = "#a499b3"
	display_priority = 4

/datum/job/ringdown/breakwater
	title = "New Arrival"
	department_types = list(/decl/department/ringdown/breakwater)

/datum/job/ringdown/breakwater/salvager
	title = "Salvager"

/datum/job/ringdown/breakwater/worker
	title = "Worker"

/obj/effect/overmap/visitable/sector/ringdown/breakwater
	name = "Breakwater"

/datum/map_template/ruin/ringdown/breakwater
	name = "Ringdown - Breakwater"
	description = "A large independant community along the center of the Plate."
	suffixes = list("breakwater/breakwater.dmm")
