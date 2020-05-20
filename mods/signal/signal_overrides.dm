/decl/prosthetics_manufacturer/New()
	..()
	LAZYINITLIST(bodytypes_cannot_use)
	bodytypes_cannot_use |= BODYTYPE_OCTOPUS

/decl/species/proc/handle_post_move(var/mob/living/carbon/human/H)
	return

/mob/living/carbon/human/Move()
	. = ..()
	if(.)
		species.handle_post_move(src)
