var/global/list/_mimic_verb_list = list(
	/mob/living/proc/mimic_change_appearance_verb,
	/mob/living/proc/mimic_memorise_appearance_verb
)

/datum/extension/mimic_role
	base_type     = /datum/extension/mimic_role
	expected_type = /mob/living/human
	var/list/memorised_appearances

/datum/extension/mimic_role/New(datum/holder)
	. = ..()
	if(istype(holder, expected_type))
		var/mob/living/owner = holder
		owner.verbs |= global._mimic_verb_list

/datum/extension/mimic_role/Destroy()
	QDEL_NULL(memorised_appearances)
	if(istype(holder, expected_type))
		var/mob/living/owner = holder
		owner.verbs -= global._mimic_verb_list
	return ..()

/datum/extension/mimic_role/proc/memorise_appearance(mob/living/target, silent = FALSE)
	var/datum/mob_snapshot/snapshot = target.get_mob_snapshot(check_dna = TRUE)
	if(!istype(snapshot))
		if(!silent)
			to_chat(usr, SPAN_WARNING("You cannot replicate \the [target]'s appearance."))
		return
	var/existing = LAZYACCESS(memorised_appearances, target.name) // TODO: more unique identifier?
	qdel(existing)
	LAZYSET(memorised_appearances, target.name, snapshot)
	if(!silent)
		to_chat(usr, SPAN_NOTICE("You study \the [target], memorising the details of [target.get_pronouns().his] appearance."))

/datum/extension/mimic_role/proc/get_possible_appearance_changes()
	return null

/datum/extension/mimic_role/proc/change_appearance(change_category)
	to_chat(usr, SPAN_NOTICE("You adjust the appearance of your [change_category]."))
	memorise_appearance(usr, silent = TRUE) // Update our own appearance reference.

/datum/extension/mimic_role/proc/get_memorisation_candidates(mob/living/user)
	// TODO: study through camera somehow, or study from a photo.
	// TODO: check facial coverage?
	for(var/mob/living/human/target in view(user))
		if(target == user || target.isSynthetic())
			continue
		LAZYADD(., target)

/mob/living/proc/mimic_memorise_appearance_verb()
	set name = "Memorise Appearance"
	set category = "Mimic"
	set src = usr
	if(incapacitated(INCAPACITATION_DISABLED))
		to_chat(usr, SPAN_WARNING("You are in no state to change your appearance."))
		return
	var/datum/extension/mimic_role/mimic_data = get_extension(src, /datum/extension/mimic_role)
	if(!istype(mimic_data))
		verbs -= global._mimic_verb_list
		return
	var/list/choices = mimic_data.get_memorisation_candidates(src)
	if(!length(choices))
		to_chat(usr, SPAN_WARNING("You cannot see anyone worth studying nearby."))
		return
	var/choice = input(usr, "Who do you want to study and memorise?", "Mimic Appearance") as null|anything in choices
	if(!choice || incapacitated(INCAPACITATION_DISABLED) || !(choice in mimic_data.get_memorisation_candidates(src)))
		return
	mimic_data.memorise_appearance(choice)

/mob/living/proc/mimic_change_appearance_verb()
	set name = "Change Appearance"
	set category = "Mimic"
	set src = usr
	if(incapacitated(INCAPACITATION_DISABLED))
		to_chat(usr, SPAN_WARNING("You are in no state to change your appearance."))
		return
	var/datum/extension/mimic_role/mimic_data = get_extension(src, /datum/extension/mimic_role)
	if(!istype(mimic_data))
		verbs -= global._mimic_verb_list
		return
	var/list/choices = mimic_data.get_possible_appearance_changes()
	if(!length(choices))
		to_chat(usr, SPAN_WARNING("You cannot change appearance currently."))
		return
	var/choice = input(usr, "What aspect of your appearance do you want to change?", "Mimic Appearance") as null|anything in choices
	if(!choice || incapacitated(INCAPACITATION_DISABLED) || !(choice in mimic_data.get_possible_appearance_changes()))
		return
	mimic_data.change_appearance(choice)

/mob/living/proc/mimic_swap_appearance_verb()
	set name = "Swap Appearance"
	set category = "Mimic"
	set src = usr
	if(incapacitated(INCAPACITATION_DISABLED))
		to_chat(usr, SPAN_WARNING("You are in no state to change your appearance."))
		return
	var/datum/extension/mimic_role/mimic_data = get_extension(src, /datum/extension/mimic_role)
	if(!istype(mimic_data))
		verbs -= global._mimic_verb_list
		return
	var/choice = input(usr, "Which memorised appearance would you like to use?", "Mimic Appearance") as null|anything in mimic_data.memorised_appearances
	if(!choice || incapacitated(INCAPACITATION_DISABLED) || !(choice in mimic_data.memorised_appearances))
		return
	//var/datum/mob_snapshot/appearance = LAZYACCESS(mimic_data.memorised_appearances, choice)
	visible_message(SPAN_NOTICE("\The [src] twitches and spasms as [get_pronouns().his] appearance shifts."))
	to_chat(src, "You alter your appearance to mimic your memory of [choice].")
	// TODO: apply appearance to organic organs.

/mob/living/verb/debug_mimic()
	set name = "Debug Mimic"
	set category = "Debug"
	set src = usr
	get_or_create_extension(src, /datum/extension/mimic_role)
	to_chat(src, SPAN_NOTICE("Done."))
