var/global/list/_wyrd_spell_effect_types = list(
	"area of effect" = /decl/wyrd_effect::WYRD_AOE,
	"close-range"    = /decl/wyrd_effect::WYRD_MELEE,
	"long-range"     = /decl/wyrd_effect::WYRD_RANGED
)

/datum/wyrd_working
	var/effect_type = /decl/wyrd_effect::WYRD_AOE
	var/effect_strength = 1
	var/decl/wyrd_archetype/spell_master
	var/decl/wyrd_effect/variant

/datum/wyrd_working/New(_effect)
	effect_type = _effect