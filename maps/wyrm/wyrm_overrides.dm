/obj/item/supply_beacon
    randpixel = 0
    density = TRUE

//Eventually this should get significantly refactored, but what's it matter now?
/obj/item/clothing/head/helmet/space/Initialize()
	. = ..()
	bodytype_restricted = list(BODYTYPE_HUMANOID)

/obj/item/clothing/suit/space/Initialize()
	. = ..()
	bodytype_restricted = list(BODYTYPE_HUMANOID)