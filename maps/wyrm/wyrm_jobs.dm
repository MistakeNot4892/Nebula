/datum/map/wyrm
	allowed_jobs = list(/datum/job/captain,
						/datum/job/hop,
						/datum/job/blueshield,
						/datum/job/engineer/head,
						/datum/job/engineer,
						/datum/job/doctor/head,
						/datum/job/doctor,
						/datum/job/scientist/head,
						/datum/job/scientist,
						/datum/job/ai,
						/datum/job/cyborg
						)

/*datum/job/doctor
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_cmo)
	alt_titles = list("Chemist" = /decl/hierarchy/outfit/job/medical/doctor/chemist,
		"Surgeon" = /decl/hierarchy/outfit/job/medical/doctor/surgeon,
		"Emergency Physician" = /decl/hierarchy/outfit/job/medical/doctor/emergency_physician,
		"Psychologist" = /decl/hierarchy/outfit/job/medical/psychiatrist/psychologist
		)*/

/*datum/job/scientist
	alt_titles = list("Xenobiologist", "Xenoarcheologist", "Xenobotanist", "Anomalist",
		"Roboticist" = /decl/hierarchy/outfit/job/science/roboticist)*/

/datum/job/blueshield
	title = "Bodyguard"
	department_types = list(
		/decl/department/command,
		/decl/department/security
	)
	total_positions = 1
	spawn_positions = 1
	supervisors = "whichever head you're protecting. Remember, you are NOT security. Ultimately, you report to the Captain."
	selection_color = "#004a7f"
	req_admin_notify = 1
	minimal_player_age = 8
	outfit_type = /decl/hierarchy/outfit/job/bodyguard
	access = list(access_security, access_sec_doors, access_forensics_lockers,
			            access_medical, access_engine, access_ai_upload, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_construction, access_morgue,
			            access_cargo, access_mailsorting, access_qm, access_lawyer,
			            access_research, access_mining, access_mining_station,
			            access_RC_announce, access_keycard_auth, access_blueshield)
	minimal_access = list(access_security, access_sec_doors, access_forensics_lockers,
			            access_medical, access_engine, access_eva, access_heads,
			            access_all_personal_lockers, access_maint_tunnels, access_construction, access_morgue,
			            access_cargo, access_mailsorting, access_qm, access_lawyer,
			            access_research, access_mining, access_mining_station,
			            access_RC_announce, access_keycard_auth, access_blueshield)

/decl/hierarchy/outfit/job/bodyguard
	name = OUTFIT_JOB_NAME("Bodyguard")
//	uniform = /obj/item/clothing/under/bodyguard
//	suit = /obj/item/clothing/suit/armor/vest/deus_blueshield
//	l_ear = /obj/item/device/radio/headset/heads/hop
	shoes = /obj/item/clothing/shoes/jackboots
//	id_type = /obj/item/weapon/card/id/bodyguard
//	pda_type = /obj/item/modular_computer/pda/heads/hop
//	backpack_contents = list(/obj/item/weapon/storage/box/deathimp = 1)
	gloves = /obj/item/clothing/gloves/thick/combat

/decl/hierarchy/outfit/job/bodyguard/New()
	..()
	BACKPACK_OVERRIDE_SECURITY

/obj/item/clothing/under/bodyguard
	name = "Bodyguard's Uniform"
	desc = "A black uniform made from a durable, slightly laser-resistant, fabric."
	icon_state = "combat"
	armor = list(melee = 10, bullet = 0, laser = 10,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/weapon/card/id/bodyguard
	name = "identification card"
	desc = "A card issued to those crazy enough to put their life on the line for the Heads of Staff."
	icon_state = "centcom"