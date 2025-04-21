
/*
 * Modifiers applied by Medical sources.
 */

/datum/modifier/bloodpump
	name = "external blood pumping"
	desc = "Your blood flows thanks to the wonderful power of science."

	on_created_text = span_notice("You feel alive.")
	on_expired_text = span_notice("You feel.. less alive.")
	stacks = MODIFIER_STACK_EXTEND

	pulse_set_level = PULSE_NORM

/datum/modifier/bloodpump/check_if_valid()
	..()
	if(holder.stat == DEAD)
		src.expire()

/datum/modifier/bloodpump_corpse
	name = "forced blood pumping"
	desc = "Your blood flows thanks to the wonderful power of science."

	on_created_text = span_notice("You feel alive.")
	on_expired_text = span_notice("You feel.. less alive.")
	stacks = MODIFIER_STACK_EXTEND

	pulse_set_level = PULSE_SLOW
	var/mob/living/carbon/human/human_being_pumped

//The meat and
/datum/modifier/bloodpump_corpse/proc/process_blood()
	holder.handle_chemicals_in_body() // Circulates chemicals throughout the body.
	if(human_being_pumped) //Specialty human procs.
		human_being_pumped.handle_organs() //Things like antibiotics will work. And since we're circulating, it makes infections get worse if we don't treat them!
		human_being_pumped.handle_heartbeat() //We can hear our own heart being pumped! This makes a pretty neat sound effect.

/datum/modifier/bloodpump_corpse/on_applied()
	if(ishuman(holder))
		human_being_pumped = holder
	return

/datum/modifier/bloodpump/corpse/check_if_valid()
	..()
	if(holder.stat != DEAD)
		src.expire()

<<<<<<< HEAD
=======
//This INTENTIONALLY only happens on DEAD people. Alive people are metabolizing already (and can be healed quicker through things like brute packs) meaning they don't need this extra assistance!
//Why does it not make you bleed out? Because we'll let medical have a few benefits that don't come with innate downsides. It takes 2 seconds to resleeve someone. It takes a good amount of time to repair a corpse. Let's make the latter more appealing.
/datum/modifier/bloodpump_corpse/tick()
	for(var/i in 1 to 5) //It's a controlled machine. 5 pumps per tick.
		process_blood() // Circulates chemicals throughout the body.
>>>>>>> fa2f444342 ([MIRROR] Makes bloodpump process spaceacillin properly (#10706))
/*
 * Modifiers caused by chemicals or organs specifically.
 */

<<<<<<< HEAD
=======
/datum/modifier/bloodpump_corpse/cpr
	desc = "Your blood flows thanks to the wonderful power of CPR."
	pulse_set_level = PULSE_NONE //No pulse. You're acting as their pulse.

/datum/modifier/bloodpump_corpse/cpr/tick()
	var/randomization = rand(4,7) //CPR isn't perfect. You get some randomization in there.
	for(var/i in 1 to randomization)
		process_blood()

>>>>>>> fa2f444342 ([MIRROR] Makes bloodpump process spaceacillin properly (#10706))
/datum/modifier/cryogelled
	name = "cryogelled"
	desc = "Your body begins to freeze."
	mob_overlay_state = "chilled"

	on_created_text = span_danger("You feel like you're going to freeze! It's hard to move.")
	on_expired_text = span_warning("You feel somewhat warmer and more mobile now.")
	stacks = MODIFIER_STACK_ALLOWED

	slowdown = 0.1
	evasion = -5
	attack_speed_percent = 1.1
	disable_duration_percent = 1.05

/datum/modifier/clone_stabilizer
	name = "clone stabilized"
	desc = "Your body's regeneration is highly restricted."

	on_created_text = span_danger("You feel nauseous.")
	on_expired_text = span_warning("You feel healthier.")
	stacks = MODIFIER_STACK_EXTEND

	incoming_healing_percent = 0.1
