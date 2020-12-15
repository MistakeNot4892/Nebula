/obj/item/clothing/gloves/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_hands_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_hands_vox_armalis.dmi')
	if("exclude" in species_restricted)
		LAZYDISTINCTADD(species_restricted, SPECIES_VOX)
		LAZYDISTINCTADD(species_restricted, SPECIES_VOX_ARMALIS)
	else
		LAZYREMOVE(species_restricted, SPECIES_VOX)
		LAZYREMOVE(species_restricted, SPECIES_VOX_ARMALIS)
	..()

/obj/item/clothing/shoes/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_feet_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_feet_vox_armalis.dmi')
	if("exclude" in species_restricted)
		LAZYDISTINCTADD(species_restricted, SPECIES_VOX)
		LAZYDISTINCTADD(species_restricted, SPECIES_VOX_ARMALIS)
	else
		LAZYREMOVE(species_restricted, SPECIES_VOX)
		LAZYREMOVE(species_restricted, SPECIES_VOX_ARMALIS)
	..()

/obj/item/clothing/mask/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_mask_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_mask_vox_armalis.dmi')
	..()

/obj/item/clothing/suit/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_suit_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_suit_vox_armalis.dmi')
	..()

/obj/item/clothing/under/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_under_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_under_vox_armalis.dmi')
	..()

/obj/item/clothing/glasses/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_eyes_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_eyes_vox_armalis.dmi')
	..()

/obj/item/clothing/head/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_head_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_head_vox_armalis.dmi')
	..()

/obj/item/weapon/holder/New()
	..()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_head_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_head_vox_armalis.dmi')

/datum/gear/mask/gas/vox
	display_name = "vox breathing mask"
	path = /obj/item/clothing/mask/gas/vox
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)

/obj/item/clothing/mask/breath/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_mask_vox.dmi')
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_mask_vox_armalis.dmi')
	..()

/obj/item/clothing/head/collectable/petehat/New()
	LAZYSET(sprite_sheets, SPECIES_VOX, 'mods/vox/icons/onmob_head_vox.dmi',)
	LAZYSET(sprite_sheets, SPECIES_VOX_ARMALIS, 'mods/vox/icons/onmob_head_vox_armalis.dmi')
	..()

/obj/item/clothing/mask/gas/vox
	name = "vox breathing mask"
	desc = "A small oxygen filter for use by Vox."
	icon_state = "respirator"
	item_state = "respirator"
	flags_inv = 0
	body_parts_covered = 0
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)
	filtered_gases = list(GAS_OXYGEN)

/obj/item/clothing/mask/gas/swat/vox
	name = "alien mask"
	desc = "Clearly not designed for a human face."
	icon_state = "voxswat"
	item_state = "voxswat"
	body_parts_covered = EYES
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)
	filtered_gases = list(
		GAS_OXYGEN,
		GAS_PHORON,
		GAS_N2O,
		GAS_CHLORINE,
		GAS_AMMONIA,
		GAS_CO,
		GAS_METHYL_BROMIDE,
		GAS_METHANE
	)

/obj/item/clothing/suit/space/vox
	w_class = ITEM_SIZE_NORMAL
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs,/obj/item/weapon/tank)
	armor = list(
		melee = ARMOR_MELEE_MAJOR, 
		bullet = ARMOR_BALLISTIC_PISTOL, 
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_MINOR, 
		bomb = ARMOR_BOMB_PADDED, 
		bio = ARMOR_BIO_SMALL, 
		rad = ARMOR_RAD_MINOR
		)
	siemens_coefficient = 0.6
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/space/vox/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 1

/obj/item/clothing/head/helmet/space/vox
	armor = list(
		melee = ARMOR_MELEE_MAJOR, 
		bullet = ARMOR_BALLISTIC_PISTOL, 
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_MINOR, 
		bomb = ARMOR_BOMB_PADDED, 
		bio = ARMOR_BIO_SMALL, 
		rad = ARMOR_RAD_MINOR
		)
	siemens_coefficient = 0.6
	item_flags = 0
	flags_inv = 0
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)

