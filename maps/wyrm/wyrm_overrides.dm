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

/obj/machinery/fabricator/pipe/filled
	anchored = 1

/obj/machinery/fabricator/pipe/disposal/filled
	anchored = 1

/obj/item/modular_computer/pda/heads
	color = COLOR_BLUE_GRAY