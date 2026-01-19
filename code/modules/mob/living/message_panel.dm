/datum/message_panel
	var/message_type = /mob/living::MESSAGE_SPEECH
	var/last_saved_text
	var/weakref/browser_ref
	var/closed = TRUE

/datum/message_panel/New(mob/living/_owner, _message_type)
	message_type = _message_type

/datum/message_panel/Destroy()
	var/datum/browser/browser = browser_ref?.resolve()
	if(istype(browser) && !QDELETED(browser))
		browser.close()
		browser_ref = null
	return ..()

/datum/message_panel/proc/interact(mob/user, _message_type)

	message_type = _message_type || /mob/living::MESSAGE_SPEECH
	var/datum/browser/browser = browser_ref?.resolve() // Not sure if this is valid, or if we should be destroying and remaking every time.
	if(!istype(browser) || QDELETED(browser))
		browser = new(user, "speech_message_panel", null, 600, 400)
		browser_ref = weakref(browser)

	var/list/dat = list()
	dat += "<h3>"
	switch(message_type)
		if(/mob/living::MESSAGE_SPEECH)
			dat += "Enter Your Speech"
		if(/mob/living::MESSAGE_EMOTE)
			dat += "Enter Your Emote"
	dat += "</h3>"
	dat += "<br/>"

	dat += "<form id='message_panel_form' method='GET' action='byond://?src=\ref[src]'>"
	dat += "<input type='hidden' name='src' value='\ref[src]'/>"
	//dat += "<input type='submit' name='preview_message' value='Preview'/>"
	//dat += "<input type='submit' name='send_message' value='Send'/>"
	//dat += "<input type='submit' name='close_panel' value='Close'/>"
	dat += "<input type='submit' value='Submit'><br>"
	dat += "</form>"
	dat += "<textarea id='panel_message' form='message_panel_form' name ='panel_message' rows='4' cols='50'>[last_saved_text]</textarea>"

	closed = FALSE
	browser.set_content(JOINTEXT(dat))
	browser.update(TRUE, TRUE) // onclose does not work...
	onclose(user, "speech_message_panel")

/datum/message_panel/proc/close_panel()
	var/datum/browser/browser = browser_ref?.resolve()
	if(!istype(browser) || QDELETED(browser))
		return
	to_world("closing message panel!")
	browser.close()
	closed = TRUE

/datum/message_panel/Topic(href, href_list)

	to_world("message panel topic: [json_encode(href_list)]")

	if((. = ..()))
		return

	if(href_list["close"] || href_list["close_panel"] || href_list["send_message"])
		close_panel()
		return TOPIC_HANDLED

	if(href_list["send_message"])
		close_panel()
		send_message()
		return TOPIC_HANDLED

	if(href_list["preview_message"])
		preview_message()
		return TOPIC_HANDLED

/datum/message_panel/proc/send_message(message)
	last_saved_text = null

/datum/message_panel/proc/preview_message(message)
	last_saved_text = message

/mob
	var/const/MESSAGE_SPEECH = 1
	var/const/MESSAGE_EMOTE  = 2
	VAR_PRIVATE/weakref/_message_panel

/mob/proc/message_panel_is_open()
	if(!_message_panel)
		return FALSE
	var/datum/message_panel/panel = _message_panel?.resolve()
	if(!istype(panel) || QDELETED(panel))
		return FALSE
	return !panel.closed

/mob/proc/open_message_panel(message_type = MESSAGE_SPEECH)
	var/datum/message_panel/panel = _message_panel?.resolve()
	if(!istype(panel) || QDELETED(panel))
		panel = new()
		_message_panel = weakref(panel)
	panel.interact(src, message_type)
