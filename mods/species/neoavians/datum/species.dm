/datum/appearance_descriptor/age/neoavian
	chargen_min_index = 3
	chargen_max_index = 6
	standalone_value_descriptors = list(
		"a hatchling" =     1,
		"an fledgeling" =   6,
		"a young adult" =  12,
		"an adult" =       25,
		"middle-aged" =    35,
		"aging" =          45,
		"elderly" =        50
	)

/decl/butchery_data/humanoid/avian
	meat_name = "chicken"
	meat_type = /obj/item/food/butchery/meat/chicken

/decl/species/neoavian
	uid = "species_avian"
	name = "Runner"
	name_plural = "Runners"

	description = \
	"There are a variety of Earth-originating avian species on the Plate, largely corvid uplifts, gene-edited raptor throwbacks, or other engineered populations. Most of them arrived along with their unfortunate human sponsors or owners, but due to the frequently shorter generations of these species, many others are Plate-born and have never known a life outside of the Ring. \
	<br><br> \
	Runners are, as the name implies, very fast; their wings are too small to do more than glide, but they are lightweight and flexible, capable of easily outpacing a human over short distances. However, they are fragile and very susceptible to physical harm."

	codex_description = \
	"Also commonly known as: neo-avians, post-saurians, raptors, birds. \
	<br><br> \
	Neo-avians and post-raptor species can trace their roots back centuries, originating with uplift and genetic engineering projects on Old Earth. Back in the day, their forebears were developed as experiments in low-oxygen, low-calorie workers in microgravity, or in some cases (like the post-raptor dinosaur gene-lines) just as scientific curiosities or luxury pets. There's a lot of resentment amongst some runner populations as a reuslt of this, but with population and resource levels being what they are on the Plate, most human and runner groups tolerate each other. \
	<br><br> \
	On the Plate, runners often find work as couriers or scouts. They have a tendency to form close-knit packs or flocks; more than a few unfortunate drifters have put the boot into an annoying crow and been immediately jumped by his seven friends lurking nearby."

	roleplay_summary = \
	"<ul> \
	<li>Runners as a whole have an independent streak and often a bit of small dog syndrome; they will be aggressive and confrontational if they feel they are being spoken down to or treated like children. \
	<li>Runners are cautious and flighty as a result of their rapid metabolisms and physical frailty. They tend to be vocal, with chirps, hisses, trills and caws commonly used in conversation.</li> \
	<li>The flock/pack (either literal family, or just the people the runner lives and works with) is extremely important to neo-avians. Selfishness isn't unheard of, but the general mindset tends heavily towards being community-minded.</li> \
	<li>Runners, as bird/reptile-analagous creatures, don't have very mobile faces. Angle of head, bristling of feathers, tail position and general posture are used to convey tone and mood rather than facial expressions.</li> \
	</ul>"

	ooc_codex_information = \
	"<ul> \
	<li>Runners have very low total health and take 20% additional damage from brute trauma due to fragile bones.</li> \
	<li>Runners move significantly faster than humans and are small mobs, allowing them to be picked up/climb onto larger mobs.</li> \
	</ul>"
//	<li>Although they can't fly, runners can avoid damage from falling off cliffs or down elevators by gliding down, but only if their wings are unbroken, and unoccupied by restrictive clothing.</li>


	base_external_prosthetics_model = /decl/bodytype/prosthetic/avian
	base_internal_prosthetics_model = /decl/bodytype/prosthetic/avian

	snow_slowdown_mod = -1

	holder_icon = 'mods/species/neoavians/icons/holder.dmi'

	butchery_data = /decl/butchery_data/humanoid/avian

	preview_outfit = /decl/outfit/job/ringdown/guild_runner

	available_bodytypes = list(
		/decl/bodytype/avian,
		/decl/bodytype/avian/additive,
		/decl/bodytype/avian/raptor,
		/decl/bodytype/avian/additive/raptor
	)

	total_health = 120
	holder_type = /obj/item/holder
	gluttonous = GLUT_TINY
	blood_volume = 320
	hunger_factor = DEFAULT_HUNGER_FACTOR * 1.6
	thirst_factor = DEFAULT_THIRST_FACTOR * 1.6

	spawn_flags = SPECIES_CAN_JOIN
	bump_flag = MONKEY
	swap_flags = MONKEY|SIMPLE_ANIMAL
	push_flags = MONKEY|SIMPLE_ANIMAL

	available_background_info = list(
		/decl/background_category/heritage = list(
			/decl/background_detail/heritage/neoavian,
			/decl/background_detail/heritage/neoavian/saurian,
			/decl/background_detail/heritage/other
		)
	)

/decl/species/neoavian/equip_default_fallback_uniform(var/mob/living/human/H)
	if(istype(H))
		H.equip_to_slot_or_del(new /obj/item/clothing/dress/avian_smock/worker, slot_w_uniform_str)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/avian, slot_shoes_str)

/decl/species/neoavian/get_holder_color(var/mob/living/human/H)
	return H.get_skin_colour()

/decl/outfit/job/generic/assistant/avian
	name = "Job - Avian Assistant"
	uniform = /obj/item/clothing/dress/avian_smock/worker
	shoes = /obj/item/clothing/shoes/avian/footwraps
