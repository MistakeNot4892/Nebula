/datum/job/eureka
	department_refs = list(DEPT_COLONY)

/datum/map/eureka
	default_assistant_title = "Convict"
	allowed_jobs = list(
		/datum/job/assistant,
		/datum/job/eureka/colonist,
		/datum/job/eureka/colonist/governor,
		/datum/job/eureka/colonist/watchman,
		/datum/job/eureka/colonist/physician,
		/datum/job/eureka/colonist/engineer,
		/datum/job/eureka/crown,
		/datum/job/eureka/crown/officer,
		/datum/job/eureka/crown/medic
	)