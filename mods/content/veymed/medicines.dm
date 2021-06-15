/decl/material/liquid/organ_meds
	name = "peridaxon"
	lore_text = "A collection of universal stem cells and nutrients used to encourage recovery of internal organs and nervous systems. Medicate cautiously."
	taste_description = "bitterness"
	color = "#561ec3"
	overdose = 10
	scannable = 1
	flags = IGNORE_MOB_SIZE
	value = 4

/decl/material/liquid/organ_meds/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
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

/decl/material/liquid/deletrathol/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
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

/decl/material/liquid/latrazine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
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
		to_chat(M,SPAN_DANGER(FONT_HUGE("Your body has disconncted itself from your mind.")))
	SET_STATUS_MAX(M,STAT_PARA,50)

/decl/material/liquid/cyro_fluid
	name = "clonexadone"
	lore_text = "A liquid compound similar to that used in Vey-Med's cloning process. Can be used on its own for its rapid regenerative properties."
	taste_description = "slime"
	color = "#80bfff"
	metabolism = REM * 0.5
	scannable = 1
	flags = IGNORE_MOB_SIZE
	heating_products = list(/decl/material/liquid/water = 0.8, /decl/material/liquid/nutriment/sugar = 0.2)
	heating_point = 15 CELSIUS
	heating_message = "turns back to sludge."
	value = 10

/decl/material/liquid/cyro_fluid/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.add_chemical_effect(CE_CRYO, 1)
	M.adjustCloneLoss(-300 * removed)
	M.add_chemical_effect(CE_OXYGENATED, 2)
	M.heal_organ_damage(30 * removed, 30 * removed)
	M.adjustToxLoss(-5 * removed)
	M.add_chemical_effect(CE_PULSE, -2)

/decl/material/liquid/cyro_precursor
	name = "cyrogenic precursor"
	lore_text = "A highly valued shelf-stable state of clonexadone. "
	color = "#80bfff"
	scannable = 1
	value = 10

/obj/item/chems/glass/beaker/insulated/cyro/Initialize()
	. = ..()
	reagents.add_reagent(/decl/material/liquid/cyro_precursor, 30)
	update_icon()