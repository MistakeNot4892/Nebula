/decl/department/ringdown
	name = "Drifters"

/datum/job/ringdown
	total_positions = -1
	department_types = list(/decl/department/ringdown)
	outfit_type = /decl/outfit/job/ringdown/drifter
	var/list/species_outfits = list(
		"Mantid"  = /decl/outfit/job/ringdown/brood_auxillary,
		"Shoaler" = /decl/outfit/job/ringdown/shoaler,
		"Runner"  = /decl/outfit/job/ringdown/guild_runner,
		"Husk"    = /decl/outfit/job/ringdown/wandering_husk,
		"Drake"   = /decl/outfit/job/ringdown/drake_clanner
	)

/datum/job/ringdown/get_outfit(mob/living/human/H, alt_title, datum/mil_branch/branch, datum/mil_rank/grade)
	var/species_name = H.get_species_name()
	if(species_name in species_outfits)
		. = species_outfits[species_name]
		if(islist(.))
			if(alt_title in .)
				. = .[alt_title]
			if(title in .)
				. = .[title]
		if(ispath(.))
			return GET_DECL(.)
	return ..()

/datum/job/ringdown/drifter
	title = "Drifter"
