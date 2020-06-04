/decl/material/liquid/antitoxins/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/poison, -2)

/decl/material/liquid/fuel/hydrazine/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/poison, 2.5)
	plant.adjust_chem_effect(/decl/plant_effect/consumption/water, -2)
	plant.adjust_chem_effect(/decl/plant_effect/yield_modifier, -2)
	
/decl/material/liquid/acetone/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/poison, 1)

/decl/material/liquid/toxin/plantbgone/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/poison, 3)
	plant.adjust_chem_effect(/decl/plant_effect/yield_modifier, -2)

/decl/material/liquid/radium/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/poison, 2)
	plant.adjust_chem_effect(/decl/plant_effect/mutagen, 8)
	plant.adjust_chem_effect(/decl/plant_effect/yield_modifier, -0.5)

/decl/material/liquid/mutagenics/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/mutagen, 15)

/decl/material/liquid/fertilizer/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption, 1)

/decl/material/liquid/fertilizer/left4zed/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/mutagen, 30)

/decl/material/liquid/drink/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption, nutrition * 0.05)
	plant.adjust_chem_effect(/decl/plant_effect/consumption/water, hydration * 0.05)

/decl/material/liquid/ethanol/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption, nutriment_factor * 0.05)
	plant.adjust_chem_effect(/decl/plant_effect/consumption/water, hydration_factor * 0.05)

/decl/material/liquid/nutriment/sugar/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption, nutriment_factor * 0.05)
	plant.adjust_chem_effect(/decl/plant_effect/consumption/water, hydration_factor * 0.05)

/decl/material/liquid/ammonia/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption, 0.5)
	plant.adjust_chem_effect(/decl/plant_effect/yield_modifier, 0.5)

/decl/material/liquid/adminordrazine/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption, 1)

/decl/material/gas/water/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption/water, 1)

/decl/material/liquid/adminordrazine/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption, 1)
	plant.adjust_chem_effect(/decl/plant_effect/consumption/water, 1)
	plant.adjust_chem_effect(/decl/plant_effect/yield_modifier, 1)

/decl/material/liquid/phosphorus/affect_plant(var/obj/effect/plant/plant, var/available, var/datum/reagents/holder)
	. = ..()
	plant.adjust_chem_effect(/decl/plant_effect/consumption, 0.1)
	plant.adjust_chem_effect(/decl/plant_effect/consumption/water, -0.5)
	plant.adjust_chem_effect(/decl/plant_effect/yield_modifier, -2)