/obj/item/clothing/head/helmet/space/vox/pressure
	name = "alien helmet"
	icon_state = "vox-pressure"
	desc = "A huge, armoured, pressurized helmet. Looks like an ancient human diving suit."
	light_overlay = "invis_light"

/obj/item/clothing/suit/space/vox/pressure
	name = "alien pressure suit"
	icon_state = "vox-pressure"
	desc = "A huge, armoured, pressurized suit, designed for distinctly nonhuman proportions."

/obj/item/clothing/head/helmet/space/vox/carapace
	name = "alien visor"
	icon_state = "vox-carapace"
	desc = "A glowing visor. The light slowly pulses, and seems to follow you."
	light_overlay = "invis_light"

/obj/item/clothing/suit/space/vox/carapace
	name = "alien carapace armour"
	icon_state = "vox-carapace"
	desc = "An armoured, segmented carapace with glowing purple lights. It looks pretty run-down."

/obj/item/clothing/head/helmet/space/vox/stealth
	name = "alien stealth helmet"
	icon_state = "vox-stealth"
	desc = "A smoothly contoured, matte-black alien helmet."
	light_overlay = "invis_light"

/obj/item/clothing/suit/space/vox/stealth
	name = "alien stealth suit"
	icon_state = "vox-stealth"
	desc = "A sleek black suit. It seems to have a tail, and is very heavy."

/obj/item/clothing/head/helmet/space/vox/medic
	name = "alien goggled helmet"
	icon_state = "vox-medic"
	desc = "An alien helmet with enormous goggled lenses."
	light_overlay = "invis_light"

/obj/item/clothing/suit/space/vox/medic
	name = "alien armour"
	icon_state = "vox-medic"
	desc = "An almost organic looking nonhuman pressure suit."

/obj/item/clothing/under/vox
	has_sensor = 0
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)

/obj/item/clothing/under/vox/vox_casual
	name = "alien clothing"
	desc = "This doesn't look very comfortable."
	icon_state = "vox-casual-1"
	item_state = "vox-casual-1"
	body_parts_covered = LEGS

/obj/item/clothing/under/vox/vox_robes
	name = "alien robes"
	desc = "Weird and flowing!"
	icon_state = "vox-casual-2"
	item_state = "vox-casual-2"

/obj/item/clothing/gloves/vox
	desc = "These bizarre gauntlets seem to be fitted for... bird claws?"
	name = "insulated gauntlets"
	icon_state = "gloves-vox"
	item_state = "gloves-vox"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)

/obj/item/clothing/shoes/magboots/vox

	desc = "A pair of heavy, jagged armoured foot pieces, seemingly suitable for a velociraptor."
	name = "vox magclaws"
	item_state = "boots-vox"
	icon_state = "boots-vox"
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)

	action_button_name = "Toggle the magclaws"

/obj/item/clothing/shoes/magboots/vox/attack_self(mob/user)
	if(src.magpulse)
		item_flags &= ~ITEM_FLAG_NOSLIP
		magpulse = 0
		canremove = 1
		to_chat(user, "You relax your deathgrip on the flooring.")
	else
		//make sure these can only be used when equipped.
		if(!ishuman(user))
			return
		var/mob/living/carbon/human/H = user
		if (H.shoes != src)
			to_chat(user, "You will have to put on the [src] before you can do that.")
			return

		item_flags |= ITEM_FLAG_NOSLIP
		magpulse = 1
		canremove = 0	//kinda hard to take off magclaws when you are gripping them tightly.
		to_chat(user, "You dig your claws deeply into the flooring, bracing yourself.")
		to_chat(user, "It would be hard to take off the [src] without relaxing your grip first.")
	user.update_action_buttons()

//In case they somehow come off while enabled.
/obj/item/clothing/shoes/magboots/vox/dropped(mob/user as mob)
	..()
	if(src.magpulse)
		user.visible_message("The [src] go limp as they are removed from [usr]'s feet.", "The [src] go limp as they are removed from your feet.")
		item_flags &= ~ITEM_FLAG_NOSLIP
		magpulse = 0
		canremove = 1

