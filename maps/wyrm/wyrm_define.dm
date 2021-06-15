/datum/map/wyrm
	name = "Wyrm"
	full_name = "ISC Wyrm"
	path = "wyrm"

//	lobby_icon = 'maps/torch/icons/lobby.dmi'

	station_levels = list(1,2)
	contact_levels = list(1,2)
	player_levels = list(1,2)
	admin_levels = list(3)
	empty_levels = list(4)
	accessible_z_levels = list("1"=5,"2"=5,"4"=50)
	overmap_size = 30
	overmap_event_areas = 25

	allowed_spawns = list("Cryogenic Storage", "Cyborg Storage", "Captain Compartment")
	default_spawn = "Cryogenic Storage"

	station_name  = "ISC Wyrm"
	station_short = "Wyrm"
	dock_name     = "TBD"
	boss_name     = "Automated Announcement Systems"
	boss_short    = "AAS"
	company_name  = "Automated Announcement Systems"
	company_short = "AAS"

//	date_offset = 560

	map_admin_faxes = list("Automated Announcement System")

	shuttle_docked_message = "Attention all hands: Jump preparation complete. The bluespace drive is now spooling up, secure all stations for departure. Time to jump: approximately %ETD%."
	shuttle_leaving_dock = "Attention all hands: Jump initiated, exiting bluespace in %ETA%."
	shuttle_called_message = "Attention all hands: Jump sequence initiated. Transit procedures are now in effect. Jump in %ETA%."
	shuttle_recall_message = "Attention all hands: Jump sequence aborted, return to normal operating conditions."

	evac_controller_type = /datum/evacuation_controller/starship

//	default_law_type = /datum/ai_laws/manifest
	use_overmap = 1

	num_exoplanets = 1
	planet_size = list(129,129)

	away_site_budget = 5
//Having lost its enigmatic benefactor during the years of the conflict, funding and luck have been in short supply for the vessel.
//Yet, with the slow return of galactic normalcy, some hope has returned to the eclectic group that remains.
/datum/map/wyrm/get_map_info()
	return "<h2>Current map information</h2> \
			You're an unfortunate victim of the <i>ISC Wyrm</i>, previously serving as a privately contracted exploration vessel before the Galactic Conflict, the ship now sails aimlessly as a shell of its old self. \
			What the future holds for the ship and her crew is known only by those who move it forward."