#define SPECIES_LIZARD  "Unathi"
#define LANGUAGE_LIZARD "Sinta'unathi"
#define BODYTYPE_UNATHI "unathi body"
#define IS_LIZARD       "unathi"

/decl/modpack/lizard
	name = "Lizard"

/mob/living/carbon/human/lizard/Initialize(mapload)
	..(mapload, SPECIES_LIZARD)
