// Main body of logic and some documentation for the timeline system can be found in code/modules/life_track.

/datum/preferences
	var/list/timeline                         // Linear list of timeline event datums, starting with earliest.
	var/current_timeline_flags = list()       // List of strings corresponding to some concept, used by life events to determine possible futures.
	var/current_timeline_age = 0              // Cumulative age of the character based on all timeline events to that point.
	var/list/current_timeline_values = list() // Compiled list of timeline values like species or faction.

/datum/category_item/player_setup_item/background/timeline
	name = "Timeline"
	sort_order = 0

// Retrieves a timeline of assoc lists of event names to event values, then instantiates the event
// and values as a lifetime event datum. Proper validation is handled in sanitize_character(), this
// proc just loads and sets up the basic structure of the timeline.
/datum/category_item/player_setup_item/background/timeline/load_character(datum/pref_record_reader/R)
	pref.timeline = list()
	var/list/all_events = decls_repository.get_decls_of_type_by_var(/decl/life_event, "name")
	var/list/loaded_timeline = R.read("timeline")
	for(var/list/event_data in loaded_timeline)
		var/found = FALSE
		var/event_name = islist(event_data) && event_data["event"]
		if(!event_name)
			break
		for(var/event_type in all_events)
			var/decl/life_event/checking_event = all_events[event_type]
			if(checking_event.name == event_name)
				pref.timeline += new /datum/life_event_instance(pref, checking_event, event_data["values"])
				found = TRUE
				break
		if(!found)
			break

// Writes out the timeline list as an assoc list of event name to values.
// Currently the only values we care about are either numerical or strings, but
// in the future this might need to handle collapsing decls to a UID or instances
// to a further nested list.
/datum/category_item/player_setup_item/background/timeline/save_character(datum/pref_record_writer/W)
	var/list/save_timeline = list()
	for(var/datum/life_event_instance/event in pref.timeline)
		save_timeline += list(list("event" = event.linked_event.name, "values" = event.get_save_values()))
	W.write("timeline", save_timeline)

/datum/category_item/player_setup_item/background/timeline/sanitize_character()
	. = ..()
	validate_timeline()

// Traverses the timeline and checks that each event can follow the previous event,
// and that all event values are actually valid choices for that point in the timeline.
// The various tracking values on prefs are also updated, as they are passed to the
// event datums to determine if they are valid and what choices follow from them.
/datum/category_item/player_setup_item/background/timeline/proc/validate_timeline()

	// Reset vars; we will be rebuilding these as we validate each step of the tree.
	pref.current_timeline_flags = list()
	pref.current_timeline_age = 0

	var/decl/life_event/last_event
	for(var/i = 1 to length(pref.timeline))

		// Check that the event itself is valid and fits into this sequence of events.
		var/datum/life_event_instance/event = pref.timeline[i]
		if(!istype(event) || !event.linked_event || !event.linked_event.validate_against_parent(last_event) || !event.linked_event.validate_against_character(pref))
			pref.timeline.Cut(i)
			break
		
		// Check that the loaded values for the event are valid options for the event fields.
		var/invalid_value = FALSE
		for(var/valkey in event.linked_event.settable_fields)
			var/val = event.set_values[valkey]
			if(!isnull(val) && !(val in event.linked_event.get_choices_for_field(pref, valkey)))
				invalid_value = TRUE
				break
		if(invalid_value)
			pref.timeline.Cut(i)
			break
			
		// Track the last event for graph traversal purposes.
		event.update_preferences(pref)
		last_event = event.linked_event

// Rebuilds the preference vars from the current timeline.
/datum/category_item/player_setup_item/background/timeline/proc/refresh_timeline_vars()
	pref.current_timeline_flags = list()
	pref.current_timeline_age = 0
	for(var/datum/life_event_instance/event in pref.timeline)
		event.update_preferences(pref)

