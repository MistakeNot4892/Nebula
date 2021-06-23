/decl/material/liquid/organ_meds
	name = "peridaxon"
	lore_text = "A collection of universal stem cells and nutrients used to encourage recovery of internal organs and nervous systems. Medicate cautiously."
	taste_description = "bitterness"
	color = "#561ec3"
	overdose = 10
	scannable = 1
	flags = IGNORE_MOB_SIZE
	value = 4

/decl/material/liquid/organ_meds/affect_blood(mob/living/carbon/M, alien, removed)
    for(var/obj/item/organ/internal/I in M.internal_organs)
        if(BP_IS_PROSTHETIC(I))
            continue
        if(I.organ_tag == BP_BRAIN)
            SET_STATUS_MAX(M, STAT_CONFUSE, 2)
            SET_STATUS_MAX(M, STAT_DROWSY, 2)
            if(I.damage >= I.min_bruised_damage)
                continue
        if((I.status & ORGAN_DEAD) && I.death_time >= world.time - ORGAN_RECOVERY_THRESHOLD)
            I.death_time += 27 SECONDS * removed //Let's say its 45% effective if not directly applied
            if(I.death_time >= world.time)
                I.status &= ~ORGAN_DEAD
        else
            I.damage = max(I.damage - 2 * removed, 0)

/decl/material/liquid/organ_meds/affect_overdose(mob/living/carbon/M, alien, datum/reagents/holder)
	if(prob(5))
		var/obj/item/organ/external/E = pick(M.organs)
		if(prob(50))
			to_chat(M,SPAN_DANGER("It feels like something in your [E.name] is trying to tear your skin open from the inside!"))
		else
			M.visible_message(
				SPAN_WARNING("\the [M]'s [E.name] spasms as abnormal growths begin to press out from it!"),
				SPAN_DANGER("Your [E.name] spasms as you feel abnormal growths begin to grow from inside!")
			)
			E.status |= ORGAN_MUTATED
			E.take_external_damage(rand(15,25), damage_flags = DAM_SHARP)
	
/obj/item/chems/pill/organ_meds
	name = "peridaxon (10u)"
	desc = "Used to treat internal damage."
	icon_state = "pill2"

/obj/item/chems/pill/organ_meds/initialize_reagents()
	reagents.add_reagent(/decl/material/liquid/organ_meds, 10)

/obj/item/storage/pill_bottle/organ_meds
	name = "pill bottle (peridaxon)"
	desc = "Contains pills used to heal internal damage."

	startswith = list(/obj/item/chems/pill/organ_meds = 14)
	wrapper_color = COLOR_PURPLE

/decl/material/liquid/painkillers/oxycodone
	name = "oxycodone"
	lore_text = "An effective and very addictive painkiller. Don't mix with alcohol."
	taste_description = "bitterness"
	color = "#800080"
	metabolism = REM * 1.5
	overdose = 20
	pain_power = 200
	effective_dose = 2
	value = 3

/decl/material/liquid/local_anesthetic
	name = "deletrathol"
	lore_text = "A highly effective non-opiate based painkiller and emergency anesthetic that causes confusion."
	taste_description = "confusion"
	color = "#800080"
	overdose = 15
	scannable = 1
	metabolism = REM * 0.25

/decl/material/liquid/deletrathol/affect_blood(mob/living/carbon/M, alien, removed)
	M.add_chemical_effect(CE_PAINKILLER, 250)
	M.add_chemical_effect(CE_SLOWDOWN, 1)
	SET_STATUS_MAX(M, STAT_DIZZY, 2)
	if(prob(75))
		SET_STATUS_MAX(M, STAT_DROWSY, 2)
	if(prob(25))
		SET_STATUS_MAX(M, STAT_CONFUSE, 3)

/decl/material/liquid/latrazine
	name = "latrazine"
	lore_text = "An illegal, but medically <i>interesting</i>, psychotropic compound with the accidental side effect of causing bone fractures to heal."
	taste_description = "bitterness"
	color = "#8f001f"
	metabolism = REM * 0.5
	overdose = 1
	scannable = 1
	flags = IGNORE_MOB_SIZE
	value = 10

