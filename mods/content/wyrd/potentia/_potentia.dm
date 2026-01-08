// Potentia:
// - Purified/degenerate energy extracted or processed from anima (Novu Uso).
// - 'I cast Fireball' -> fire and air potentia expended
// - 'rune of greater flood' -> etched onto crystalline water potentia

/decl/material/solid/potentia
	name                         = "potentia"
	solid_name                   = "crystalline potentia"
	uid                          = "mat_potentia"
	opacity                      = 0.7
	color                        = COLOR_GRAY40
	abstract_type                = /decl/material/solid/potentia
	uid                          = "mat_potentia_generic"
	var/potentia_type            = "unaspected"
	var/runestone_glow_intensity = 0.3
	/// Simple spells that can be scribed onto runestones or cast on the fly.
	var/list/cantrips
	/// Spell used when a blank is cracked.
	var/decl/wyrd_archetype/undirected_spell
	/// Skill used for general spell knowledge.
	var/arcana_skill = SKILL_SCIENCE // TODO: arcana or magic skill

/decl/material/solid/potentia/Initialize()
	name        = "[potentia_type] potentia"
	solid_name  = "crystalline [potentia_type] potentia"
	liquid_name = "molten [potentia_type] potentia"
	gas_name    = "gaseous [potentia_type] potentia"
	for(var/spell in cantrips)
		cantrips -= spell
		cantrips |= GET_DECL(spell)
	undirected_spell = GET_DECL(undirected_spell)
	return ..()

/decl/material/solid/potentia/proc/get_spells()
	return list()

/decl/material/solid/potentia/proc/get_cantrips_by_effect_type(mob/user, effect_type)
	// TODO: check arcana_skill on user
	for(var/decl/wyrd_archetype/cantrip in cantrips)
		if(cantrip.has_effect_type(effect_type))
			LAZYDISTINCTADD(., cantrip)

/decl/material/solid/potentia/fire
	potentia_type            = "fire"
	color                    = COLOR_ORANGE
	runestone_glow_intensity = 0.6
	cantrips                 = list(
		/decl/wyrd_archetype/flash,
		/decl/wyrd_archetype/flare
	)
	undirected_spell = /decl/wyrd_archetype/flare
	uid = "mat_potentia_fire"
