/obj/structure/flora/ringdown
	name            = "spindly growth"
	color           = "#7c9691"
	icon            = 'mods/ringdown/icons/flora/growth.dmi'
	var/base_state  = "growth"
	var/base_states = 3
	var/glow_color

/obj/structure/flora/ringdown/init_appearance()
	icon_state = "[base_state][rand(1, base_states)]"
	glow_color = pick("#c4a7e8", "#e4a7e8", "#a7aae8")
	update_icon()

/obj/structure/flora/ringdown/update_icon()
	..()
	var/image/I = emissive_overlay(icon, "[icon_state]-glow")
	I.appearance_flags |= RESET_COLOR
	I.color = glow_color
	add_overlay(I)

/obj/structure/flora/ringdown/pillar
	name            = "metallic pillar"
	icon            = 'mods/ringdown/icons/flora/trees.dmi'
	base_state      = "pillar"
