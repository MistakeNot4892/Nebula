/datum/appearance_descriptor/age/vox
	chargen_min_index = 3
	chargen_max_index = 6
	standalone_value_descriptors = list(
		"freshly spawned" =  1,
		"a larva" =          2,
		"a juvenile" =       5,
		"an adolescent" =    8,
		"an adult" =        12,
		"senescent" =       50,
		"withered" =        65
	)

/decl/blood_type/vox
	name = "shoal ichor"
	antigen_category = "vox"
	splatter_name = "ichor"
	splatter_desc = "A smear of thin, sticky alien ichor."
	splatter_colour = "#2299fc"
	transfusion_fail_reagent = /decl/material/gas/ammonia

/decl/species/vox
	uid = "species_vox"
	name = "Shoaler"
	name_plural = "Shoalers"
	base_external_prosthetics_model = /decl/bodytype/prosthetic/vox/crap

	default_emotes = list(
		/decl/emote/audible/vox_shriek
	)

	inherent_verbs = list(
		/mob/living/human/proc/toggle_vox_pressure_seal
	)

	rarity_value = 4


/*
- Shoalers need 'reclamation vats' that meat objects and mobs get digested into biomass in, to be fed into biofoundries.
Humans are tolerated in shoal expeditions (local guides, local labour, tagalongs) but shoalers also aren't shy about
recycling them into new armour or limbs for themselves.
- Biofoundries also need to exist - fab that takes biomass chunks or reagents and other mats to print vox tech.
- Related to above shoaler organs shouldn't be made of meat and they should need specialized medkits to do more than bandage or suture themselves.
*/

	rarity_value = 4
	description = \
	"Shoalers are the last remnants of an ancient stellar culture. Their masters were peerless shapers of flesh and chitin, and wrought the shoal in their image to serve as their hands and eyes. Now the masters are gone, and their houses are empty, leaving their machines and lost children to try to find a way forward. \
	<br><br> \
	The people of the shoal are deathless, housed in vat-grown bodies and given new life by the transfer of their cortical stacks. Their existence is one of unending work, driven by divine purpose, and they serve at the behest of the god-machines that once kept the worlds of their masters running. Now the gods are rotting, and their directions are becoming increasingly wild and deranged."

	codex_description = \
	"Also commonly known as: screamers, shriekers, vox. \
	<br><br> \
	Shoalers are a nitrogen-breathing species (or several species, see below) of repto-avian sapients. In surviving CSA records, they're referred to as 'vox', and between those same records and those of the Imperial House and the chrysoarmis, historically they tended towards antagonizing and raiding lightly defended ships and stations for raw resources. On the Plate, it seems that things are a bit different, and shoalers are frequently seen attached to trading caravans or salvaging expeditions alongside the other local forces. \
	<br><br> \
	At least three distinct shoal bodyforms have been observed, two of which are some kind of labourer or servitor form, and one of which is a more heavily armoured soldier form. While shoalers are loud, rude, and frequently elitist, isolationist pricks, they are not violent or overly aggressive unless provoked. \
	<br><br> \
	Under no circumstances should you try their cooking."

	roleplay_summary = \
	"<ul> \
	<li>Shoalers are lizard-avian biomachine thralls of mad computer gods, and they are near-universally devoted to maintaining KHAKRIKITA-KHA, the last surviving arkship on the Plate, via trading, salvaging, and theft.</li> \
	<li>They tend to be obnoxiously loud, vain and insular, and generally sneer at any non-shoal technology or individual as primitive meat.</li> \
	<li>Neck-markings encoded with their personal histories and achievements are a point of pride for shoalers, and they will often get into first-blood scuffles over establishing a pecking order amongst their fellows.</li> \
	<li>Shoalers are scavengers and will happily eat anything with the slightest amount of nutrition or even useful metals or chemicals, which will be processed and vomited up again by their impressively efficient gizzard and stomach.</li> \
	</ul>"

	ooc_codex_information = \
	"<ul> \
	<li>Shoalers breathe nitrogen and are poisoned by oxygen, so outside of sealed environments suited to them they will need to wear a filter mask or a breath mask and nitrogen tank.</li> \
	<li>Shaper bodyforms can eat almost anything and digest it into usable sheets, which can be vomited back up.</li> \
	<li>Soldier bodyforms are pressure resistant and capable of very long standing leaps, but servitor bodyforms are less robust.</li> \
	</ul>"

	scream_verb_1p = "shriek"
	scream_verb_3p = "shrieks"

	hidden_from_codex = FALSE

	taste_sensitivity = TASTE_DULL
	speech_sounds = list('sound/voice/shriek1.ogg')
	speech_chance = 20

	preview_outfit = /decl/outfit/job/ringdown/shoaler

	gluttonous = GLUT_TINY|GLUT_ITEM_NORMAL
	stomach_capacity = 12

	breath_type = /decl/material/gas/nitrogen
	poison_types = list(/decl/material/gas/oxygen = TRUE)
	shock_vulnerability = 0.2

	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED

	blood_types = list(/decl/blood_type/vox)
	flesh_color = "#808d11"

	maneuvers = list(/decl/maneuver/leap/grab)
	standing_jump_range = 5

	available_pronouns = list(
		/decl/pronouns/neuter,
		/decl/pronouns/neuter/person,
		/decl/pronouns,
		/decl/pronouns/male,
		/decl/pronouns/female
	)
	// Add when clothing is available: /decl/bodytype/vox/stanchion
	available_bodytypes = list(
		/decl/bodytype/vox,
		/decl/bodytype/vox/servitor,
		/decl/bodytype/vox/servitor/alchemist,
	)

