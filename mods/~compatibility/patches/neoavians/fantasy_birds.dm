/decl/species/neoavian
	name        = "Hrok"
	name_plural = "Hroks"
	description = "Birdlike nomads originating from the arid, open regions of the downlands. "
	available_background_info = list(
		/decl/background_category/heritage = list(
			/decl/background_detail/heritage/neoavian,
			/decl/background_detail/heritage/other
		)
	)

/decl/language/corvid
	name = "Hrok Tongue"
	desc = "The common tongue of the hrok."

/decl/background_detail/heritage/neoavian
	name = "Nomad Scavenger"
	description = "Traditional hrok society is structured around roaming family groups that forage and scavenge as they travel the land."
	language = /decl/language/corvid
	secondary_langs = list(
		/decl/language/corvid,
		/decl/language/sign
	)
