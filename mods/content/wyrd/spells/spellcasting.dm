// Use a second ability handler so that spells are categorised separately to general wyrd abilities.
/datum/ability_handler/wyrd_workings
	category_toggle_type = /obj/screen/ability/category/wyrd_workings

/obj/screen/ability/category/wyrd_workings
	name = "Wyrd Workings"
	icon = 'mods/content/wyrd/icons/workings.dmi'

// TODO: condition + skill
/mob/proc/get_wyrd_casting_strength()
	return 1

/decl/ability/wyrd/spell
	abstract_type           = /decl/ability/wyrd/spell
	target_selector         = /decl/ability_targeting/single_atom/can_target_user
	prep_cast               = TRUE
	is_melee_invocation     = TRUE
	is_ranged_invocation    = TRUE
	end_prep_on_cast        = FALSE
	associated_handler_type = /datum/ability_handler/wyrd_workings

	ready_ability_1p_str    = SPAN_NOTICE("You weave potential, preparing yourself to cast $SPELL$.")
	cancel_ability_1p_str   = SPAN_NOTICE("You shake loose the woven energy, abandoning $SPELL$.")
	fail_cast_1p_str        = SPAN_WARNING("Your working unravels!")

	var/decl/wyrd_effect/effect
	var/force_effect_type

/decl/ability/wyrd/spell/prepare_to_cast(mob/user, atom/target, list/metadata, datum/ability_handler/handler)
	if(!(. = ..()))
		return

	var/decl/background_detail/culture = user.get_background_datum(/decl/background_category/faction)
	switch(effect.can_be_worked_at(user, get_turf(target)))
		if(effect.ANIMA_INSUFFICIENT)
			to_chat(user, replacetext(culture.anima_failed_working_insufficient_1p, "$SPELL$", "<b>[effect.name]</b>"))
			return FALSE
		if(effect.ANIMA_OVERSATURATED)
			to_chat(user, replacetext(culture.anima_failed_working_excess_1p, "$SPELL$", "<b>[effect.name]</b>"))
			return FALSE

	if(effect.stamina_cost && user.get_stamina() < effect.stamina_cost)
		to_chat(user, replacetext(culture.anima_failed_exhaustion_1p, "$SPELL$", "<b>[effect.name]</b>"))
		return FALSE

/decl/ability/wyrd/spell/validate()
	. = ..()
	if(!istype(effect, /decl/wyrd_effect))
		. += "missing or malformed effect type: '[effect]'"

/decl/ability/wyrd/spell/Initialize()
	effect = GET_DECL(effect)
	var/effect_name = "<b>[effect.name]</b>"
	ready_ability_1p_str  = replacetext(ready_ability_1p_str, "$SPELL$", effect_name)
	cancel_ability_1p_str = replacetext(cancel_ability_1p_str, "$SPELL$", effect_name)
	. = ..()

/decl/ability/wyrd/spell/apply_ability_effect_to(mob/living/user, atom/target, list/metadata)
	. = ..()
	var/target_self  = (user == target)
	var/proximity    = target_self || (get_dist(user, target) <= 1 && user.Adjacent(target))
	var/range_effect = target_self ? /decl/wyrd_effect::WYRD_AOE : (proximity ? /decl/wyrd_effect::WYRD_MELEE : /decl/wyrd_effect::WYRD_RANGED)
	effect.evoke_spell(user, target, caster_effect = range_effect, caster_strength = user.get_wyrd_casting_strength(), in_proximity = proximity)

/decl/ability/wyrd/spell/flash
	name               = "Flash"
	effect             = /decl/wyrd_effect/flash
	ability_icon_state = "flash"

/decl/ability/wyrd/spell/gloom
	name               = "Gloom"
	effect             = /decl/wyrd_effect/gloom
	ability_icon_state = "gloom"

/decl/ability/wyrd/spell/flare
	name               = "Flare"
	effect             = /decl/wyrd_effect/flare
	ability_icon_state = "flare"
	// don't let people set themselves alight
	target_selector    = /decl/ability_targeting/single_atom