/obj/item/clothing/shoes/magboots/vox/examine(mob/user)
	. = ..()
	if (magpulse)
		to_chat(user, "It would be hard to take these off without relaxing your grip first.")//theoretically this message should only be seen by the wearer when the claws are equipped.

/obj/item/weapon/rig/vox
	name = "alien rig control module"
	desc = "A strange rig. Parts of it writhe and squirm as if alive. The visor looks more like a thick membrane."
	suit_type = "alien rig"
	icon_state = "vox_rig"
	armor = list(
		melee = ARMOR_MELEE_MAJOR, 
		bullet = ARMOR_BALLISTIC_RESISTANT, 
		laser = ARMOR_LASER_HANDGUNS, 
		energy = ARMOR_ENERGY_RESISTANT, 
		bomb = ARMOR_BOMB_PADDED, 
		bio = ARMOR_BIO_SHIELDED, 
		rad = ARMOR_RAD_SHIELDED
		)
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE

	chest_type = /obj/item/clothing/suit/space/rig/vox_rig
	helm_type = /obj/item/clothing/head/helmet/space/rig/vox_rig
	boot_type = /obj/item/clothing/shoes/magboots/rig/vox_rig
	glove_type = /obj/item/clothing/gloves/rig/vox_rig
	air_type =     /obj/item/weapon/tank/nitrogen
	
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank, /obj/item/ammo_magazine, /obj/item/ammo_casing, /obj/item/ammo_magazine/shotholder, /obj/item/weapon/handcuffs, /obj/item/device/radio, /obj/item/weapon/melee/baton, /obj/item/weapon/gun, /obj/item/weapon/pickaxe)
	
	online_slowdown = 1

	initial_modules = list(
		/obj/item/rig_module/vision/meson,
		/obj/item/rig_module/mounted/plasmacutter,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/cooling_unit
		)
		
/obj/item/clothing/head/helmet/space/rig/vox_rig
	species_restricted = list(SPECIES_VOX)

/obj/item/clothing/suit/space/rig/vox_rig
	species_restricted = list(SPECIES_VOX)

/obj/item/clothing/shoes/magboots/rig/vox_rig
	species_restricted = list(SPECIES_VOX)

/obj/item/clothing/gloves/rig/vox_rig
	species_restricted = list(SPECIES_VOX)
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/vox_scrap
	name = "rusted metal armor"
	desc = "A hodgepodge of various pieces of metal scrapped together into a rudimentary vox-shaped piece of armor."
	allowed = list(/obj/item/weapon/gun, /obj/item/weapon/tank)
	armor = list(
		melee = ARMOR_MELEE_VERY_HIGH,
		bullet = ARMOR_BALLISTIC_PISTOL,
		laser = ARMOR_LASER_MINOR,
		bomb = ARMOR_BOMB_PADDED) //Higher melee armor versus lower everything else.
	icon_state = "vox-scrap"
	body_parts_covered = UPPER_TORSO|ARMS|LOWER_TORSO|LEGS
	species_restricted = list(SPECIES_VOX, SPECIES_VOX_ARMALIS)
	siemens_coefficient = 1 //Its literally metal

/obj/item/weapon/storage/box/vox
	name = "vox survival kit"
	desc = "A box decorated in warning colors that contains a limited supply of survival tools. The panel and black stripe indicate this one contains nitrogen."
	icon_state = "survivalvox"
	startswith = list(/obj/item/clothing/mask/breath = 1,
					/obj/item/weapon/tank/emergency/nitrogen = 1,
					/obj/item/weapon/reagent_containers/hypospray/autoinjector/pouch_auto/inaprovaline = 1,
					/obj/item/stack/medical/bruise_pack = 1,
					/obj/item/device/flashlight/flare/glowstick = 1,
					/obj/item/weapon/reagent_containers/food/snacks/proteinbar = 1)

/obj/item/weapon/tank/emergency/nitrogen
	name = "emergency nitrogen tank"
	desc = "An emergency air tank hastily painted red and issued to Vox crewmembers."
	icon_state = "emergency_nitro"
	gauge_icon = "indicator_emergency"
	starting_pressure = list(GAS_NITROGEN = 10*ONE_ATMOSPHERE)