/*
	available_background_info = list(
		/decl/background_category/citizenship = list(
			/decl/background_detail/citizenship/other
		),
		/decl/background_category/heritage =   list(
			/decl/background_detail/heritage/vox,
			/decl/background_detail/heritage/vox/salvager,
			/decl/background_detail/heritage/vox/raider
		),
		/decl/background_category/homeworld = list(
			/decl/background_detail/location/vox,
			/decl/background_detail/location/vox/shroud,
			/decl/background_detail/location/vox/ship
		),
		/decl/background_category/faction = list(
			/decl/background_detail/faction/vox,
			/decl/background_detail/faction/vox/raider,
			/decl/background_detail/faction/vox/apex
		),
		/decl/background_category/religion =  list(
			/decl/background_detail/religion/vox
		)
	)
*/

	exertion_effect_chance = 10
	exertion_hydration_scale = 1
	exertion_charge_scale = 1
	exertion_reagent_scale = 1
	exertion_reagent_path = /decl/material/liquid/lactate
	exertion_emotes_biological = list(
		/decl/emote/exertion/biological,
		/decl/emote/exertion/biological/breath,
		/decl/emote/exertion/biological/pant
	)
	exertion_emotes_synthetic = list(
		/decl/emote/exertion/synthetic,
		/decl/emote/exertion/synthetic/creak
	)

/decl/species/vox/equip_survival_gear(var/mob/living/human/H)
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/vox(H), slot_wear_mask_str)
	var/obj/item/backpack/backpack = H.get_equipped_item(slot_back_str)
	if(istype(backpack))
		H.equip_to_slot_or_del(new /obj/item/box/vox(backpack), slot_in_backpack_str)
		var/obj/item/tank/nitrogen/tank = new(H)
		H.equip_to_slot_or_del(tank, BP_R_HAND)
		if(tank)
			H.set_internals(tank)
	else
		H.equip_to_slot_or_del(new /obj/item/tank/nitrogen(H), slot_back_str)
		H.equip_to_slot_or_del(new /obj/item/box/vox(H), BP_R_HAND)
		H.set_internals(backpack)

// Ideally this would all be on bodytype, but pressure is handled per-mob currently.
var/global/list/vox_current_pressure_toggle = list()

/decl/species/vox/disfigure_msg(var/mob/living/human/H)
	var/decl/pronouns/pronouns = H.get_pronouns()
	return SPAN_DANGER("[pronouns.His] beak-segments are cracked and chipped beyond recognition!\n")

/decl/species/vox/skills_from_age(age)
	. = 8

/decl/species/vox/handle_death(var/mob/living/human/H)
	..()
	var/obj/item/organ/internal/voxstack/stack = H.get_organ(BP_STACK, /obj/item/organ/internal/voxstack)
	if (stack)
		stack.do_backup()

/decl/emote/audible/vox_shriek
	key = "shriek"
	emote_message_3p = "$USER$ SHRIEKS!"
	emote_sound = 'mods/species/vox/sounds/shriek1.ogg'

/decl/species/vox/get_warning_low_pressure(var/mob/living/human/H)
	if(H && global.vox_current_pressure_toggle["\ref[H]"])
		return 50
	return ..()

/decl/species/vox/get_hazard_low_pressure(var/mob/living/human/H)
	if(H && global.vox_current_pressure_toggle["\ref[H]"])
		return 0
	return ..()

/mob/living/human/proc/toggle_vox_pressure_seal()
	set name = "Toggle Vox Pressure Seal"
	set category = "Abilities"
	set src = usr

	if(!istype(species, /decl/species/vox))
		verbs -= /mob/living/human/proc/toggle_vox_pressure_seal
		return

	if(incapacitated(INCAPACITATION_KNOCKOUT))
		to_chat(src, SPAN_WARNING("You are in no state to do that."))
		return

	var/decl/pronouns/pronouns = get_pronouns()
	visible_message(SPAN_NOTICE("\The [src] begins flexing and realigning [pronouns.his] scaling..."))
	if(!do_after(src, 2 SECONDS, src, FALSE))
		visible_message(
			SPAN_NOTICE("\The [src] ceases adjusting [pronouns.his] scaling."),
			self_message = SPAN_WARNING("You must remain still to seal or unseal your scaling."))
		return

	if(incapacitated(INCAPACITATION_KNOCKOUT))
		to_chat(src, SPAN_WARNING("You are in no state to do that."))
		return

	// TODO: maybe add cold and heat thresholds to this.
	var/my_ref = "\ref[src]"
	if((global.vox_current_pressure_toggle[my_ref] = !global.vox_current_pressure_toggle[my_ref]))
		visible_message(
			SPAN_NOTICE("\The [src]'s scaling flattens and smooths out."),
			self_message = SPAN_NOTICE("You flatten your scaling and inflate internal bladders, protecting yourself against low pressure at the cost of dexterity.")
		)
	else
		visible_message(
			SPAN_NOTICE("\The [src]'s scaling bristles roughly."),
			self_message = SPAN_NOTICE("You bristle your scaling and deflate your internal bladders, restoring mobility but leaving yourself vulnerable to low pressure.")
		)
