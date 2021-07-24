//Queued screen text
/proc/advanced_screen_text(client/client, source, source_name = "", text = "", additional_tags = list("",""), box = /obj/screen/text_message)
	if(!client)
		return

	var/obj/screen/text_message/last = locate() in client.screen //Currently no support for multiple windows, todo
	if(ispath(box) && !QDELETED(last))
		last.queue.Insert(1, CALLBACK(GLOBAL_PROC, .proc/advanced_screen_text, client, source, source_name, text, additional_tags, ((box == last.type) ? last : new box)))
		return //message queued, exit

	if(ispath(box))
		box = new box

	var/obj/screen/text_message/working = box
	if(QDELETED(working)) //see below
		return

	if(last && (working != last))
		working.queue = last.queue.Copy()
		client.screen -= last
		qdel(last) //there is almost zero cases including often window box change so too bad
		working.transform = matrix() //open it instantly

	client.screen |= working

	if(working.transform != matrix()) //new window
		animate(working, transform = matrix(), time = working.fade_delay, easing = QUAD_EASING)
	if(!islist(additional_tags)) additional_tags = list("","")
	for(var/i = 2 to length(text)+1) //2 is because we need something after <br> so there will be no twitchy text shift
		working.maptext = html_decode("<span style=\"[working.text_style]\">[source_name ? "<p style=\"color: aqua; font-size: 160%;\"><b>[source_name]</b></p>" : null]<br>[additional_tags[1]][text[1]][copytext_char(text,2,i)][additional_tags[2]]</span>")
		sleep(working.text_delay) //would be fun to play sound as each symbol gets drawn, not sure about that

	addtimer(CALLBACK(GLOBAL_PROC, .proc/advanced_screen_text_fade, client, working), working.text_duration)

//Don't call this, handles the text fadeout and message queue
/proc/advanced_screen_text_fade(client/client, obj/screen/text_message/box)
	if(!client)
		qdel(box)
		return

	if(box.queue.len) //we have some queued messages, print them and handle message box type change
		var/datum/callback/executing = pop(box.queue)
		executing.Invoke()
		return

	animate(box, transform = box.start_transform, time = box.fade_delay, easing = QUAD_EASING)
	sleep(box.fade_delay)
	qdel(box)
	client.screen -= box

//used by advanced_screen_text(...), make subtypes of this and then pass it to the proc
/obj/screen/text_message
	icon = 'icons/screen/message_box.dmi'
	maptext_height = 112
	maptext_width = 304 //cuz space for portrait
	maptext_x = 8
	maptext_y = -16
	screen_loc= "LEFT+1,BOTTOM+3"
	layer = FLOAT_LAYER

	var/fade_delay = 0.7 SECOND //Delay for actual message box appear (speed of appear/dissappear)
	var/text_delay = 1 //deciseconds between symbol drawing
	var/text_duration = 4.5 SECONDS //seconds for this window to "persist doing nothing"
	var/text_style = "font-family: 'Small Fonts'; -dm-text-outline: 1 black; font-size: 6px; line-height: 95%; vertical-align: top;"
	var/list/queue = list() //Used to store queued messages for seamless display
	var/matrix/start_transform

/obj/screen/text_message/Initialize(mapload, mob/_owner, ui_style, ui_color, ui_alpha)
	var/matrix/M = matrix()
	M.Scale(x = 0, y = 1)
	start_transform = M
	transform = M
	. = ..()

/obj/screen/text_message/Destroy()
	QDEL_LIST(queue)
	. = ..()

// Subtypes below.
/obj/screen/text_message/bare
	icon = null
	fade_delay = 0
	text_style = "font-family: 'Fixedsys'; -dm-text-outline: 1 black; font-size: 11px;"
	maptext_height = 64
	maptext_width = 512
	maptext_x = 0
	maptext_y = 0
	screen_loc = "LEFT+1,BOTTOM+2"
