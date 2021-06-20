/obj/item/clothing/head/helmet/space/void/atmos/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/atmos.dmi')

/obj/item/clothing/head/helmet/space/void/engineering/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/engineering.dmi')

/obj/item/clothing/head/helmet/space/void/medical/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/medical.dmi')

/obj/item/clothing/head/helmet/space/void/mining/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/mining.dmi')

/obj/item/clothing/head/helmet/space/void/pilot/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/pilot.dmi')

/obj/item/clothing/head/helmet/space/void/engineering/salvage/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/salvage.dmi')

/obj/item/clothing/head/helmet/space/void/security/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/security.dmi')

/obj/item/clothing/head/helmet/space/void/security/alt/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/security_alt.dmi')

/obj/item/clothing/head/helmet/space/void/merc/Initialize()
	. = ..()
	LAZYSET(sprite_sheets, BODYTYPE_SKRELL, 'mods/species/skrell/icons/clothing/void/syndicate.dmi')

//Skrellessories
/obj/item/clothing/ears/skrell
	name = "skrell headtail wear"
	desc = "Some stuff worn by skrell to adorn their headtails."
	icon = 'mods/species/skrell/icons/clothing/chain.dmi'
	bodytype_restricted = list(BODYTYPE_SKRELL)

/obj/item/clothing/ears/skrell/metal
	name = "headtail chains"
	icon_state = "skrell_chain"
	applies_material_name = TRUE
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
	material = /decl/material/solid/metal/silver

/obj/item/clothing/ears/skrell/metal/ceremonial
	material = /decl/material/solid/metal/blackbronze

/obj/item/clothing/ears/skrell/metal/bluejewels
	name = "and sapphire headtail chains"
	jewel_color = "#0000CA"

/obj/item/clothing/ears/skrell/metal/redjewels
	name = "and ruby headtail chains"
	jewel_color = "#AA0C00"

/obj/item/clothing/ears/skrell/metal/band
	name = "headtail bands"
	desc = "Golden metallic bands worn by male skrell to adorn their head tails."
	icon = 'mods/species/skrell/icons/clothing/band.dmi'

/obj/item/clothing/ears/skrell/metal/band/set_material(new_material)
	. = ..()
	if(material)
		desc = "A [capitalize(material.solid_name)] band worn by skrell to decorate their head tails."

/obj/item/clothing/ears/skrell/metal/band/silver
	material = /decl/material/solid/metal/silver

/obj/item/clothing/ears/skrell/metal/band/ceremonial
	material = /decl/material/solid/metal/blackbronze

/obj/item/clothing/ears/skrell/metal/band/bluejewels
	name = "and sapphire headtail bands"
	jewel_color = "#0000CA"

/obj/item/clothing/ears/skrell/metal/band/redjewels
	name = "and ruby headtail chains"
	jewel_color = "#AA0C00"

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