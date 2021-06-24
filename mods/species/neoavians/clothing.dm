#define AVIAN_SPRITE(CLOTHING_PATH, SPRITE_SHEET)                                                      \
/obj/item/clothing/##CLOTHING_PATH/Initialize() {                                                       \
	. = ..();                                                                                            \
	LAZYSET(sprite_sheets, BODYTYPE_AVIAN, file("mods/species/neoavians/icons/clothing/"+##SPRITE_SHEET));\
}

AVIAN_SPRITE(gloves,"gloves.dmi")

AVIAN_SPRITE(accessory/cloak,"cloak.dmi")

/obj/item/clothing/under/avian_smock
	name = "smock"
	desc = "A loose-fitting smock favoured by neo-avians."
	icon = 'mods/species/neoavians/icons/clothing/under/smock.dmi'
	icon_state = ICON_STATE_WORLD
	bodytype_equip_flags = BODY_FLAG_AVIAN

/obj/item/clothing/under/avian_smock/worker
	name = "worker's smock"
	icon = 'mods/species/neoavians/icons/clothing/under/smock_grey.dmi'

/obj/item/clothing/under/avian_smock/rainbow
	name = "rainbow smock"
	desc = "A brightly coloured, loose-fitting smock - the height of neo-avian fashion."
	icon = 'mods/species/neoavians/icons/clothing/under/smock_rainbow.dmi'

/obj/item/clothing/under/avian_smock/security
	name = "armoured smock"
	desc = "A bright red smock with light armour insets, worn by neo-avian security personnel."
	icon = 'mods/species/neoavians/icons/clothing/under/smock_red.dmi'

/obj/item/clothing/under/avian_smock/engineering
	name = "hazard smock"
	desc = "A high-visibility yellow smock with orange highlights light armour insets, worn by neo-avian engineering personnel."
	icon = 'mods/species/neoavians/icons/clothing/under/smock_yellow.dmi'

/obj/item/clothing/under/avian_smock/utility
	name = "black uniform"
	icon = 'mods/species/neoavians/icons/clothing/under/black_utility.dmi'

/obj/item/clothing/under/avian_smock/utility/gray
	name = "gray uniform"
	icon = 'mods/species/neoavians/icons/clothing/under/gray_utility.dmi'

/obj/item/clothing/under/avian_smock/stylish_command
	name = "stylish uniform"
	icon = 'mods/species/neoavians/icons/clothing/under/stylish_form.dmi'

/obj/item/clothing/shoes/avian
	name = "small shoes"
	icon = 'mods/species/neoavians/icons/clothing/feet/shoes.dmi'
	color = COLOR_GRAY
	bodytype_equip_flags = BODY_FLAG_AVIAN

/obj/item/clothing/shoes/avian/footwraps
	name = "cloth footwraps"
	desc = "A roll of treated canvas used for wrapping feet."
	icon = 'mods/species/neoavians/icons/clothing/feet/footwraps.dmi'
	force = 0
	item_flags = ITEM_FLAG_SILENT
	w_class = ITEM_SIZE_SMALL