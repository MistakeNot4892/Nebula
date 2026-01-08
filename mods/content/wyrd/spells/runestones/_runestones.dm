/obj/item/runestone
	name = "runestone"
	desc = "An etched, faceted round of crystallised magic, scribed with a complex rune. Shatter the runestone to evoke the spell scribed upon it."
	icon = 'mods/content/wyrd/icons/runestone_basic.dmi'
	icon_state = ICON_STATE_WORLD
	material = /decl/material/solid/potentia
	w_class = ITEM_SIZE_SMALL
	material_alteration = MAT_FLAG_ALTERATION_COLOR | MAT_FLAG_ALTERATION_DESC

	var/work_skill = SKILL_CONSTRUCTION
	var/work_tool  = TOOL_SCALPEL // TODO: TOOL_CHISEL
	var/potentia_density = 1
	var/cracked = FALSE
	var/datum/wyrd_working/stored_spell

	var/static/list/potentia_density_labels = list(
		'mods/content/wyrd/icons/runestone_basic.dmi'   = "basic",
		'mods/content/wyrd/icons/runestone_layered.dmi' = "layered",
		'mods/content/wyrd/icons/runestone_gilded.dmi'  = "gilded"
	)

/obj/item/runestone/Initialize()
	. = ..()
	update_strings()

/obj/item/runestone/proc/update_strings()
	update_icon()
	var/list/new_name = list()
	if(cracked)
		new_name += "cracked"
	new_name += potentia_density_labels[icon]
	var/decl/material/solid/potentia/potentia = material
	new_name += istype(potentia) ? potentia.potentia_type : "unaspected"
	new_name += initial(name)
	if(stored_spell)
		if(stored_spell.spell_master)
			new_name += "of"
			if(stored_spell.variant)
				new_name += stored_spell.variant.name
			else
				new_name += stored_spell.spell_master.name
		else
			new_name.Insert(1, "partially etched")
	SetName(jointext(new_name, " "))

/obj/item/runestone/attackby(obj/item/W, mob/user)

	if(W.get_attack_force() && user.check_intent(I_FLAG_HARM))
		user.visible_message("\The [user] brings \the [W] down on \the [src]!")
		crack_runestone(user)
		return TRUE

	if(try_scribe_spell(user, W))
		return TRUE

	if(istype(W, /obj/item/stack/material/potentia) && W.material)

		if(W.material.type != material.type)
			to_chat(user, SPAN_WARNING("\The [src] is made of [material], not [W.material]."))
			return TRUE

		if(potentia_density >= length(potentia_density_labels))
			to_chat(user, SPAN_WARNING("\The [src] is as pure and dense as it can be without shattering."))
			return TRUE

		var/obj/item/stack/material/potentia/potentia = W
		if(potentia.get_amount() < potentia_density)
			to_chat(user, SPAN_WARNING("You need at least [potentia_density] blank\s to refine \the [src] further."))
			return TRUE

		if(work_skill)
			if(!user.do_skilled((2 SECONDS) + (potentia_density SECONDS), work_skill, src, check_holding = TRUE))
				return TRUE
			// Repeat a bunch of checks due to the time delay.
			if(QDELETED(src) || QDELETED(potentia) || potentia.loc != user || potentia.get_amount() < potentia_density)
				return TRUE
			if(potentia_density >= length(potentia_density_labels) || !potentia.material?.type || material?.type != potentia.material?.type)
				return TRUE

		if(potentia.use(potentia_density))
			to_chat(user, SPAN_NOTICE("You fold [potentia_density] blank\s into \the [src], increasing its potency."))
			potentia_density++
			update_strings()

		return TRUE

	return ..()

/obj/item/runestone/attack_self(mob/user)
	if(cracked)
		return ..()
	// Crack the runestone...
	crack_runestone(user, TRUE)
	return TRUE

/obj/item/runestone/physically_destroyed(skip_qdel)
	crack_runestone()
	return ..(skip_qdel = (skip_qdel || QDELETED(src)))

/obj/item/runestone/proc/crack_runestone(mob/user, deliberate)

	cracked = TRUE
	if(user && deliberate)
		user.visible_message(SPAN_DANGER("\The [user] cracks \a [src] in [user.get_pronouns()?.his || "their"] [parse_zone(user.get_active_held_item_slot())]!"))
	else
		loc?.visible_message(SPAN_DANGER("\The [src] cracks with a loud pop!"))

	// Incomplete runestones or AOE spells are activated immediately.
	if(!stored_spell?.spell_master)
		var/decl/material/solid/potentia/potentia = material
		if(istype(potentia) && potentia.undirected_spell?.base_effect)
			potentia.undirected_spell.base_effect.evoke_spell(user, get_turf(user), null, deliberate = deliberate)
		else
			new /obj/item/shard(get_turf(user), material?.type)
		qdel(src)
		return TRUE

	var/decl/wyrd_effect/casting_spell = stored_spell.variant || stored_spell.spell_master.base_effect
	if(casting_spell)
		if(stored_spell.effect_type == /decl/wyrd_effect::WYRD_AOE)
			casting_spell.evoke_spell(user, get_turf(user), src)
			qdel(src)
			return TRUE
		to_chat(user, casting_spell.show_runestone_primed_message(user, src))

	update_strings()
	return TRUE

/obj/item/runestone/use_on_mob(mob/living/target, mob/living/user, animate = TRUE)
	return cracked ? FALSE : ..()

/obj/item/runestone/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	var/decl/wyrd_effect/casting_spell = cracked && stored_spell && (stored_spell.variant || stored_spell.spell_master.base_effect)
	if(casting_spell)
		casting_spell.evoke_spell(user, target, src, in_proximity = proximity_flag)
		return TRUE
	return ..()

/obj/item/runestone/fire
	material = /decl/material/solid/potentia/fire

/obj/item/runestone/adjust_mob_overlay(mob/living/user_mob, bodytype, image/overlay, slot, bodypart, use_fallback_if_icon_missing = TRUE)
	if(overlay && cracked && istype(material, /decl/material/solid/potentia))
		var/check_state = "[overlay.icon_state]-glow"
		if(check_state_in_icon(check_state, overlay.icon))
			var/decl/material/solid/potentia/potentia_mat = material
			var/image/I = image(overlay.icon, check_state)
			I.alpha = 255 * potentia_mat.runestone_glow_intensity
			I.appearance_flags |= RESET_ALPHA
			overlay.overlays += I
	return ..()

/obj/item/runestone/on_update_icon()
	. = ..()

	var/new_icon = potentia_density_labels[potentia_density]
	if(icon != new_icon)
		icon = new_icon

	icon_state = get_world_inventory_state()
	if(cracked)
		icon_state = "[icon_state]-cracked"
		if(istype(material, /decl/material/solid/potentia))
			var/decl/material/solid/potentia/potentia_mat = material
			var/image/I = image(icon, "[icon_state]-glow")
			I.alpha = 255 * potentia_mat.runestone_glow_intensity
			I.appearance_flags |= RESET_ALPHA
			add_overlay(I)
			compile_overlays()
	else if(stored_spell)
		if(stored_spell.variant)
			icon_state = "[icon_state]-etched"
		else if(stored_spell.effect_type)
			icon_state = "[icon_state]-complex"

	update_clothing_icon()
