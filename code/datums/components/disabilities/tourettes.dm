/datum/component/tourettes_disability
	var/mob/living/owner
	var/list/motor_tics = list()

/datum/component/tourettes_disability/Initialize()
	if (!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	owner = parent
	var/list/possible_tics = list(
		"nod",
		"shake",
		"shiver",
		"twitch",
		"salute",
		"blink",
		"blink_r",
		"wink",
		"shrug",
		"eyebrow",
		"afold",
		"hshrug",
		"ftap",
		"sniff",
		"cough",
		"snap",
		"whistle",
		"qwhistle",
		"wwhistle",
		"swhistle",
		"awoo",
		"prbt",
		"snort",
		"merp",
		"nya",
		"crack",
		"rshoulder"
	)
	for(var/i = 0, i < rand(4, 6), i++)
		motor_tics += pick(possible_tics)
	RegisterSignal(owner, COMSIG_HANDLE_DISABILITIES, PROC_REF(process_component))

/datum/component/tourettes_disability/proc/process_component()
<<<<<<< HEAD
=======
	SIGNAL_HANDLER

	var/mob/living/carbon/human/H = owner

>>>>>>> 2e63a86d17 ([MIRROR] Better Tourette's (#11583))
	if(QDELETED(parent))
		return
	if(isbelly(owner.loc))
		return
	if(owner.stat != CONSCIOUS)
		return
	if(owner.transforming)
		return
<<<<<<< HEAD
	if((prob(1) && prob(2) && owner.paralysis <= 1))
		owner.Stun(10)
		owner.make_jittery(100)
		switch(rand(1, 3))
			if(1)
				owner.emote("twitch")
			if(2 to 3)
				owner.say("[prob(50) ? ";" : ""][pick("SHIT", "PISS", "FUCK", "CUNT", "COCKSUCKER", "MOTHERFUCKER", "TITS")]")

=======
	if(owner.client && (owner.client.prefs.muted & MUTE_IC))
		return
	if(owner.paralysis <= 1 && (H.pulse == PULSE_NORM ? (prob(1)) : (prob(50))))
		owner.make_jittery(30 + rand(10, 30))
		owner.emote(pick(motor_tics))
>>>>>>> 2e63a86d17 ([MIRROR] Better Tourette's (#11583))

/datum/component/tourettes_disability/Destroy(force = FALSE)
	UnregisterSignal(owner, COMSIG_HANDLE_DISABILITIES)
	owner = null
	. = ..()
