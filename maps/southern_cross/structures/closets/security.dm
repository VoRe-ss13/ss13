/*
 * SC Security
 */


/obj/structure/closet/secure_closet/hos_wardrobe
	name = "head of security's locker"
	req_access = list(access_hos)
	closet_appearance = /decl/closet_appearance/secure_closet/security/hos

	starts_with = list(
<<<<<<< HEAD
		/obj/item/clothing/head/helmet/HoS,
		/obj/item/clothing/head/helmet/HoS/hat,
		/obj/item/clothing/suit/storage/vest/hos,
		/obj/item/clothing/under/rank/head_of_security/jensen,
		/obj/item/clothing/under/rank/head_of_security/corp,
		/obj/item/clothing/suit/storage/vest/hoscoat/jensen/alt,
		/obj/item/clothing/suit/storage/vest/hoscoat/jensen,
		/obj/item/clothing/suit/storage/vest/hoscoat,
		/obj/item/cartridge/hos,
		/obj/item/clothing/head/helmet/dermal,
		/obj/item/radio/headset/heads/hos,
		/obj/item/radio/headset/heads/hos/alt,
		/obj/item/clothing/head/beret/sec/corporate/hos,
		/obj/item/clothing/suit/storage/hooded/wintercoat/security/hos,
=======
		/obj/item/clothing/under/rank/head_of_security/jensen,
		/obj/item/clothing/under/rank/head_of_security/corp,
		/obj/item/clothing/suit/storage/vest/hoscoat/jensen,
		/obj/item/clothing/suit/storage/vest/hoscoat,
		/obj/item/cartridge/hos,
		/obj/item/radio/headset/heads/hos,
		/obj/item/clothing/glasses/sunglasses/sechud,
		/obj/item/storage/box/holobadge/hos,
		/obj/item/clothing/accessory/badge/holo/hos,
		/obj/item/clothing/accessory/holster/waist,
		/obj/item/clothing/head/beret/sec/corporate/hos,
>>>>>>> 026253a175 (upstream-merge-16484 [MDB IGNORE] (#9289))
		/obj/item/clothing/mask/gas/half)

/obj/structure/closet/secure_closet/hos_wardrobe/Initialize()
	if(prob(50))
		starts_with += /obj/item/storage/backpack/security
	else
		starts_with += /obj/item/storage/backpack/satchel/sec
	if(prob(50))
		starts_with += /obj/item/storage/backpack/dufflebag/sec
	return ..()
