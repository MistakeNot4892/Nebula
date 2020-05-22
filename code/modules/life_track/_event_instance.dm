/datum/life_event_instance
	var/name = "Life Event"
	var/decl/life_event/linked_event
	var/list/set_values = list()

/datum/life_event_instance/New(var/datum/preferences/pref, var/decl/life_event/event, var/list/values)
	..()

	linked_event = event
	name = linked_event.name

	// Initialize our values list, either via the defaults from our linked event or from the supplied list.
	if(!islist(values))
		values = linked_event.get_initial_values()
	set_values = values
	if(!islist(set_values))
		set_values = list()
	validate_set_values(pref)

/datum/life_event_instance/proc/set_value(var/datum/preferences/pref, var/key, var/value)
	set_values[key] = value
	validate_set_values(pref)

/datum/life_event_instance/proc/validate_set_values(var/datum/preferences/pref)
	// Write default values for any settable fields that don't already have them, or which are invalid.
	for(var/value in linked_event.settable_fields)
		var/list/possibilities = linked_event.get_choices_for_field(pref, value)
		if(!(set_values[value] in possibilities))
			set_values[value] = null
		if(isnull(set_values[value]) && length(possibilities))
			set_values[value] = possibilities[1]
			validate_set_values(pref) // Recurse to make sure we don't set a default value that invalidates a previously set value.
			return

/datum/life_event_instance/proc/update_preferences(var/datum/preferences/pref)
	if(!linked_event || !pref)
		return
	pref.current_timeline_age = linked_event.sanitize_age(pref.current_timeline_age + set_values[TAG_AGE])
	if(length(linked_event.grants_flags))
		pref.current_timeline_flags |= linked_event.grants_flags
	if(length(linked_event.removes_flags))
		pref.current_timeline_flags -= linked_event.removes_flags
	for(var/value in set_values)
		pref.current_timeline_values[value] = set_values[value]

/datum/life_event_instance/proc/get_save_values()
	. = list()
	for(var/thing in set_values)
		.[thing] = set_values[thing]

/datum/life_event_instance/proc/summarize_values()
	return json_encode(set_values)

/datum/life_event_instance/proc/get_description(var/caller)
	. = linked_event.description
	for(var/substring in linked_event.settable_fields)
		var/codex_key = "[set_values[substring]] ([lowertext(substring)])"
		var/codex_link = "<small><a href='?src=\ref[SScodex];show_examined_info=[codex_key];show_to=\ref[usr]'>?</a></small>"
		if(set_values["finalized"])
			. = replacetext(., "$[substring]$", "<b>[set_values[substring]]</b>[codex_link]")
		else
			. = replacetext(., "$[substring]$", "<a href='?src=\ref[caller];life_event=\ref[src];life_event_field=[substring]'>[set_values[substring]]</a>[codex_link]")
