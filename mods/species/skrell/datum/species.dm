/decl/species/skrell
	name = SPECIES_SKRELL
	name_plural = SPECIES_SKRELL
	preview_icon = 'mods/species/skrell/icons/preview.dmi'
	meat_type = /obj/item/chems/food/squid

	unarmed_attacks = list(/decl/natural_attack/stomp, /decl/natural_attack/kick, /decl/natural_attack/punch)

	available_bodytypes = list(
		/decl/bodytype/skrell,
		/decl/bodytype/skrell/masculine
	)

	available_pronouns = list(
		/decl/pronouns
	)

	primitive_form = "Neaera"
	darksight_range = 4
	burn_mod = 0.9
	oxy_mod = 1.3
	flash_mod = 1.2
	toxins_mod = 0.8
	siemens_coefficient = 1.3

	body_temperature = null // cold-blooded, implemented the same way nabbers do it

	description = "An amphibious species, Skrell come from the star system known as Qerr'Vallis, which translates to 'Star of \
	the royals' or 'Light of the Crown'.<br/><br/>Skrell are a highly advanced and logical race who live under the rule \
	of the Qerr'Katish, a caste within their society which keeps the empire of the Skrell running smoothly. Skrell are \
	herbivores on the whole and tend to be co-operative with the other species of the galaxy, although they rarely reveal \
	the secrets of their empire to their allies."

	cold_level_1 = 280 //Default 260 - Lower is better
	cold_level_2 = 220 //Default 200
	cold_level_3 = 130 //Default 120

	heat_level_1 = 420 //Default 360 - Higher is better
	heat_level_2 = 480 //Default 400
	heat_level_3 = 1100 //Default 1000

	spawn_flags = SPECIES_CAN_JOIN | SPECIES_NO_ROBOTIC_INTERNAL_ORGANS
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR

	flesh_color = "#8cd7a3"

	reagent_tag = IS_SKRELL
	base_color = "#006666"
	blood_types = list(/decl/blood_type/skrell)
	organs_icon = 'mods/species/skrell/icons/organs.dmi'

	override_organ_types = list(
		BP_EYES = /obj/item/organ/internal/eyes/skrell,
		BP_LUNGS = /obj/item/organ/internal/lungs/skrell
	)

	appearance_descriptors = list(
		/datum/appearance_descriptor/height = 1.25,
		/datum/appearance_descriptor/build = 0,
		/datum/appearance_descriptor/headtail_length = 0
	)

	exertion_hydration_scale = 1
	exertion_emotes_biological = list(
		/decl/emote/exertion/biological,
		/decl/emote/exertion/biological/breath,
		/decl/emote/exertion/biological/pant
	)

/decl/species/skrell/New()
	..()
	LAZYINITLIST(available_cultural_info)
	LAZYDISTINCTADD(available_cultural_info[TAG_CULTURE], /decl/cultural_info/culture/skrell)
	for(var/caste in typesof(/decl/cultural_info/culture/skrell))
		LAZYSET(default_cultural_info, TAG_CULTURE, caste)
	LAZYDISTINCTADD(available_cultural_info[TAG_HOMEWORLD], /decl/cultural_info/location/qerrbalak)
	LAZYSET(default_cultural_info, TAG_HOMEWORLD, /decl/cultural_info/location/qerrbalak)

/decl/blood_type/skrell
	name = "Sk"
	antigens = list("S","k")
	splatter_colour = "#1d2cbf"