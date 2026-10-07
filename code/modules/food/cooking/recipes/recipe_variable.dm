/decl/recipe/variable
	abstract_type = /decl/recipe/variable

/decl/recipe/variable/candy
	result = /obj/item/food/variable/candybar

/decl/recipe/variable/candy/create_result_atom(atom/container, list/used_ingredients)
	var/obj/item/food/product = ..()
	product.set_color(get_random_color(TRUE))
	return product

/decl/recipe/variable/candy/jawbreaker
	result = /obj/item/food/variable/jawbreaker

/decl/recipe/variable/candy/sucker
	result = /obj/item/food/variable/sucker

/decl/recipe/variable/candy/jelly
	result = /obj/item/food/variable/jelly

/decl/recipe/variable/cereal
	result = /obj/item/food/variable/cereal

/*
/decl/recipe/variable/cereal/create_result_atom(atom/container, list/used_ingredients)
	var/obj/item/food/product = ..()
	product.SetName("box of [cooking_obj.name] cereal")
	product.filling_color = cooking_obj.color
	var/image/food_image = image(cooking_obj.icon, cooking_obj.icon_state)
	food_image.color = cooking_obj.color
	food_image.overlays += cooking_obj.overlays
	food_image.transform *= 0.7
	product.overlays += food_image
	return product
*/

/decl/recipe/variable/pizza
	result = /obj/item/food/variable/pizza

/decl/recipe/variable/bread
	result = /obj/item/food/variable/bread

/decl/recipe/variable/pie
	result = /obj/item/food/variable/pie

/decl/recipe/variable/cake
	result = /obj/item/food/variable/cake

/decl/recipe/variable/pocket
	result = /obj/item/food/variable/pocket

/decl/recipe/variable/kebab
	result = /obj/item/food/variable/kebab

/decl/recipe/variable/waffles
	result = /obj/item/food/variable/waffles

/decl/recipe/variable/pancakes
	result = /obj/item/food/variable/pancakes

/decl/recipe/variable/cookie
	result = /obj/item/food/variable/cookie

/decl/recipe/variable/donut
	result = /obj/item/food/variable/donut