#define SPECIES_SKRELL  "Skrell"
#define LANGUAGE_SKRELL "Skrellian"
#define IS_SKRELL       "skrell"
#define BODYTYPE_SKRELL  "skrellian body"
#define BODY_FLAG_SKRELL BITFLAG(7)

/obj/item/clothing/Initialize()
	. = ..()
	if(bodytype_equip_flags & BODY_FLAG_EXCLUDE)
		bodytype_equip_flags |= BODY_FLAG_SKRELL

/obj/machinery/suit_cycler/Initialize(mapload, d, populate_parts)
	. = ..()
	available_bodytypes |= BODY_FLAG_SKRELL

/decl/modpack/skrell
	name = "Skrell"

/mob/living/carbon/human/skrell/Initialize(mapload)
	..(mapload, SPECIES_SKRELL)
