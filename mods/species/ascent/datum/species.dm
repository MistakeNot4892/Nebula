/datum/appearance_descriptor/age/kharmaani
	chargen_min_index = 3
	chargen_max_index = 6
	standalone_value_descriptors = list(
		"a larva" =         1,
		"a nymph" =         2,
		"a juvenile" =      3,
		"an adolescent" =   5,
		"a young adult" =  12,
		"a full adult" =   30,
		"a matriarch" =    45,
		"a queen" =        60,
		"an imperatrix" = 150,
		"a crone" =       500
	)

/datum/appearance_descriptor/age/kharmaani/gyne
	chargen_min_index = 5
	chargen_max_index = 9

/decl/blood_type/hemolymph/mantid
	name = "crystalline ichor"
	antigens = list("Hc") // hemocyanin, more of an octopus thing than a bug thing but whatever, it sounds neat
	splatter_colour = "#660066"

/decl/species/mantid
	uid =                    "species_mantid_alate"
	name =                   "Mantid"
	name_plural =            "Mantids"
	show_ssd =               "quiescent"
	hidden_from_codex =      TRUE
	base_external_prosthetics_model = null
	available_bodytypes = list(/decl/bodytype/crystalline/mantid/alate)
	preview_outfit = /decl/outfit/job/ringdown/brood_auxillary

