var/list/weedkiller_reagents = list(
	/decl/material/liquid/acid =              -2,
	/decl/material/liquid/acid/hydrochloric = -2,
	/decl/material/liquid/acid/polyacid =     -4,
	/decl/material/liquid/weedkiller =        -8,
	/decl/material/liquid/adminordrazine =    -5
)

var/list/pestkiller_reagents = list(
	/decl/material/liquid/nutriment =      2,
	/decl/material/liquid/bromide =        -2,
	/decl/material/gas/methyl_bromide =    -4,
	/decl/material/liquid/adminordrazine = -5
)

/datum/extension/plantable
	base_type = /datum/extension/plantable
	flags = EXTENSION_FLAG_IMMEDIATE
	var/list/planter_effects

/datum/extension/plantable/New()
	..()
	START_PROCESSING(SSplants, src)

/datum/extension/plantable/Process()

	var/atom/owner = holder

	var/weed_val = LAZYACCESS(planter_effects, /decl/planter_effect/invaders/weeds)
	var/pest_val = LAZYACCESS(planter_effects, /decl/planter_effect/invaders)
	for(var/rtype in owner.reagents?.reagent_volumes)
		var/weed_change = global.weedkiller_reagents[rtype]
		weed_val += weed_change
		var/pest_change = global.pestkiller_reagents[rtype]
		pest_val += pest_change
		if(weed_change != 0 || pest_change != 0)
			owner.reagents.remove_reagent(rtype, REM)
			owner.queue_icon_update()

	if(weed_val <= 0)
		LAZYREMOVE(planter_effects, /decl/planter_effect/invaders/weeds)
	else
		LAZYSET(planter_effects, /decl/planter_effect/invaders/weeds, weed_val)
	if(pest_val <= 0)
		LAZYREMOVE(planter_effects, /decl/planter_effect/invaders)
	else
		LAZYSET(planter_effects, /decl/planter_effect/invaders, pest_val)

	for(var/peffect in subtypesof(/decl/planter_effect))
		var/decl/planter_effect/planter_effect = decls_repository.get_decl(peffect)
		var/val = LAZYACCESS(planter_effects, peffect) || 0
		var/val_change = planter_effect.handle_planter_process(src, val)
		if(val_change != 0)
			val += val_change
			if(val <= 0)
				LAZYREMOVE(planter_effects, peffect)
			else
				LAZYSET(planter_effects, peffect, val)
			owner.queue_icon_update()
