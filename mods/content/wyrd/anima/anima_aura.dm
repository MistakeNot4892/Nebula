// Inner anima state used for spellcasting.
/datum/extension/anima_aura
	expected_type = /mob
	base_type = /datum/extension/anima_aura
	var/alist/pool

/datum/extension/anima_aura/proc/update_totals()
	return

/mob/proc/get_personal_anima(anima_type)
	var/alist/pool = get_personal_anima_pool()
	var/decl/anima/anima = RESOLVE_TO_DECL(anima_type)
	return (istype(pool) && pool[anima.type]) || /decl/anima::ANIMA_DEPLETED

/mob/proc/get_personal_anima_pool()
	var/datum/extension/anima_aura/aura = get_extension(src, /datum/extension/anima_aura)
	if(aura)
		return aura.pool?.Copy()
	return alist(
		/decl/anima/sky    = /decl/anima::ANIMA_DEPLETED,
		/decl/anima/waning = /decl/anima::ANIMA_DEPLETED,
		/decl/anima/deep = /decl/anima::ANIMA_DEPLETED,
		/decl/anima/blood  = /decl/anima::ANIMA_DEPLETED
	)

/mob/proc/adjust_personal_anima(anima_type, anima_amount, skip_update = FALSE)
	return set_personal_anima(anima_type, get_personal_anima(anima_type) + anima_amount, skip_update)

/mob/proc/set_personal_anima(anima_type, anima_amount, skip_update = FALSE)
	var/datum/extension/anima_aura/aura = (anima_amount == /decl/anima::ANIMA_DEPLETED) ? get_extension(src, /datum/extension/anima_aura) : get_or_create_extension(src, /datum/extension/anima_aura)
	if(!istype(aura) || anima_amount == get_personal_anima(anima_type))
		return FALSE
	var/decl/anima/anima = RESOLVE_TO_DECL(anima_type)
	if(anima_amount == 0)
		LAZYREMOVE(aura.pool, anima.type)
	else
		LAZYSET(aura.pool, anima.type, anima_amount)
	if(!skip_update)
		aura.update_totals()
	return TRUE
