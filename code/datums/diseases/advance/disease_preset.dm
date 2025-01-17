// Cold

/datum/disease/advance/cold/New(process = 1, datum/disease/advance/D, copy = 0)
	if(!D)
		name = "Engineered Cold"
		symptoms = list(new /datum/symptom/sneeze)
	..(process, D, copy)


// Flu

/datum/disease/advance/flu/New(process = 1, datum/disease/advance/D, copy = 0)
	if(!D)
		name = "Engineered Flu"
		symptoms = list(new /datum/symptom/cough)
	..(process, D, copy)
