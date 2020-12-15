/datum/antagonist/raider/check_special_species(var/mob/living/carbon/human/player)
	..()
	if(player.species && player.species.get_bodytype(player) == SPECIES_VOX)
		equip_vox(player)
		return TRUE

/datum/antagonist/raider/proc/equip_vox(var/mob/living/carbon/human/player)

	var/uniform_type = pick(list(/obj/item/clothing/under/vox/vox_robes,/obj/item/clothing/under/vox/vox_casual))
	var/new_glasses = pick(raider_glasses)
	var/new_holster = pick(raider_holster)

	player.equip_to_slot_or_del(new uniform_type(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/magboots/vox(player), slot_shoes) // REPLACE THESE WITH CODED VOX ALTERNATIVES.
	player.equip_to_slot_or_del(new /obj/item/clothing/gloves/vox(player), slot_gloves) // AS ABOVE.
	player.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/swat/vox(player), slot_wear_mask)
	player.equip_to_slot_or_del(new /obj/item/weapon/tank/nitrogen(player), slot_back)
	player.equip_to_slot_or_del(new /obj/item/device/flashlight(player), slot_r_store)
	player.equip_to_slot_or_del(new new_glasses(player),slot_glasses)

	var/obj/item/clothing/accessory/storage/holster/holster = new new_holster
	if(holster)
		var/obj/item/clothing/under/uniform = player.w_uniform
		if(istype(uniform) && uniform.can_attach_accessory(holster))
			uniform.attackby(holster, player)
		else
			player.put_in_any_hand_if_possible(holster)

	player.set_internals(locate(/obj/item/weapon/tank) in player.contents)
	return 1

// The following mirror is ~special~.
/obj/item/weapon/storage/mirror/raider
	name = "cracked mirror"
	desc = "Something seems strange about this old, dirty mirror. Your reflection doesn't look like you remember it."
	icon_state = "mirror_broke"
	shattered = 1

/obj/item/weapon/storage/mirror/raider/use_mirror(mob/living/carbon/human/user)
	if(istype(get_area(src),/area/map_template/syndicate_mothership))
		if(istype(user) && user.mind && user.mind.special_role == "Raider" && user.species.name != SPECIES_VOX && is_alien_whitelisted(user, SPECIES_VOX))
			var/choice = input("Do you wish to become a true Vox of the Shoal? This is not reversible.") as null|anything in list("No","Yes")
			if(choice && choice == "Yes")
				var/mob/living/carbon/human/vox/vox = new(get_turf(src),SPECIES_VOX)
				GLOB.raiders.equip(vox)
				if(user.mind)
					user.mind.transfer_to(vox)
				spawn(1)
					var/newname = sanitizeSafe(input(vox,"Enter a name, or leave blank for the default name.", "Name change","") as text, MAX_NAME_LEN)
					if(!newname || newname == "")
						var/decl/cultural_info/voxculture = SSculture.get_culture(CULTURE_VOX_RAIDER)
						newname = voxculture.get_random_name()
					vox.real_name = newname
					vox.SetName(vox.real_name)
					GLOB.raiders.update_access(vox)
				qdel(user)

/obj/item/weapon/magic_rock/New()
	LAZYSET(potentials, SPECIES_VOX, /spell/targeted/shapeshift/true_form)
	..()
