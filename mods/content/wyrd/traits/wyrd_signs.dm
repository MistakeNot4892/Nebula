/decl/trait/wyrd
	var/alist/modify_personal_anima = alist()

/decl/trait/wyrd/apply_trait(mob/living/holder)
	. = ..()
	for(var/anima_type,anima_amount in modify_personal_anima)
		holder.adjust_personal_anima(anima_type, anima_amount)

/decl/trait/wyrd/fire
	name = "Burning Sign"
	description = "Affinity for the New School of alchemical working (energy, force, fire, lightning). TODO."
	incompatible_with = list(
		/decl/trait/wyrd/deep,
		/decl/trait/wyrd/sky,
		/decl/trait/wyrd/flesh,
		/decl/trait/wyrd/waning
	)
	modify_personal_anima = alist(
		/decl/anima/blood = /decl/anima::ANIMA_NOTABLE
	)
	uid = "trait_wyrd_flame"

/decl/trait/wyrd/sky
	name = "Sky Sign"
	description = "Affinity for the sun, moon and stars, cold, air, wind, light, sky. Associated with the magical traditions of the Steppe and Nine Mothers. TODO."
	incompatible_with = list(
		/decl/trait/wyrd/deep,
		/decl/trait/wyrd/fire,
		/decl/trait/wyrd/flesh,
		/decl/trait/wyrd/waning
	)
	modify_personal_anima = alist(
		/decl/anima/sky = /decl/anima::ANIMA_NOTABLE
	)
	uid = "trait_wyrd_sky"

/decl/trait/wyrd/deep
	name = "Hollow Sign"
	description = "Affinity for stone, darkness, the depths, the earth. Associated with the magical traditions of kobaloi and dvergr. TODO."
	incompatible_with = list(
		/decl/trait/wyrd/sky,
		/decl/trait/wyrd/fire,
		/decl/trait/wyrd/flesh,
		/decl/trait/wyrd/waning
	)
	modify_personal_anima = alist(
		/decl/anima/deep = /decl/anima::ANIMA_NOTABLE
	)
	uid = "trait_wyrd_hollow"

/decl/trait/wyrd/waning
	name = "Moon Sign"
	description = "Affinity for twilight, transience, change. TODO."
	incompatible_with = list(
		/decl/trait/wyrd/sky,
		/decl/trait/wyrd/fire,
		/decl/trait/wyrd/flesh,
		/decl/trait/wyrd/deep
	)
	modify_personal_anima = alist(
		/decl/anima/waning = /decl/anima::ANIMA_NOTABLE
	)
	uid = "trait_wyrd_moon"

/decl/trait/wyrd/flesh
	name = "Rose Sign"
	description = "Affinity for blood, flesh, bone - healing, necromancy, blood alchemy, manipulation of living material. TODO."
	incompatible_with = list(
		/decl/trait/wyrd/sky,
		/decl/trait/wyrd/fire,
		/decl/trait/wyrd/deep,
		/decl/trait/wyrd/waning
	)
	modify_personal_anima = alist(
		/decl/anima/blood  = /decl/anima::ANIMA_NEGLIGIBLE,
		/decl/anima/waning = /decl/anima::ANIMA_NEGLIGIBLE
	)
	uid = "trait_wyrd_flesh"