/*
- Mantids need rare earths and trace metals for their tech (or crystalline silicates?), which mainly come from valuable ringworld salvage or preserved higher tech.
- Dealate wing removal/gelding should be a surgical operation a la docking.
*/
	description = \
	"The handful of surviving mantid nests dug deep into the crust of the Ring are largely composed of teeming masses of dealates, surgically dewinged and gelded to cement their loyalty to their queen. Quick and vicious, they make excellent soldiers, pilots and technicians for the massive, narcisstic gynes that birth and rule them. Their technology is far away the most advanced on the Plate, but they suffer from a lack of the refined resources need to maintain their existing equipment, let alone build more. \
	<br><br> \
	Mantids are known for the razor-sharp webs they use to defend their nests, and their crystalline bodies and glowing eyes make them distinctive when they deign to venture into the outside world. Although most of those seen by outsiders are dealates, the occasional viable alate will escape the wrath of their mother and set out to found their own nest in the dust wastes."

	codex_description = \
	"Also commonly known as: veiled, tunnellers, nesters. \
	<br><br> \
	The mantids you might see around the Plate are survivors from a handful of colony ships and cutters that have crashed on the Ring over the years. Their society outside the Ring is/was a heavily mechanized stellar empire, and their settlements are organized around a small number of queens (gynes) ruling hundreds of drones (dealates). Their surviving tech and fabrication systems put them head and shoulders above anyone else on the Plate when it comes ot manufacturing and maintaining spacer tech like energy weapons and nano-medical packs. They even have a large population of human-level artificial intelligences, who they accord citizen rights and use to run their logistics. \
	<br><br> \
	Unlike a lot of settlements, the mantids have managed to preserve most of their old culture; they burrowed into the Ring, co-opted the superstructure, and piece by piece transferred their ships under the surface. Their bizarre reproductive cycle involves the males being permanently incorporated into the female's body as a source of genetic material, so a single surviving gyne from a caulship was more than enough to establish a thriving nest. \
	<br><br> \
	While the mantids aren't warlike or overly hostile, they make terrible neighbors. All non-mantid life is 'primitive' and they don't care at all if their building or mining projects interfere with a local settlement. Just about the only thing that will get their attention is rare earth metals or other refined resources, which they desperately need to keep their technology running. They'll even outfit non-mantids who join their 'brood auxillaries' in exchange for sufficient tithes of raw materials."

	roleplay_summary = \
	"<ul> \
	<li>Mantid dealates are not stupid, but they are extremely single-minded and focused. Their primary loyalty is to their gyne, then to their brood/nest, and only then to anyone or anything else.</li> \
	<li>Mantids are arrogant and insular. They will deal with 'primitives' but they will rarely respect them or take orders from them.</li> \
	<li>The closest thing mantids have to religion is worship of the queens as a spiritual extension of their territory; by extension, gynes view themselves as absolute authorities, and a reproductively viable alate who has not been dewinged or gelded commands a lot of sway among dealates.</li> \
	</ul>"

	ooc_codex_information = \
	"<ul> \
	<li>If a mantid can get enough silica in their diet, they can spin razorwebs as traps. These are extremely sharp and dangerous.</li> \
	<li>Mantids breathe methyl bromide instead of oxygen; they will suffocate in human spaces, and humans will be poisoned in their spaces.</li> \
	<li>Crystalline bodies mean that mantids are very resistant to laser weapons, but they are vulnerable to brute damage and require specialized equipment to heal and for surgery.</li> \
	<li>An ungelded alate has the potential to molt into a gyne, if they can eat enough appropriate minerals, and find a particular form of specialized machinery.</li> \
	</ul>"

	organs_icon =       'mods/species/ascent/icons/species/body/organs.dmi'

	flesh_color =             "#009999"
	move_trail =              /obj/effect/decal/cleanable/blood/tracks/snake

	blood_types = list(/decl/blood_type/hemolymph/mantid)

	speech_chance = 100
	speech_sounds = list(
		'mods/species/ascent/sounds/ascent1.ogg',
		'mods/species/ascent/sounds/ascent2.ogg',
		'mods/species/ascent/sounds/ascent3.ogg',
		'mods/species/ascent/sounds/ascent4.ogg',
		'mods/species/ascent/sounds/ascent5.ogg',
		'mods/species/ascent/sounds/ascent6.ogg'
	)

	shock_vulnerability =   0.2 // Crystalline body.
	oxy_mod =               0.8 // Don't need as much breathable gas as humans.
	toxins_mod =            0.8 // Not as biologically fragile as meatboys.
	radiation_mod =         0.5 // Not as biologically fragile as meatboys.

	rarity_value =            3
	gluttonous =              2
	body_temperature =        null

	breath_type =             /decl/material/gas/methyl_bromide
	exhale_type =             /decl/material/gas/methane
	poison_types =            list(/decl/material/gas/chlorine = TRUE)

	available_pronouns = list(/decl/pronouns/male)

	species_flags =           SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_MINOR_CUT
	spawn_flags =             SPECIES_CAN_JOIN

	/*
	force_background_info = list(
		/decl/background_category/citizenship = /decl/background_detail/citizenship/other,
		/decl/background_category/heritage    = /decl/background_detail/heritage/ascent,
		/decl/background_category/homeworld   = /decl/background_detail/location/kharmaani,
		/decl/background_category/faction     = /decl/background_detail/faction/ascent_alate,
		/decl/background_category/religion    = /decl/background_detail/religion/kharmaani
	)
	*/

	pain_emotes_with_pain_level = list(
			list(/decl/emote/visible/ascent_shine, /decl/emote/visible/ascent_dazzle) = 80,
			list(/decl/emote/visible/ascent_glimmer, /decl/emote/visible/ascent_pulse) = 50,
			list(/decl/emote/visible/ascent_flicker, /decl/emote/visible/ascent_glint) = 20,
		)

/decl/species/mantid/handle_sleeping(var/mob/living/human/H)
	return

/decl/species/mantid/equip_survival_gear(var/mob/living/human/H, var/extendedtank = 1)
	return

/decl/species/mantid/gyne
	uid =         "species_mantid_gyne"
	name =        "Mantid Gyne"
	name_plural = "Mantid Gynes"

	spawn_flags = SPECIES_IS_RESTRICTED

	available_bodytypes = list(/decl/bodytype/crystalline/mantid/gyne)
	available_pronouns = list(/decl/pronouns/female)

	gluttonous =              3
	rarity_value =           10

	blood_volume =         1200

	bump_flag =               HEAVY
	push_flags =              ALLMOBS
	swap_flags =              ALLMOBS

	force_background_info = list(
		/decl/background_category/citizenship = /decl/background_detail/citizenship/other,
		/decl/background_category/heritage    = /decl/background_detail/heritage/ascent,
		/decl/background_category/homeworld   = /decl/background_detail/location/kharmaani,
		/decl/background_category/faction     = /decl/background_detail/faction/ascent_gyne,
		/decl/background_category/religion    = /decl/background_detail/religion/kharmaani
	)
