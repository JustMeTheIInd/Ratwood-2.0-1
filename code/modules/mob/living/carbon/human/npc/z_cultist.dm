//Evil Ass Z-Cultists, for both ambushes AND dungeons!

/mob/living/carbon/human/species/human/northern/zcultist
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

/mob/living/carbon/human/species/human/northern/zcultist/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.highwayman_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/zcultist/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/northern/zcultist/Initialize(mapload)
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE

/mob/living/carbon/human/species/human/northern/zcultist/after_creation()
	..()
	job = "Cult Initiate"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	equipOutfit(new /datum/outfit/job/roguetown/human/species/human/northern/zcultist)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)

/mob/living/carbon/human/species/human/northern/zcultist/npc_idle()
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

/mob/living/carbon/human/species/human/northern/zcultist/handle_combat()
	if(mode == NPC_AI_HUNT)
		if(prob(2)) // do not make this big or else they NEVER SHUT UP
			emote("laugh")
	. = ..()

/datum/outfit/job/roguetown/human/species/human/northern/zcultist/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/cloak/raincloak/furcloak/black
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/tights/black
	if(prob(20))
		neck = /obj/item/clothing/neck/roguetown/gorget/steel/ancient
	mask = /obj/item/clothing/mask/rogue/facemask/ancient // Masks are cool.
	head = /obj/item/clothing/head/roguetown/roguehood/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/rope/dark
	beltl = /obj/item/clothing/neck/roguetown/psicross/inhumen/ancient
	switch(rand(1, 100))
		if(1 to 85)
				beltr = null
		if(86 to 98)
				beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
		if(98 to 100)
				beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	H.STASTR = 11
	H.STASPD = 9
	H.STACON = 11
	H.STAWIL = 10
	H.STAPER = 11
	H.STAINT = 9 // trash mobs, Psy-chow, you get the point.
	H.eye_color = "27becc"
	H.hair_color = "61310f"
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.hairstyle =  "Messy (Rogue)"
	else
		H.hairstyle = "Messy"
		H.facial_hairstyle = "Beard (Manly)"
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE) 
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel/ancient
	if(prob(40))
		r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel
	if(prob(1))
		r_hand = /obj/item/rogueweapon/huntingknife/idagger/steel/dirk
