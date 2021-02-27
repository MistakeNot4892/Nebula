/mob/living/silicon/robot/platform
	name = "support platform"
	desc = "A large quadrupedal AI platform, colloquially known as a 'think-tank' due to the flexible onboard intelligence."
	icon = 'icons/mob/robots_thinktank.dmi'
	icon_state = "tachi"
	color = "#68a2f2"
	module = /obj/item/robot_module/platform
	laws = /datum/ai_laws/paladin
	cell = /obj/item/cell/hyper

	lawupdate = FALSE
	modtype = "Standard"
	speak_statement =   "chirps"

	mob_bump_flag =   HEAVY
	mob_swap_flags = ~HEAVY
	mob_push_flags =  HEAVY
	mob_size = MOB_SIZE_LARGE

	var/recharge_complete
	var/recharger_tick_cost = 30 KILOWATTS
	var/obj/item/cell/recharging

	var/list/stored_atoms
	var/max_stored_atoms = 2
	var/static/list/can_store_types = list(
		/obj/structure/closet,
		/mob/living/carbon/human,
		/mob/living/silicon/robot
	)

/mob/living/silicon/robot/platform/Initialize()
	. = ..()
	if(!mmi)
		mmi = new /obj/item/mmi/digital/robot(src)
	SetName("inactive [initial(name)]")
	update_icon()

/mob/living/silicon/robot/platform/Destroy()
	for(var/weakref/drop_ref in stored_atoms)
		var/atom/movable/drop_atom = drop_ref.resolve()
		if(istype(drop_atom) && !QDELETED(drop_atom) && drop_atom.loc == src)
			drop_atom.dropInto(loc)
	stored_atoms = null
	if(recharging)
		recharging.dropInto(loc)
		recharging = null
	. = ..()

/mob/living/silicon/robot/platform/examine(mob/user, distance)
	. = ..()
	if(distance <= 3)
		if(recharging)
			to_chat(user, "It has \a [recharging] slotted into its recharging port.")
		if(length(stored_atoms))
			var/list/atom_names = list()
			for(var/weakref/stored_ref in stored_atoms)
				var/atom/movable/AM = stored_ref.resolve()
				if(istype(AM))
					atom_names += "\a [AM]"
			if(length(atom_names))
				to_chat(user, "It has [english_list(atom_names)] loaded into its transport bay.")

/mob/living/silicon/robot/platform/update_braintype()
	braintype = "Platform"

/mob/living/silicon/robot/platform/init()
	. = ..()
	if(ispath(module, /obj/item/robot_module))
		module = new module(src)

/mob/living/silicon/robot/platform/use_power()
	. = ..()

	if(stat != DEAD && cell)

		// TODO generalize solar occlusion to charge from the actual sun.
		if(istype(loc, /turf/exterior) || istype(loc, /turf/space))
			cell.give(recharger_tick_cost * CELLRATE)
			used_power_this_tick -= (recharger_tick_cost * CELLRATE)

		if(recharging && recharging.percent() < 100)
			var/charge_amount = recharger_tick_cost * CELLRATE
			if(cell.check_charge(charge_amount * 1.5) && cell.checked_use(charge_amount)) // Don't kill ourselves recharging the battery.
				recharging.give(charge_amount)
				used_power_this_tick += charge_amount

			if(!recharge_complete && recharging.percent() >= 100)
				recharge_complete = TRUE
				visible_message(SPAN_NOTICE("\The [src] beeps and flashes a green light above \his recharging port."))
