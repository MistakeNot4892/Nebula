#define UNATHI_SPRITE(CLOTHING_PATH, SPRITE_SHEET)                                                      \
/obj/item/clothing/##CLOTHING_PATH/Initialize() {                                                       \
	. = ..();                                                                                            \
	LAZYSET(sprite_sheets, BODYTYPE_UNATHI, file("mods/species/lizard/icons/clothing/"+##SPRITE_SHEET));\
}
