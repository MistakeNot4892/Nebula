/decl/material/generate_recipes(stack_type, reinforce_material)
	. = ..()
	if(holographic || phase_at_temperature() != MAT_PHASE_SOLID || stack_type != /obj/item/stack/material/log)
		return list()
	. += new /datum/stack_recipe/furniture/axle(src)

/datum/stack_recipe/furniture/axle
	title = "horizontal axle"
	result_type = /obj/structure/mechanical/axle
	time = 3 SECONDS

/datum/stack_recipe/furniture/axle/vertical
	title = "vertical axle"
	result_type = /obj/structure/mechanical/column
