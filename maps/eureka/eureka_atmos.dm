/datum/map/eureka
	exterior_atmos_temp = T0C - 4 
	exterior_atmos_composition = list(
		/decl/material/gas/oxygen =          MOLES_CELLSTANDARD * 0.16,
		/decl/material/gas/nitrogen =        MOLES_CELLSTANDARD * 0.4,
		/decl/material/gas/smog =            MOLES_CELLSTANDARD * 0.4
	)


/decl/material/gas/smog
	name = "smog"
	lore_text = "An unpleasant smog, unbreathable by humans but non-toxic. Can cause minor lung irritation."
	gas_specific_heat = 40
	gas_molar_mass = 0.044	
	gas_tile_overlay = "sleeping_agent"
	gas_overlay_limit = 1

/decl/material/gas/smog/affect_blood(var/mob/living/carbon/M, var/alien, var/removed, var/datum/reagents/holder)
	..()
	if(prob(1) && ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/lungs = H.internal_organs[BP_LUNGS]
		if(lungs && !(locate(/datum/ailment/coughing) in lungs.ailments))
			lungs.add_ailment(/datum/ailment/coughing)
