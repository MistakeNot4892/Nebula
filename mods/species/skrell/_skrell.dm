#define SPECIES_SKRELL  "Skrell"
#define LANGUAGE_SKRELL "Skrellian"
#define IS_SKRELL       "skrell"
#define BODYTYPE_SKRELL "skrellian body"


/obj/item/clothing/Initialize()
	. = ..()
	if(length(bodytype_restricted) && !("exclude" in bodytype_restricted))
		bodytype_restricted |= BODYTYPE_SKRELL

/obj/machinery/suit_cycler/Initialize(mapload, d, populate_parts)
	. = ..()
	available_bodytypes |= BODYTYPE_SKRELL

/decl/modpack/skrell
	name = "Skrell"

/mob/living/carbon/human/skrell/Initialize(mapload)
	..(mapload, SPECIES_SKRELL)
