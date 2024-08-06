/datum/map/parting_shade
	name = "Parting Shade"
	full_name = "Parting Shade"
	path = "parting_shade"
	ground_noun = "ground"

	station_name  = "SCV Forever Autumn"
	station_short = "Ocelot"

	dock_name     = "SMV Thunder Child"
	boss_name     = "Solar Command"
	boss_short    = "Sol"
	company_name  = "Sol Exploratory League"
	company_short = "SEL"
	num_exoplanets = 0

	// TODO
	lobby_screens = list('maps/tradeship/lobby/bloodmoney.png','maps/tradeship/lobby/vapormoney.png')
	welcome_sound = 'sound/effects/cowboysting.ogg'

	// TODO: evac ship arriving, evac burn for orbit
	/*
	emergency_shuttle_leaving_dock   = "Attention all hands: the escape pods have been launched, maintaining burn for %ETA%."
	emergency_shuttle_called_message = "Attention all hands: emergency evacuation procedures are now in effect. Escape pods will launch in %ETA%"
	emergency_shuttle_recall_message = "Attention all hands: emergency evacuation sequence aborted. Return to normal operating conditions."
	evac_controller_type = /datum/evacuation_controller/lifepods
	*/

	radiation_detected_message = "High levels of radiation have been detected in proximity of the %STATION_NAME%. Please move to a shielded area such as the cargo bay, dormitories or medbay until the radiation has passed."
	default_telecomms_channels = list(COMMON_FREQUENCY_DATA) // TODO: secured radio for shipguys

/datum/map/parting_shade/get_map_info()
	return "TODO. Isolated planet of Parting Shade, under interdiction by the Ascent."

/datum/map/parting_shade/create_trade_hubs()
	new /datum/trade_hub/singleton/parting_shade

/datum/trade_hub/singleton/parting_shadeshade
	name = "Shoal Freight Network" // Vox traders playing both sides of the conflict for a profit

// TODO
/datum/trade_hub/singleton/parting_shade/get_initial_traders()
	return list(
		/datum/trader/xeno_shop,
		/datum/trader/medical,
		/datum/trader/mining,
		/datum/trader/books
	)