/decl/material/liquid/latrazine/affect_blood(mob/living/carbon/M, alien, removed)
	var/obj/item/organ/external/E = pick(M.organs)
	if(E.status & ORGAN_BROKEN)
		E.status &= ~ORGAN_BROKEN
		M.custom_pain("You suddenly feel <b>EXCRUCIATING</b> pain as the muscles in your [E.name] spasm, <i>SNAPPING</i> the bones into place.", 120, 1, E)
	else if(E.damage && prob(50))
		M.custom_pain("The muscles in your [E.name] spasm uncontrollably, disturbing the wounds there!", E.pain*3, 1, E)
	if(prob(15) && M.hallucination_power < 60)
		to_chat(M, SPAN_DANGER(FONT_LARGE("Your vision of reality suddenly <i>snaps</i>!")))
		SET_STATUS_MAX(M,STAT_DRUGGY,100)
		M.adjust_hallucination(120,100)

/decl/material/liquid/latrazine/affect_overdose(mob/living/M, alien, datum/reagents/holder)
	..()
	if(!GET_STATUS(M,STAT_PARA))
		to_chat(M,SPAN_DANGER(FONT_HUGE("Your body has chosen to disconnect itself from you.")))
	SET_STATUS_MAX(M,STAT_PARA,50)

/decl/material/liquid/cyro_fluid
	name = "clonexadone"
	lore_text = "A liquid compound similar to that used in Vey-Med's cloning process. Can be used on its own for its rapid regenerative properties."
	taste_description = "slime"
	color = "#5eacfa"
	metabolism = REM * 2
	scannable = 1
	flags = IGNORE_MOB_SIZE
	heating_products = list(/decl/material/liquid/water = 0.8, /decl/material/liquid/nutriment/sugar = 0.2)
	heating_point = 22 CELSIUS //reminder to mess around with this 
	heating_message = "turns back to sludge."
	value = 10

/decl/material/liquid/cyro_fluid/affect_blood(mob/living/carbon/M, alien, removed)
	M.add_chemical_effect(CE_CRYO, 1)
	if(M.bodytemperature <= T0C)
		M.adjustCloneLoss(-300 * removed)
		M.add_chemical_effect(CE_OXYGENATED, 2)
		M.heal_organ_damage(30 * removed, 30 * removed)
		M.adjustToxLoss(-5 * removed)
		M.add_chemical_effect(CE_PULSE, -2)

/decl/material/liquid/cyro_precursor
	name = "cyrogenic precursor"
	lore_text = "A highly valued shelf-stable state of clonexadone."
	color = "#a8d4ff"
	scannable = 1
	value = 10

/obj/item/chems/glass/beaker/insulated/cyro/Initialize()
	. = ..()
	reagents.add_reagent(/decl/material/liquid/cyro_precursor, 60)
	update_icon()

/obj/item/storage/fancy/vials/cyro
	startswith = list(/obj/item/chems/glass/beaker/vial/cyro = 6, /obj/item/chems/glass/beaker/vial/trinitricine = 3, /obj/item/chems/glass/beaker/vial = 3)

/obj/item/chems/glass/beaker/vial/cyro/Initialize()
	. = ..()
	reagents.add_reagent(/decl/material/liquid/cyro_precursor, 30)
	update_icon()

/decl/material/liquid/trinitricine
	name = "trinitricine"
	lore_text = "A simple yet dangerous chemical compound capable of temporarily lowering body temperature. Nearly all heat absorbed is returned."
	color = "#55c79b"
	overdose = 60
	scannable = 1

/decl/material/liquid/trinitricine/affect_blood(mob/living/carbon/M, alien, removed, datum/reagents/holder)
	M.bodytemperature = max(-80 CELSIUS, M.bodytemperature - 150 * removed)
	holder.add_reagent(/decl/material/liquid/binitricine,removed)

/decl/material/liquid/binitricine //if you thought this would make chemical sense, you thought wrong
	name = "binitricine"
	lore_text = "A temporary state of trinitricine following its absorbtion."
	color = "#3f9272"
	metabolism = 0.001
	overdose = 60
	heating_point = 40 CELSIUS
	heating_products = list(/decl/material/liquid/trinitricine = 1) //I'm sure this won't go wrong

/decl/material/liquid/hextrazine
	name = "hextrazine"
	lore_text = "The aftereffect of trinitricine, a compound capable of rapidly heating up bodytemperature."
	color = "#2f6953"
	metabolism = REM * 2
	scannable = 1

/decl/material/liquid/hextrazine/affect_blood(mob/living/carbon/M, alien, removed)
	M.bodytemperature = M.bodytemperature + 150 * removed

/obj/item/chems/glass/beaker/vial/trinitricine/Initialize()
	. = ..()
	reagents.add_reagent(/decl/material/liquid/trinitricine, 30)
	update_icon()