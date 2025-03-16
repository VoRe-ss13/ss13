/**********************Input and output plates**************************/

/obj/machinery/mineral/input
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	name = "Input area"
	density = FALSE
	anchored = TRUE

/obj/machinery/mineral/input/Initialize(mapload)
	. = ..()
	icon_state = "blank"

/obj/machinery/mineral/output
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	name = "Output area"
	density = FALSE
	anchored = TRUE

<<<<<<< HEAD
/obj/machinery/mineral/output/New()
	icon_state = "blank"
=======
/obj/machinery/mineral/output/Initialize(mapload)
	. = ..()
	icon_state = "blank"
>>>>>>> c844cc3dee ([MIRROR] Finish Machinery new to init (#10439))
