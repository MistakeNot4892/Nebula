// Anima system: radiant energy or potential of your current location.
// Influenced by natural background levels (based on area) and other sources (that may move around)
// TODO: temporary/decaying radiant anima resulting from spells cast in a location.
// TODO: visual effects for very high anima in an area/on a turf.

// Anima:
// - Very broad categories of magical energy.
// - Influences things within the area of effect (high levels of water anima/low levels of fire anima -> harder to light things on fire).
// - Modifies the chances of spellcasting in the area of effect (high levels of sky anima makes air spells easier).
// - Higher or lower intensities associated with entities/areas.
// - Has an associated subset of potentia that can be refined from local anima (sky sign -> air and water anima, etc)

// Local events that create temporary powerful anima sources:
//  - sacrificing an animal spikes waning and blood anima in the immediate vicinity to boost/enable particular workings
//  - burning incense, taking drugs, scribing a circle

// Process notes:
// 1. mob wants to cast a spell
// 2. retrieve local anima (turf + area)
// 3. retrieve personal anima (aura extension)
//   a. effective anima - local anima +/- (personal anima * strength of will)
//   b. very high will + personal anima can override local anima
// 4. retrieve spellcasting condition of the mob
//   a. stressors mean poor spellcasting focus
//   b. nutrition/stamina are needed for fuelling the spell
// 4. if anima state or conditions do not allow spell, fizzles
// 5. spellcaster's personal aura and will are applied agains the target's personal aura/will (for mobs) or just ambient anima for inanimate objects
// 6. effect of spell is scaled based on how much stronger (or more effectively aligned) the spellcaster is

/decl/anima
	abstract_type = /decl/anima
	decl_flags = DECL_FLAG_MANDATORY_UID
	var/name

	var/const/ANIMA_DEPLETED   = 0
	var/const/ANIMA_NEGLIGIBLE = 1
	var/const/ANIMA_NOTABLE    = 2
	var/const/ANIMA_DENSE      = 3
	var/const/ANIMA_RICH       = 4
	var/const/ANIMA_SATURATED  = 5

/decl/anima/proc/get_personal_anima_description(_density, decl/background_detail/_culture)
	return _culture.get_personal_anima_description(src, _density)

/decl/anima/proc/get_ambient_anima_description(_density, decl/background_detail/_culture)
	return _culture.get_ambient_anima_description(src, _density)

// burning sign: label for potentia-based spellcasting, not a 'real' type of anima
// wild sign: complex category of workings, not a specific single type of anima

/decl/anima/sky
	name = "Sky"
	uid = "anima_sky"
	// air, stars, moon, truth, purity

/decl/anima/waning
	name = "Waning"
	uid = "anima_waning"
	// transition, change, death, birth

/decl/anima/deep
	name = "Deep"
	uid = "anima_deep"
	// concealment, earth, mystery

/decl/anima/blood
	name = "Blood"
	uid = "anima_blood"
	// growth, life, heat, violence
	// source of volatile potentia - fire, mania

/decl/anima/breath
	name = "Breath"
	uid = "anima_breath"
	// growth, life, heat, violence
	// source of volatile potentia - fire, mania
