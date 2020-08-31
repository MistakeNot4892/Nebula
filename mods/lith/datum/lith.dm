/datum/species/lith
	name = SPECIES_LITH
	name_plural = SPECIES_LITH
	description = ":boulderbuddy:"

	bodytype = BODYTYPE_SPHERE
	icobase =         'mods/lith/icons/species/body.dmi'
	deform =          'mods/lith/icons/species/body.dmi'
	damage_overlays = 'mods/lith/icons/species/damage.dmi'
	damage_mask =     'mods/lith/icons/species/damage_mask.dmi'
	blood_mask =      'mods/lith/icons/species/blood.dmi'

	//language = null
	//default_language = LANGUAGE_LITH

	mob_size = MOB_SIZE_LARGE
	show_ssd = "still and quiet"
	death_message = "crackles and shivers as the luster fades from its eye"
	breath_type = null
	poison_types = null
	unarmed_attacks = list(/decl/natural_attack/ram)
	hud_type = /datum/hud_data/lith
	appearance_flags = HAS_EYE_COLOR | HAS_SKIN_COLOR
	spawn_flags = SPECIES_CAN_JOIN
	limb_blend = ICON_MULTIPLY

	has_organ = list(
		BP_BRAIN = /obj/item/organ/internal/brain/lith,
		BP_EYES = /obj/item/organ/internal/eyes/lith
	)
	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest/lith),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/lith),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/lith),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/lith),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/lith),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/lith),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/lith),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/lith),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/lith),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/lith),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/lith)
		)

/datum/species/lith/post_organ_rejuvenate(obj/item/organ/org, mob/living/carbon/human/H)
	var/obj/item/organ/external/E = org
	if(istype(E))
		E.status = ORGAN_CRYSTAL
	var/obj/item/organ/external/head/head = org
	if(istype(head))
		head.glowing_eyes = TRUE
	..()

/obj/item/organ/external/chest/lith
	name = "rear shell"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/groin/lith
	name = "inner node"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/arm/lith
	name = "left forward tendril"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/arm/right/lith
	name = "right forward tendril"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/leg/lith
	name = "left rear tendrils"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/leg/right/lith
	name = "right rear tendrils"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/hand/lith
	name = "left forward tendril tip"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/hand/right/lith
	name = "right forward tendril tip"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/foot/lith
	name = "left rear tendril tips"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/foot/right/lith
	name = "right rear tendril tips"
	skin_blend = ICON_MULTIPLY
/obj/item/organ/external/head/lith
	name = "forward node"
	skin_blend = ICON_MULTIPLY

/datum/hud_data/lith
	has_internals = FALSE
	gear = list(
		"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head_str,      "state" = "hair",   "toggle" = 1),
		"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back_str,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id_str,   "state" = "id")
	)

/datum/sprite_accessory/marking/lith
	name = "Lith Plating"
	species_allowed = list(SPECIES_LITH)
	body_parts = list(BP_CHEST)
	icon_state = "lith_armour"
	layer_blend = ICON_MULTIPLY
	icon = 'mods/lith/icons/species/markings.dmi'

/datum/sprite_accessory/marking/lith/shine
	name = "Lith Shine"
	icon_state = "lith_shine"

/obj/item/organ/internal/brain/lith
	name = "lith core"
	desc = "A fist-sized chunk of glossy, metallic stone."

/obj/item/organ/internal/brain/lith/Initialize()
	. = ..()
	status |= ORGAN_CRYSTAL

/obj/item/organ/internal/brain/lith/robotize()
	return

/obj/item/organ/internal/eyes/lith
	eye_icon = 'mods/lith/icons/species/eyes.dmi'
	eye_blend = ICON_MULTIPLY

/obj/item/organ/internal/eyes/lith/Initialize()
	. = ..()
	status |= ORGAN_CRYSTAL

/obj/item/organ/internal/eyes/lith/robotize()
	return

/decl/natural_attack/ram
	attack_verb = list("rammed")
	attack_noun = list("body")
	eye_attack_text = "spikes"
	eye_attack_text_victim = "spikes"
