#define SPECIES_VOX "Vox"
#define SPECIES_VOX_ARMALIS "Vox Armalis"
#define BODYTYPE_VOX "Reptoavian Body"

#define BP_HINDTONGUE "hindtongue"

#define CULTURE_VOX_ARKSHIP    "Arkship Crew"
#define CULTURE_VOX_SALVAGER   "Salvager Crew"
#define CULTURE_VOX_RAIDER     "Raider Crew"

#define HOME_SYSTEM_VOX_ARK    "Ark-Dweller"
#define HOME_SYSTEM_VOX_SHROUD "Shroud-Dweller"
#define HOME_SYSTEM_VOX_SHIP   "Ship-Dweller"

#define FACTION_VOX_RAIDER     "Raider"
#define FACTION_VOX_CREW       "Ark Labourer"
#define FACTION_VOX_APEX       "Apex Servant"

#define RELIGION_VOX           "Auralis Reverence"

#define LANGUAGE_VOX               "Vox-pidgin"

/decl/modpack/vox
	name = "Vox Content"

/mob/living/carbon/human/vox/New(var/new_loc)
	h_style = "Long Vox Quills"
	..(new_loc, SPECIES_VOX)

/datum/follow_holder/voxstack
	sort_order = 14
	followed_type = /obj/item/organ/internal/voxstack

/datum/follow_holder/voxstack/show_entry()
	var/obj/item/organ/internal/voxstack/S = followed_instance
	return ..() && !S.owner
