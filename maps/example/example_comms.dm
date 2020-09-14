/datum/map/example
	default_telecomms_channels = list(
		COMMON_FREQUENCY_DATA,
		list("name" = "Response",    "key" = "r", "frequency" = 1345,     "color" = COMMS_COLOR_CENTCOMM, "span_class" = ".centradio", "secured" = access_cent_specops),
		list("name" = "AI Private",  "key" = "p", "frequency" = 1343,     "color" = COMMS_COLOR_AI,       "span_class" = ".airadio",   "secured" = access_ai_upload)
	)

