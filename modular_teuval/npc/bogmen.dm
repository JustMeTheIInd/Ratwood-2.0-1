/mob/living/carbon/human/species/human/northern/bog_boss
	aggressive=1
	rude = TRUE
	mode = NPC_AI_IDLE
	//Well trained soldiers.
	smart_combatant = TRUE
	special_attacker = TRUE
	faction = list("viking", "station")
	ambushable = FALSE
	cmode = 1
	setparrytime = 30
	flee_in_pain = TRUE
	a_intent = INTENT_HELP
	d_intent = INTENT_PARRY
	possible_mmb_intents = list(INTENT_BITE, INTENT_JUMP, INTENT_KICK, INTENT_STEAL)
	possible_rmb_intents = list(
		/datum/rmb_intent/feint,\
		/datum/rmb_intent/aimed,\
		/datum/rmb_intent/strong,\
		/datum/rmb_intent/riposte,\
		/datum/rmb_intent/weak
	)
	var/is_silent = FALSE /// Determines whether or not we will scream our funny lines at people.
	npc_max_jump_stamina = 0

/mob/living/carbon/human/species/human/northern/bog_boss/retaliate(mob/living/L)
	var/newtarg = target
	.=..()
	if(target)
		aggressive=1
		wander = TRUE
		if(!is_silent && target != newtarg)
			say(pick(GLOB.highwayman_aggro))
			linepoint(target)

/mob/living/carbon/human/species/human/northern/bog_boss/should_target(mob/living/L)
	if(L.stat != CONSCIOUS)
		return FALSE
	. = ..()

/mob/living/carbon/human/species/human/northern/bog_boss/Initialize(mapload)
	. = ..()
	set_species(/datum/species/human/northern)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)
	is_silent = TRUE


/mob/living/carbon/human/species/human/northern/bog_boss/after_creation()
	..()
	job = "The Master of The Bog"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_STRENGTH_UNCAPPED, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_UNCAPPED_SPEED, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_GRABIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_STRONGKICK, TRAIT_GENERIC) // PSYDON help you.

	equipOutfit(new /datum/outfit/job/roguetown/human/northern/bog_boss)
	var/obj/item/organ/eyes/organ_eyes = getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = pick("27becc", "35cc27", "000000")
	update_hair()
	update_body()
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	head.sellprice = 1000 // They deserve it.

/mob/living/carbon/human/species/human/northern/bog_boss/npc_idle()
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

/mob/living/carbon/human/species/human/northern/bog_boss/handle_combat()
	if(mode == NPC_AI_HUNT)
		if(prob(2)) // do not make this big or else they NEVER SHUT UP
			emote("laugh")
	. = ..()

/datum/outfit/job/roguetown/human/northern/bog_boss/pre_equip(mob/living/carbon/human/H)
	..()
	//Body Stuff
	H.eye_color = "27becc"
	H.hair_color = "61310f"
	H.facial_hair_color = H.hair_color
	if(H.gender == FEMALE)
		H.hairstyle =  "Messy (Rogue)"
	else
		H.hairstyle = "Messy"
		H.facial_hairstyle = "Beard (Manly)"
	//skill Stuff
	H.adjust_skillrank(/datum/skill/combat/maces, 4, TRUE) //NPCs do not get these skills unless a mind takes them over, hopefully in the future someone can fix
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.STASTR = 20
	H.STASPD = 20
	H.STACON = 20
	H.STAWIL = 20
	H.STAPER = 20
	H.STAINT = 20
	H.STAFOR = 20 //Fear.
	
/datum/outfit/job/roguetown/human/species/human/northern/bog_boss/pre_equip(mob/living/carbon/human/H)
	cloak = 
