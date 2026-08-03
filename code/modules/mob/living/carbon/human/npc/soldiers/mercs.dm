/mob/living/carbon/human/species/human/northern/merc
	aggressive=1
	rude = TRUE
	mode = NPC_AI_IDLE
	faction = list("viking", "station")
	ambushable = FALSE
	dodgetime = 30
	flee_in_pain = TRUE
	d_intent = INTENT_PARRY
	possible_rmb_intents = list()
	var/is_silent = FALSE /// Determines whether or not we will scream our funny lines at people.

/mob/living/carbon/human/species/human/northern/merc/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.highwayman_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/merc/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/northern/merc/Initialize(mapload)
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE

/mob/living/carbon/human/species/human/northern/merc/after_creation()
	..()
	job = "Hired Merc"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/merc)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)

/mob/living/carbon/human/species/human/northern/merc/npc_idle()
	if(m_intent == MOVE_INTENT_SNEAK)
		return
	if(world.time < next_idle)
		return
	next_idle = world.time + rand(30, 70)
	if((mobility_flags & MOBILITY_MOVE) && isturf(loc) && wander)
		if(prob(20))
			var/turf/T = get_step(loc,pick(GLOB.cardinals))
			if(!istype(T, /turf/open/transparent/openspace))
				Move(T)
		else
			face_atom(get_step(src,pick(GLOB.cardinals)))
	if(!wander && prob(10))
		face_atom(get_step(src,pick(GLOB.cardinals)))

/mob/living/carbon/human/species/human/northern/merc/handle_combat()
	if(mode == NPC_AI_HUNT)
		if(prob(2)) // do not make this big or else they NEVER SHUT UP
			emote("laugh")
	. = ..()

/datum/outfit/job/roguetown/human/species/human/northern/merc/pre_equip(mob/living/carbon/human/H)
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	armor = /obj/item/clothing/suit/roguetown/armor/plate/half
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/grenzelhoft
	gloves = /obj/item/clothing/gloves/roguetown/angle/grenzelgloves
	if(prob(30))
		gloves = /obj/item/clothing/gloves/roguetown/plate
	if(prob(30))
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/grenzelpants
	neck = /obj/item/clothing/neck/roguetown/gorget/steel
	if(prob(20))
		neck = null
	mask = /obj/item/clothing/mask/rogue/facemask/steel
	if(prob(20))
		mask = null
	head = /obj/item/clothing/head/roguetown/grenzelhofthat
	if(prob(15))
		head = /obj/item/clothing/head/roguetown/helmet/bascinet/etruscan/grenzelhoft
	if(prob(15))
		head = /obj/item/clothing/head/roguetown/helmet/sallet/grenzelhoft
	shoes = /obj/item/clothing/shoes/roguetown/boots/grenzelhoft
	if(prob(30))
		shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/black // Style, Ser.
	beltl = null
	switch(rand(1, 100))
		if(1 to 50)
				beltr = null
		if (51 to 85)
				beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
		if (86 to 95)
				beltr = /obj/item/storage/belt/rogue/pouch/medicine
		if (96 to 100)
				beltr = /obj/item/storage/belt/rogue/pouch/treasure/lucky
	if(prob(2))
		id = /obj/item/clothing/ring/gold
	H.STASTR = 17
	H.STASPD = 13
	H.STACON = 16
	H.STAWIL = 16
	H.STAPER = 14
	H.STAINT = 14 // they are meant to hit HARD.
	H.eye_color = "27becc"
	H.hair_color = "61310f"
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.hairstyle =  "Messy (Rogue)"
	else
		H.hairstyle = "Messy"
		H.facial_hairstyle = "Beard (Manly)"
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE) 
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	if(prob(50))
		r_hand = /obj/item/rogueweapon/sword/sabre
	else
		r_hand = /obj/item/rogueweapon/sword/long
		l_hand = /obj/item/rogueweapon/shield/tower/metal
	if(prob(10))
		r_hand = /obj/item/rogueweapon/mace/steel
		l_hand = /obj/item/rogueweapon/shield/iron
	if(prob(40))
		r_hand = /obj/item/rogueweapon/greatsword/grenz
	if(prob(10))
		r_hand = /obj/item/rogueweapon/stoneaxe/battle
	if(prob(20))
		r_hand = /obj/item/rogueweapon/halberd

