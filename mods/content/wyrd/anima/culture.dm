/decl/background_detail
	var/anima_failed_working_insufficient_1p = SPAN_WARNING("The skein here is too thin to weave $SPELL$!")
	var/anima_failed_working_excess_1p       = SPAN_WARNING("The skein here churns too violently to weave $SPELL$!")
	var/anima_failed_exhaustion_1p           = SPAN_WARNING("You are too exhausted to weave $SPELL$.")

// Plan here is that specific cultures can have different interpretations of different anima.
/decl/background_detail/proc/get_cultural_anima_name(decl/anima/_anima)
	return _anima.name

/decl/background_detail/proc/get_personal_anima_description(decl/anima/_anima, _density)
	var/anima_name = get_cultural_anima_name(_anima)
	switch(_density)
		if(/decl/anima::ANIMA_DEPLETED)
			return "The [anima_name] cannot be heard within your soul."
		if(/decl/anima::ANIMA_NEGLIGIBLE)
			return "The [anima_name] whispers within your soul."
		if(/decl/anima::ANIMA_NOTABLE)
			return "The [anima_name] hums gently within your soul."
		if(/decl/anima::ANIMA_DENSE)
			return "The [anima_name] fills the vault of your soul."
		if(/decl/anima::ANIMA_RICH)
			return "The [anima_name] sings powerfully within your soul, swelling bright and loud."
		if(/decl/anima::ANIMA_SATURATED)
			return "The [anima_name] colours your entire being with an almost deafening tone."

/decl/background_detail/proc/get_ambient_anima_description(decl/anima/_anima, _density)
	var/anima_name = get_cultural_anima_name(_anima)
	switch(_density)
		if(/decl/anima::ANIMA_DEPLETED)
			return "The [anima_name] is silent here."
		if(/decl/anima::ANIMA_NEGLIGIBLE)
			return "The [anima_name] only whispers here."
		if(/decl/anima::ANIMA_NOTABLE)
			return "The [anima_name] hums and eddies quietly around you."
		if(/decl/anima::ANIMA_DENSE)
			return "The [anima_name] flows steadily all around you."
		if(/decl/anima::ANIMA_RICH)
			return "The [anima_name] suffuses all around you with a powerful song."
		if(/decl/anima::ANIMA_SATURATED)
			return "The [anima_name] thunders here in a continuous deluge."
