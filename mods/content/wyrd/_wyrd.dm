/decl/modpack/wyrd
	name = "Pyrelight Magic Content"
	credits_topics = list("ANCIENT MAGIC", "ANCIENT ANIMA", "MAGICAL RITUALS", "MAGIC SPELLS")
	credits_nouns = list("MAGIC", "ANIMA", "WYRD")
	credits_adjectives = list("ANCIENT", "MAGICAL", "ARCANE", "DIVINE", "BEWITCHED", "ENCHANTED")
	credits_crew_outcomes = list("BEWITCHED", "ENCHANTED", "MAGICKED", "CURSED")
	dreams = list(
		"wyrd", "anima", "potentia", "magic", "an ancient curse", "an arcane ritual",
		"a magic spell", "a magician", "a wizard", "a witch",
		"a necromancer", "an ancient scroll", "a magic crystal"
	)

/*
	Notes to self on my own system structure:
	- A spell as a concept is /decl/wyrd_archetype
	- Archetype provides /decl/wyrd_effect for basic effect, metamagic effect, etc.
	- /decl/wyrd_effect is the specific mechanical interaction when the spell is cast.
	- /datum/wyrd_working is a temporary holder for a /decl/wyrd_effect and /decl/wyrd_archetype as well as cast strength and cast mode (AOE, single target, etc)
*/