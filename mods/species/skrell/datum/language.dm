/decl/language/skrell
	name = LANGUAGE_SKRELL
	desc = "A melodic and complex language spoken by the Skrell of Qerrbalak. Some of the notes are inaudible to humans."
	speech_verb = "warbles"
	ask_verb = "warbles"
	exclaim_verb = "warbles"
	colour = "skrell"
	key = "k"
	flags = WHITELISTED
	syllables = list("qr","qrr","xuq","qil","quum","xuqm","vol","xrim","zaoo","qu-uu","qix","qoo","zix","*","!")
	shorthand = "SK"

/decl/language/skrell/get_random_name()
	return capitalize(pick("Xar","Quil","Qur'qa","Zirqa","Kol'xa","Zel","Qaraza")) + " " + capitalize(pick("Qala","Zeraka","Zaq'qa","Xer'za","Ve'qa"))
