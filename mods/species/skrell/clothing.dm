#define SKRELL_SPRITE(CLOTHING_PATH, SPRITE_SHEET)                                                   \
/obj/item/clothing/##CLOTHING_PATH/Initialize() {                                                     \
	. = ..();                                                                                          \
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, file("mods/species/skrell/icons/clothing/"+##SPRITE_SHEET));\
}

SKRELL_SPRITE(head/helmet/space/void/atmos,"void/atmos.dmi")

SKRELL_SPRITE(head/helmet/space/void/engineering,"void/engineering.dmi")

SKRELL_SPRITE(head/helmet/space/void/medical,"void/medical.dmi")

SKRELL_SPRITE(head/helmet/space/void/mining,"void/mining.dmi")

SKRELL_SPRITE(head/helmet/space/void/pilot,"void/pilot.dmi")

SKRELL_SPRITE(head/helmet/space/void/engineering/salvage,"void/salvage.dmi")

SKRELL_SPRITE(head/helmet/space/void/security,"void/security.dmi")

SKRELL_SPRITE(head/helmet/space/void/security/alt,"void/security_alt.dmi")

SKRELL_SPRITE(head/helmet/space/void/merc,"void/syndicate.dmi")

#undef SKRELL_SPRITE
/decl/loadout_category/skrell
	name = "Skrell"
/decl/loadout_option/skrell
	category = /decl/loadout_category/skrell
	whitelisted = list(SPECIES_SKRELL)

/decl/loadout_option/skrell/metal
	name = "metalic headtail accessories (Skrell)"
	path = /obj/item/clothing/ears/skrell/metal
	flags = GEAR_HAS_TYPE_SELECTION

/decl/loadout_option/skrell/cloth_female
	name = "female headtail cloth (Skrell)"
	path = /obj/item/clothing/ears/skrell/cloth_female
	flags = GEAR_HAS_COLOR_SELECTION

/decl/loadout_option/skrell/cloth_male
	name = "male headtail cloth (Skrell)"
	path = /obj/item/clothing/ears/skrell/cloth_male
	flags = GEAR_HAS_COLOR_SELECTION

//Skrellessories
/obj/item/clothing/ears/skrell
	name = "skrell headtail wear"
	desc = "Some stuff worn by skrell to adorn their headtails."
	icon = 'mods/species/skrell/icons/clothing/chain.dmi'
	bodytype_equip_flags = list(BODY_FLAG_SKRELL)

/obj/item/clothing/ears/skrell/metal
	name = "gold headtail chains"
	//applies_material_name = TRUE
	applies_material_colour = TRUE
	material = /decl/material/solid/metal/gold
	var/jewel_color

/obj/item/clothing/ears/skrell/metal/set_material(new_material)
	. = ..()
	if(material)
		desc = "A delicate [material.solid_name] chain worn by female skrell to decorate their head tails."

/obj/item/clothing/ears/skrell/metal/on_update_icon()
	. = ..()
	if(jewel_color)
		add_overlay(overlay_image(icon, "world_jewel", jewel_color, RESET_COLOR))

/obj/item/clothing/ears/skrell/metal/get_mob_overlay(mob/user_mob, slot, bodypart)
	var/image/ret = ..()
	if(ret && jewel_color)
		ret.overlays += overlay_image(ret.icon, "jewel", jewel_color, RESET_COLOR)
	return ret

/obj/item/clothing/ears/skrell/metal/silver
	name = "silver headtail chains"
	material = /decl/material/solid/metal/silver

/obj/item/clothing/ears/skrell/metal/ceremonial
	name = "ceremonial headtail chains"
	material = /decl/material/solid/metal/blackbronze

/obj/item/clothing/ears/skrell/metal/bluejewels
	name = "gold and sapphire headtail chains"
	jewel_color = "#0000ca"

/obj/item/clothing/ears/skrell/metal/redjewels
	name = "gold and ruby headtail chains"
	jewel_color = "#aa0c00"

/obj/item/clothing/ears/skrell/metal/band
	name = "gold headtail bands"
	desc = "Metallic bands worn by male skrell to adorn their head tails."
	icon = 'mods/species/skrell/icons/clothing/band.dmi'

/obj/item/clothing/ears/skrell/metal/band/set_material(new_material)
	. = ..()
	if(material)
		desc = "A [capitalize(material.solid_name)] band worn by skrell to decorate their head tails."

/obj/item/clothing/ears/skrell/metal/band/silver
	name = "silver headtail bands"
	material = /decl/material/solid/metal/silver

/obj/item/clothing/ears/skrell/metal/band/ceremonial
	name = "ceremonial headtail bands"
	material = /decl/material/solid/metal/blackbronze

/obj/item/clothing/ears/skrell/metal/band/bluejewels
	name = "gold and sapphire headtail bands"
	jewel_color = "#0000ca"

/obj/item/clothing/ears/skrell/metal/band/redjewels
	name = "gold and ruby headtail chains"
	jewel_color = "#aa0c00"

/obj/item/clothing/ears/skrell/cloth_female
	name = "headtail cloth"
	desc = "A cloth shawl worn by female skrell draped around their head tails."
	icon = 'mods/species/skrell/icons/clothing/cloth_female.dmi'

/obj/item/clothing/ears/skrell/cloth_female/red
	color = "#c20c00"

/obj/item/clothing/ears/skrell/cloth_female/blue
	color = "#0227f7"

/obj/item/clothing/ears/skrell/cloth_female/lblue
	color = "#6262ff"

/obj/item/clothing/ears/skrell/cloth_female/black
	color = "#454545"

/obj/item/clothing/ears/skrell/cloth_female/green
	color = "#009900"

/obj/item/clothing/ears/skrell/cloth_female/pink
	color = "#e17291"

/obj/item/clothing/ears/skrell/cloth_male
	name = "headtail cloth"
	desc = "A cloth band worn by male skrell around their head tails."
	icon = 'mods/species/skrell/icons/clothing/cloth_male.dmi'

/obj/item/clothing/ears/skrell/cloth_male/red
	color = "#c20c00"

/obj/item/clothing/ears/skrell/cloth_male/blue
	color = "#0227f7"

/obj/item/clothing/ears/skrell/cloth_male/lblue
	color = "#6262ff"

/obj/item/clothing/ears/skrell/cloth_male/black
	color = "#454545"

/obj/item/clothing/ears/skrell/cloth_male/green
	color = "#009900"

/obj/item/clothing/ears/skrell/cloth_male/pink
	color = "#e17291"