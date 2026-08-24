/datum/job/roguetown/preacher
	name = "Preacher"
	flag = PREACHER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1 
	spawn_positions = 1 

	allowed_races = ACCEPTED_RACES
	tutorial = "For yils now you have dutifully and faithfully served as the lone voice for the All-Father in Teuval, despite the many enemies of TRUTH still present and lurking, You toil endlessly in HIS name, spreading HIS word, ENDURING the many insults and jokes at yours and your God's expense, the repeated attempts by the local Tennite Clergy to shut down your Holy Temple and have you be cast into iron chain... Now, after yils of holy servitude you find yourself the loudest voice for the Pilgrims and even the local Village. Stand tall, O' Child of SYON, Hold fast to your oaths, Preach the word of the FATHER, and, above all else, ENDURE, AS HE DOES..."

	outfit = /datum/outfit/job/roguetown/cook
	display_orderr = JDO_PREACHER
	min_pq = 10 // This is a rather RP-intensive role. 
	max_pq = null
	round_contrib_points = 3
	social_rank = SOCIAL_RANK_PEASANT

	job_traits = list(TRAIT_OUTLANDER, TRAIT_PSYDONITE)
	virtue_restrictions = list(/datum/virtue/utility/noble)
	job_subclasses = list(
		/datum/advclass/preacher/adherent
		/datum/advclass/preacher/orator
		/datum/advclass/preacher/pilgrim
	)

/datum/outfit/job/roguetown/preacher
	shoes = /obj/item/clothing/shoes/roguetown/sandals
	shirt = /obj/item/clothing/cloak/psydontabard
	head = /obj/item/clothing/head/roguetown/roguehood/psydon
	pants = /obj/item/clothing/under/roguetown/tights/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/cloth
	backr = /obj/item/storage/backpack/rogue/satchel

/datum/advclass/preacher/adherent // Otavan Spy. Gets blood magic, silver cross and a dagger!. Still not really geared for combat. 
	name = "Adherent"
	tutorial = "Trained in the cold mountains of Holy Otava, you were sent here to gain trust and keep watch over these hallowed lands, The locals admire you for your miracle-work, and beautiful silver ornaments... They need not know where from it all really comes."
	outfit = /datum/outfit/job/roguetown/preacher/adherent
		neck = /obj/item/clothing/neck/roguetown/psicross/silver
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/flashlight/flare/torch/lantern
		beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
		backpack_contents = list(obj/item/roguekey/psychurch = 1, /obj/item/needle/thorn = 1, /obj/item/book/rogue/bibble/psy = 1, /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger = 1, /obj/item/sheath)
	subclass_languages = list(/datum/language/otavan)
	subclass_stats = list(
		STATKEY_WIL = 2
		STATKEY_CON = 2
	)	
	subclass_skills = list(
		/datum/skills/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/magic/holy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/knives = SKILL_LEVEL_EXPERT, 
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/sewing = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/preacher/choose_weapon(mob/living/carbon/human/H)
. = ..()
var/weapons = list("Whip", "Flail", "Mace")
var/weapon_choice = input(H, "Choose thy weapon..", "WHAT SHALL YOU DEFEND PSYDONIA WITH?") as anything in weapons
switch(weapon_choice)
	if("Whip")
		H.put_in_hands(new /obj/item/rogueweapon/whip/psywhip_lesser(H), TRUE)
		H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 3, TRUE) // you're not an Adjudicator.
	if("Flail")
		H.put_in_hands(new /obj/item/rogueweapon/flail/sflail/psyflail(H), TRUE)
		H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 3, TRUE)
	if("Mace") // Give it up for the META(TM) choice... 
		H.put_in_hands(new /obj/item/rogueweapon/mace/cudgel/psy(H), TRUE)
		H.adjust_skillrank_up_to(/datum/skill/combat/polearms, 3, TRUE)

/datum/advclass/preacher/pilgrim // Basic "homesteader" class, good cooking, crafting, medicine, etc. Nothing more, Nothing less
	name = "Custodian"
	tutorial = "A seasoned Pilgrim once, when your travels finally brought you to Teuval, and you saw the grave need the locals were in, you decided to stay, using the experience you gained through your many yils of travel to help those in need."
	outfit = /datum/outfit/job/roguetown/preacher/pilgrim
		neck = /obj/item/clothing/neck/roguetown/psicross/wood
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/flashlight/flare/torch/lantern
		beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 1, /obj/item/reagent_containers/food/snacks/rogue/meat/salami = 1)

	