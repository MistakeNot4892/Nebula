/decl/modpack/skill_config
	name = "Skill Config"

/datum/skillset/no_skill
	skills_transferable = FALSE

/datum/skillset/no_skill/New(mob/mob)
	..()
	for(var/decl/hierarchy/skill/S in global.skills)
		skill_list[S.type] = SKILL_EXPERT
	skill_list[SKILL_FORENSICS] = SKILL_BASIC
	skill_list[SKILL_EVA] = SKILL_ADEPT
	skill_list[SKILL_CHEMISTRY] = SKILL_ADEPT
	skill_list[SKILL_HAULING] = SKILL_ADEPT
	skill_list[SKILL_MECH] = HAS_PERK

/datum/skillset/no_skill/obtain_from_client(datum/job/job, client/given_client, override)
	. = ..()
	update_verbs()

/datum/skillset/no_skill/get_value(skill_path)
	. = skill_list[skill_path] || default_value

/obj/item/gun
	has_safety = FALSE

/mob
	skillset = /datum/skillset/no_skill