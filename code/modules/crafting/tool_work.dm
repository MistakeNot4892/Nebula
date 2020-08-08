#define RECIPE_CHISEL 1 
#define RECIPE_WELDER 2

#define isChisel(A) (A && A.ischisel())

/obj/item/proc/ischisel()
	return FALSE

/obj/item/screwdriver/ischisel()
	return TRUE

/decl/material/proc/get_recipes_for(obj/item/stack/material/stack, list/recipe_flags)
	for(var/datum/stack_recipe/R in get_recipes())
		if(R.craftable_stack_types && !(stack.crafting_stack_type in R.craftable_stack_types))
			continue
		if(R.tool_crafting_flags)
			for(var/recipe_flag in recipe_flags)
				if(R.tool_crafting_flags & recipe_flag)
					LAZYADD(., R)
					break

/datum/stack_recipe
	var/name
	var/list/craftable_stack_types
	var/tool_crafting_flags = 0

/datum/stack_recipe/New(decl/material/material, reinforce_material)
	. = ..()
	if(!name && result_type)
		var/obj/product = result_type
		name = initial(product.name)

/datum/stack_recipe/sheet
	craftable_stack_types = list(/obj/item/stack/material/rods)
	tool_crafting_flags = RECIPE_WELDER

/datum/stack_recipe/railing
	craftable_stack_types = list(/obj/item/stack/material/rods)
	tool_crafting_flags = RECIPE_WELDER

/datum/stack_recipe/butcher_hook
	craftable_stack_types = list(/obj/item/stack/material/rods)
	tool_crafting_flags = RECIPE_WELDER

/datum/stack_recipe/furniture/barricade
	tool_crafting_flags = RECIPE_WELDER

/datum/stack_recipe/furniture/bed
	craftable_stack_types = list(/obj/item/stack/material)
	tool_crafting_flags = RECIPE_WELDER

/datum/stack_recipe/ashtray
	craftable_stack_types = list(/obj/item/stack/material)
	tool_crafting_flags = RECIPE_CHISEL

/datum/stack_recipe/ring
	craftable_stack_types = list(/obj/item/stack/material)
	tool_crafting_flags = RECIPE_CHISEL

/obj/item/stack/material
	var/crafting_stack_type = /obj/item/stack/material

/obj/item/stack/material/rods
	crafting_stack_type = /obj/item/stack/material/rods

/obj/item/stack/material/attackby(obj/item/W, mob/user)

	var/list/recipe_flags
	if(isChisel(W))
		LAZYADD(recipe_flags, RECIPE_CHISEL)
	var/check_fuel = FALSE
	if(isWelder(W))
		var/obj/item/weldingtool/WT = W
		if(WT.isOn())
			check_fuel = TRUE
			LAZYADD(recipe_flags, RECIPE_WELDER)

	var/list/recipes = material.get_recipes_for(src, recipe_flags)
	if(length(recipes))
		var/list/radial_buttons
		for(var/datum/stack_recipe/R in recipes)
			var/obj/product = R.result_type
			var/image/radial_button = image(icon = initial(product.icon), icon_state = initial(product.icon_state))
			radial_button.color = material.color
			radial_button.name = "Craft \a [initial(product.name)]"
			LAZYSET(radial_buttons, R, radial_button)

		var/datum/stack_recipe/crafting = show_radial_menu(user, src, radial_buttons, radius = 42, require_near = TRUE, use_labels = TRUE, check_locs = list(W, src))
		if(!crafting)
			return TRUE

		var/max_mult = round(min(get_amount() / crafting.req_amount, crafting.max_res_amount/crafting.res_amount))
		var/mult = input("How many would you like to make?", "Crafting Amount", 1) as num
		mult = Clamp(mult, 0, max_mult)

		if(check_fuel)
			var/obj/item/weldingtool/WT = W
			if(!WT.remove_fuel(0, user))
				to_chat(user, SPAN_WARNING("You need more fuel to complete this task."))
				return TRUE

		if(mult >= 1 && W.loc == user && (loc == user || Adjacent(user)) && !user.incapacitated())
			produce_recipe(crafting, mult, user)
		return TRUE

	. = ..()