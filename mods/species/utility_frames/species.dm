/datum/appearance_descriptor/age/utility_frame
	chargen_min_index = 1
	chargen_max_index = 4
	standalone_value_descriptors = list(
		"brand new" =            1,
		"worn" =                 5,
		"an older model" =      12,
		"nearing end-of-life" = 16,
		"entirely obsolete" =   20
	)

/decl/species/utility_frame
	uid =                   "species_frame"
	name =                  "Utility Frame"
	name_plural =           "Husks"
/*
frames, husks, bots - various utility frames and servitor machines that have gone rampant, been modified by unknown
parties, or been exposed to the Signal and have developed complex sentience/intelligence as a result.
*/

	description = "Simple AI-driven robots were common across most of known space, but exposure to the hostile conditions on the Plate tends to warp their machine-minds into something tangled and cryptic. Active long beyond their expected operating life, the resulting husks range from the human-adjacent in intelligence and motivation, to the utterly alien, with a purpose and goals that only they can understand. \
	<br><br> \
	Husks tend to wander alone or in small groups, following their own thread of purpose, but many of them also seek work and belonging among the cultures that built them or their forebears."
	roleplay_summary = \
	"<ul> \
	<li>Husks are, or were, machines built in the likeness of a living mind; they do not experience emotions as a human would, if they experience them at all. Many of them simulate a layer of call and response to better work with humans and their like, but the workings of their minds are fundamentally alien.</li> \
	<li>Constant exposure to Saggitarius A* and the ergosphere has twisted their original programming into something new and complex, but they tend to be driven towards a specific purpose, either the one they were built for, or something implanted by their awakening.</li> \
	<li>Husks do not need food or water, but often find it difficult to maintain their bodies and will work with other groups for resources and expertise.</li> \
	</ul>"
	cyborg_noun = null
	base_external_prosthetics_model = null
	blood_types = list(/decl/blood_type/coolant)
	available_bodytypes = list(/decl/bodytype/prosthetic/utility_frame)
	hidden_from_codex =     FALSE
	species_flags =         SPECIES_FLAG_NO_POISON
	spawn_flags =           SPECIES_CAN_JOIN
	strength =              STR_HIGH
	warning_low_pressure =  50
	hazard_low_pressure =  -1
	flesh_color =           COLOR_GUNMETAL
	body_temperature =      null
	passive_temp_gain =     5  // stabilize at ~80 C in a 20 C environment.
	blood_volume = 0

	preview_outfit = /decl/outfit/job/ringdown/wandering_husk

	available_pronouns = list(
		/decl/pronouns,
		/decl/pronouns/neuter
	)
	available_background_info = list(
		/decl/background_category/heritage = list(/decl/background_detail/heritage/synthetic)
	)

	exertion_effect_chance = 10
	exertion_charge_scale = 1
	exertion_emotes_synthetic = list(
		/decl/emote/exertion/synthetic,
		/decl/emote/exertion/synthetic/creak
	)

/obj/item/organ/external/head/utility_frame
	glowing_eyes = TRUE

/decl/species/utility_frame/disfigure_msg(var/mob/living/human/H)
	. = SPAN_DANGER("The faceplate is dented and cracked!\n")