/datum/category_item/player_setup_item/background/timeline/content()
	. = list()

	// We have an established timeline; traverse it and format it nicely, including links, strings etc.
	. += "<table align = 'center' width = 100%>"
	if(length(pref.timeline))

		. += "<tr>"
		. += "<td><b>Life Event</b></td>"
		. += "<td><b>Description<b></td>"
		. += "</tr>"

		var/last_event_name
		for(var/datum/life_event_instance/event in pref.timeline)

			. += "<tr border = '1px'>"
			if(!last_event_name || event.name != last_event_name)
				. += "<td><b>[event.linked_event.name]</b></td>"
				. += "<td>[event.get_description(src)]</td>"
			else 
				. += "<td colspan = 2><center><i>Continued with [event.linked_event.name]...</i></center></td>"
			. += "</tr>"

			last_event_name = event.name

		. += "<tr>"
		. += "<td colspan = 2><center>You [last_event_name == "Died" ? "were" : "are"] [pref.current_timeline_age] year\s old.</center></td>"
		. += "<tr>"
		. += "</tr>"
		. += "<td colspan = 2><center>Debug: current values are [json_encode(pref.current_timeline_values)].</center></td>"
		. += "</tr>"

		// Can we keep selecting events from this point, or is this the end of the line?
		var/datum/life_event_instance/event = pref.timeline[length(pref.timeline)]
		if(event.linked_event.can_continue(pref.current_timeline_flags, pref.current_timeline_age))
			. += "<tr><td colspan = 2><center>Where did you go from here?</center></td></tr>"
			. += "<tr><td colspan = 2><center>"
			var/i = 0
			var/links = event.linked_event.get_possible_links(pref.current_timeline_flags, pref.current_timeline_age, FALSE)
			for(var/option in links)
				var/decl/life_event/possible_event = GET_DECL(option)
				. += "<a href='?src=\ref[src];continue=1;continue_choice=\ref[possible_event]'>[possible_event.name]</a>"
				// Manually insert linebreaks because sequences of links break the layout for some reason. 
				i++
				if(i % 5 == 0 && i != length(links))
					. += "<br/>"
			. += "<br/><a href='?src=\ref[src];continue=1;random=1'>Trust to chance</a><a href='?src=\ref[src];abandon=1'>Start over</a></center></td></tr>"
		else
			. += "<tr><td colspan = 2><center>Your backstory ends here.</center></td></tr>"
			. += "<tr><td colspan = 2><center><a href='?src=\ref[src];abandon=1'>Start over</a></center></td></tr>"

	// We have no established timeline, give them some links to start one.
	else
		. += "<tr><td><center>How did your life begin?</center></td></tr>"
		. += "<tr><td>"

		// If no birth subtypes are defined, we default to the base type, otherwise we skip it.
		var/list/all_birth_events = decls_repository.get_decls_of_subtype_by_var(/decl/life_event/birth, "name")
		if(!length(all_birth_events))
			var/decl/life_event/babu = GET_DECL(/decl/life_event/birth)
			all_birth_events[babu.name] = babu

		var/i = 0
		. += "<center>"
		for(var/event in all_birth_events)
			var/decl/life_event/possible_event = all_birth_events[event]
			. += "<a href='?src=\ref[src];continue=1;continue_choice=\ref[possible_event]'>[possible_event.name]</a>"
			// Manually insert linebreaks because sequences of links break the layout for some reason. 
			i++
			if(i % 5 == 0 && i != length(all_birth_events))
				. += "<br/>"
		. += "<br/><a href='?src=\ref[src];continue=1;random=1'>Trust to chance</a></center></td></tr>"
	. += "</table>"
	. = jointext(.,null)

/datum/category_item/player_setup_item/background/timeline/OnTopic(var/href, var/list/href_list, var/mob/user)

	// A life event is trying to chang a set value.
	if(href_list["life_event"])

		var/field = href_list["life_event_field"]
		var/datum/life_event_instance/event = locate(href_list["life_event"])

		if(!istype(event) || !(event in pref.timeline) || event.set_values["finalized"] || !(field in event.set_values))
			return TOPIC_NOACTION

		var/new_value = input("Select a new option.", "Character [capitalize(field)]", event.set_values[field]) as null|anything in event.linked_event.get_choices_for_field(pref, field)
		if(!new_value || !istype(event) || !(event in pref.timeline) || event.set_values["finalized"] || !(field in event.set_values))
			return TOPIC_NOACTION

		pref.current_timeline_values[field] = new_value
		event.set_value(pref, field, new_value)
		refresh_timeline_vars() // In case something was rendered invalid or different by set_value().
		return TOPIC_REFRESH

	// Pick a new step in the timeline!
	if(href_list["continue"])

		var/randomize_choice = !!href_list["random"]
		var/timeline_length = length(pref.timeline)

		// What are the possible events connected to our last one (if one exists)?
		var/list/options
		var/datum/life_event_instance/last_event 
		if(timeline_length)
			last_event = pref.timeline[timeline_length]
		if(last_event)
			options = last_event.linked_event.get_possible_links(pref.current_timeline_flags, pref.current_timeline_age, randomize_choice)
			if(!length(options))
				return
		else
			options = subtypesof(/decl/life_event/birth)
			if(!length(options))
				options = list(/decl/life_event/birth)

		// If this is a random pick, we can skip getting user input, otherwise they need to be prompted to choose an event.
		var/decl/life_event/next_event
		if(randomize_choice)
			next_event = GET_DECL(pick(options))
		else
			for(var/event_type in options)
				var/decl/life_event/event = GET_DECL(event_type)
				options -= event_type
				options[event.name] = event
			if(href_list["continue_choice"])
				next_event = locate(href_list["continue_choice"])
				if(!(next_event.name in options))
					return TOPIC_NOACTION
			else
				next_event = input(user, "Where does your life go from here?", "Timeline") as null|anything in options
				if(next_event)
					next_event = options[next_event]
	
		if(!istype(next_event) || timeline_length != length(pref.timeline) || !next_event.validate_against_parent(last_event) || !next_event.validate_against_character(pref))
			return TOPIC_NOACTION

		// Add a new timeline instance and refresh.
		if(last_event)
			last_event.set_values["finalized"] = TRUE // We can't go back Morty.
		pref.timeline += new /datum/life_event_instance(pref, next_event)
		refresh_timeline_vars()
		return TOPIC_REFRESH

	// Clear the timeline to date and refresh to start over.
	if(href_list["abandon"])
		pref.timeline.Cut()
		refresh_timeline_vars()
		return TOPIC_REFRESH
