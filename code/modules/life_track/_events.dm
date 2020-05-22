/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 * 
 * Character timeline/life track stuff, inspired by games like Traveller and Infinity RPG.
 * Primary purpose of this system is to make selecting your culture, faction, species etc.
 * more organic and engaging than a few modal dropdowns on a side panel. Ideally it will
 * give people a good way to build a character if they're unsure while allowing established
 * players enough flexibility to be fun.
 *  
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 * This is less of a readme and more of a collection of notes as I code this mess, so 
 * apologies if it's confusing or meandering. The system is confusing and meandering 
 * internally as well.
 * 
 * Timelines are a sequence of events with some associated values like how many years they 
 * took and what user-chosen values were entered (such as homeworld, faction or culture). The 
 * basic structures:
 * 
 *            /decl/life_event - singleton values containing events details, their conditions, 
 *                               and logic for obtaining their potential children.
 *  /datum/life_event_instance - instance containing a reference to a /decl/life_event and any 
 *                               specific values associated with it for this character.
 * 
 *  /datum/preferences has a timeline list which is a linear list of /datum/life_event_instances.
 *  Event instance values are strings or numbers, which should be applied in pref copy to mob.
 * 
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/decl/life_event
	var/name
	var/event_type
	var/description = "This is a placeholder life event. If you can see this in your life track, please make a bug report."
	var/rand_age_step = 0
	var/min_age_step = 1
	var/min_age = 0
	var/max_age = INFINITY
	var/list/settable_fields

	var/list/denied_flags
	var/list/requires_flags
	var/list/removes_flags
	var/list/grants_flags

	var/availablility_chance = 100

	var/list/remove_links
	var/list/linked_to

/decl/life_event/proc/get_initial_values()
	. = list()
	.[TAG_AGE] = min_age_step
	if(rand_age_step)
		.[TAG_AGE] += rand() * rand_age_step
	.[TAG_AGE] = max(1, round(.[TAG_AGE]))

/decl/life_event/proc/sanitize_age(var/pref_age)
	. = max(round(max(min_age+1, min(max_age+1, pref_age))), 1)

/decl/life_event/proc/get_all_available_species()
	. = get_playable_species()

/decl/life_event/proc/get_all_culture_values(var/culture_tag, var/datum/preferences/pref)
	var/decl/species/current_species = get_species_by_key(pref.current_timeline_values[TAG_SPECIES] || global.using_map.default_species)
	. = current_species.available_cultural_info[culture_tag]

/decl/life_event/proc/get_choices_for_field(var/datum/preferences/pref, var/field)
	. = list()

	if(field == TAG_SPECIES)
		for(var/species_name in get_all_available_species())
			if(!check_rights(R_ADMIN, 0, pref.client) && config.usealienwhitelist)
				var/decl/species/current_species = get_species_by_key(species_name)
				if(!(current_species.spawn_flags & SPECIES_CAN_JOIN))
					continue
				else if((current_species.spawn_flags & SPECIES_IS_WHITELISTED) && !is_alien_whitelisted(pref.client.mob, current_species))
					continue
			. += species_name

	else if(field == TAG_GENDER)
		var/decl/species/current_species = get_species_by_key(pref.current_timeline_values[TAG_SPECIES] || global.using_map.default_species)
		for(var/decl/pronouns/pronoun in current_species.available_pronouns)
			. += pronoun.assigned_term

	else if(field in ALL_CULTURAL_TAGS)
		for(var/value in get_all_culture_values(field, pref))
			var/decl/cultural_info/culture = GET_DECL(value)
			if(culture.is_available_for_life_event(src, pref))
				.[culture.name] = culture

/decl/life_event/Initialize()
	. = ..()
	if(remove_links && linked_to)
		linked_to -= remove_links
	for(var/tag in global.all_settable_character_tags)
		if(findtext(description, "$[tag]$"))
			LAZYADD(settable_fields, tag)

/decl/life_event/proc/can_continue(var/current_flags, var/current_age)
	. = !!length(get_possible_links(current_flags, current_age))

/decl/life_event/proc/validate_against_parent(var/datum/life_event_instance/parent)
	return istype(parent) && istype(parent.linked_event) && (type in parent.linked_event.linked_to)

/decl/life_event/proc/validate_against_character(var/datum/preferences/character)
	return TRUE

/decl/life_event/proc/get_possible_links(var/list/flags, var/age, var/check_availability = TRUE)
	. = list()
	for(var/event in linked_to)
		var/skip = FALSE
		var/decl/life_event/event_datum = GET_DECL(event)
		if(event_datum.max_age < age || event_datum.min_age > age)
			continue
		if(length(event_datum.requires_flags))
			if(!length(flags))
				continue
			for(var/flag in event_datum.requires_flags)
				if(!(flag in flags))
					skip = TRUE
					break
		if(!skip && length(flags))
			for(var/flag in event_datum.denied_flags)
				if(flag in flags)
					skip = TRUE
					break
		if(!skip && (!check_availability || event == type || prob(event_datum.availablility_chance)))
			. += event
