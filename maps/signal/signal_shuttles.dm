/obj/effect/shuttle_landmark/lower_level
	name = "Lower Level Dock"
	landmark_tag = "nav_signal_station"
	docking_controller = "lower_level_dock"

/obj/effect/shuttle_landmark/upper_level
	name = "Upper Level Dock"
	landmark_tag = "nav_signal_offsite"
	special_dock_targets = list("Signal" = "signal_shuttle_port")
	docking_controller = "upper_level_dock"

/datum/shuttle/autodock/ferry/signal
	name = "Signal"
	shuttle_area = /area/shuttle/escape
	dock_target = "signal_shuttle_starboard"
	warmup_time = 10

	location = 0
	waypoint_station = "nav_signal_station"
	waypoint_offsite = "nav_signal_offsite"