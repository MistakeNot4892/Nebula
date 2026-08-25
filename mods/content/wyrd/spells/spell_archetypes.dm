// Handles all effects associated with a spell.
/decl/wyrd_archetype
	abstract_type = /decl/wyrd_archetype
	var/name
	var/decl/wyrd_effect/base_effect
	var/list/variants

/decl/wyrd_archetype/Initialize()
	variants = decls_repository.get_decls_unassociated(variants)
	base_effect = GET_DECL(base_effect)
	name = base_effect.name
	return ..()

/decl/wyrd_archetype/proc/has_effect_type(effect_type)
	return TRUE

/decl/wyrd_archetype/proc/get_variants(mob/user, obj/item/implement)
	// TODO: skill/trait/mind checks on user
	return variants

/decl/wyrd_archetype/flash
	base_effect = /decl/wyrd_effect/flash
	variants = list(
		/decl/wyrd_effect/gloom
	)

/decl/wyrd_archetype/flare
	base_effect = /decl/wyrd_effect/flare
