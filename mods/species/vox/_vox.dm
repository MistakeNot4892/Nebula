#define BODYTYPE_VOX       "reptoavian body"
#define BODYTYPE_VOX_LARGE "large reptoavian body"
#define BP_HINDTONGUE      "hindtongue"
#define BODY_EQUIP_FLAG_VOX      BITFLAG(8)

/decl/modpack/vox
	name = "Shoaler Content"
	dreams = list("a red stool", "a Shoal raider")
	credits_crew_names = list("THE SHOAL")
	credits_topics = list("SHOAL RITUAL DUELS", "NECK MARKINGS", "ANCIENT SUPERCOMPUTERS")

/mob/living/human/vox/Initialize(mapload, species_uid, datum/mob_snapshot/supplied_appearance)
	SET_HAIR_STYLE(src, /decl/sprite_accessory/hair/vox/short, TRUE)
	SET_HAIR_COLOR(src, COLOR_BEASTY_BROWN, TRUE)
	species_uid = /decl/species/vox::uid
	. = ..()

/datum/follow_holder/voxstack
	sort_order = 14
	followed_type = /obj/item/organ/internal/voxstack

/datum/follow_holder/voxstack/show_entry()
	var/obj/item/organ/internal/voxstack/S = followed_instance
	return ..() && !S.owner
