/*
//////////////////////////////////////
Viral adaptation

	Moderate stealth boost.
	Major Increases to resistance.
	Reduces stage speed.
	No change to transmission
	Critical Level.

BONUS
	Extremely useful for buffing viruses

//////////////////////////////////////
*/
/datum/symptom/viraladaptation
	name = "Viral self-adaptation"
	stealth = 3
	resistance = 5
	stage_speed = -3
	transmittable = 0
	level = 3
	severity = 0

/datum/symptom/viraladaptation/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB))
		var/mob/living/M = A.affected_mob
		switch(A.stage)
			if(1)
				to_chat(M, span_notice("You feel off, but no different from before."))
			if(5)
				to_chat(M, span_notice("You feel better, but nothing interesting happens."))

/*
//////////////////////////////////////
Viral evolution

	Moderate stealth reductopn.
	Major decreases to resistance.
	increases stage speed.
	increase to transmission
	Critical Level.

BONUS
	Extremely useful for buffing viruses

//////////////////////////////////////
*/
/datum/symptom/viralevolution
	name = "Viral evolutionary acceleration"
	stealth = -2
	resistance = -3
	stage_speed = 5
	transmittable = 3
	level = 3
	severity = 0

<<<<<<< HEAD
/datum/symptom/viralevolution/Activate(datum/disease/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB))
		var/mob/living/M = A.affected_mob
		switch(A.stage)
			if(1)
				to_chat(M, span_notice("You feel better, but no different from before."))
			if(5)
				to_chat(M,span_notice("You feel off, but nothing interesting happens."))
=======
/datum/symptom/viralpower
	name = "Viral Power Multiplier"
	desc = "The vrus has more powerful symptoms. May have unpredictable effects."
	stealth = 2
	resistance = 2
	stage_speed = 2
	transmission = 2
	level = -1
	var/maxpower
	var/powerbudget
	var/scramble = FALSE
	var/used = FALSE

	threshold_descs = list(
		"Transmission 8" = "Constantly scrambles the power of all symptoms.",
		"Stage Speed 8" = "Doubles the power boost."
	)

/datum/symptom/viralpower/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.speed >= 8)
		power = 2
	if(A.transmission >= 8)
		scramble = TRUE

/datum/symptom/viralpower/Activate(datum/disease/advance/A)
	if(!..())
		return
	if(!used)
		for(var/datum/symptom/S as anything in A.symptoms)
			if(S == src)
				return
			S.power += power
			maxpower += S.power
		if(scramble)
			powerbudget += power
			maxpower += power
			power = 0
		used = TRUE
	if(scramble)
		var/datum/symptom/S = pick(A.symptoms)
		if(S == src)
			return
		if(powerbudget && (prob(50) || powerbudget == maxpower))
			S.power += 1
			powerbudget -= 1
		else if(S.power >= 2)
			S.power -= 1
			powerbudget += 1

/datum/symptom/viralreverse
	name = "Viral Aggressive Metabolism"
	desc = "The virus sacrifices its long term survivability to nearly instantly fully spread inside a host. \
	The virus will start at the last stage, but will eventually decay and die off by itself."
	stealth = 1
	resistance = 1
	stage_speed = 3
	transmission = -4
	level = 4
	symptom_delay_min = 1
	symptom_delay_max = 1
	threshold_descs = list(
		"Stage Speed" = "Highest between these determines the amount before self-curing.",
		"Stealth 4" = "Doubles the time before the virus self-cures."
	)

	var/time_to_cure

/datum/symptom/viralreverse/Activate(datum/disease/advance/A)
	if(!..())
		return
	if(time_to_cure > 0)
		time_to_cure--
	else
		var/mob/living/M = A.affected_mob
		Heal(M, A)

/datum/symptom/viralreverse/proc/Heal(mob/living/M, datum/disease/advance/A)
	A.stage -= 1
	if(A.stage < 2)
		to_chat(M, span_notice("You suddenly feel healthy."))
		A.cure(FALSE)

/datum/symptom/viralreverse/Start(datum/disease/advance/A)
	if(!..())
		return
	A.stage = 5
	if(A.stealth >= 4)
		power = 2
	time_to_cure = max(A.resistance, A.stage_rate) * 10 * power

/datum/symptom/viralincubate
	name = "Viral Suspended Animation"
	desc = "The virus has very little effect until it reaches its final stage"
	stealth = 4
	resistance = -2
	stage_speed = -2
	transmission = 1
	level = 4
	symptom_delay_min = 1
	symptom_delay_max = 1
	var/list/captives = list()
	var/used = FALSE

/datum/symptom/viralincubate/Activate(datum/disease/advance/A)
	if(!..())
		return
	if(A.stage >= 5)
		for(var/datum/symptom/S as anything in captives)
			S.stopped = FALSE
			captives -= S
		if(!LAZYLEN(captives))
			stopped = TRUE
	else if(!used)
		for(var/datum/symptom/S as anything in A.symptoms)
			if(S.neutered)
				continue
			if(S == src)
				continue
			S.stopped = TRUE
			captives += S
		used = TRUE
>>>>>>> 92b1bc3f74 ([MIRROR] Various virology fixes (#10871))
