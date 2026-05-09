/mob/living/human/skeleton/avian/Initialize(mapload, species_uid, datum/mob_snapshot/supplied_appearance)
	if(!species_uid)
		species_uid = /decl/species/neoavian::uid
	. = ..()

/mob/living/human/zombie/avian/Initialize(mapload, species_uid, datum/mob_snapshot/supplied_appearance)
	if(!species_uid)
		species_uid = /decl/species/neoavian::uid
	. = ..()
