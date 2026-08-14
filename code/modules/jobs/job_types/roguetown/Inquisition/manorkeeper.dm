/datum/job/roguetown/manorkeeper
	title = "Caretaker"
	flag = MANORKEEPER
	department_flag = INQUISITION
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_ALL_KINDS
	allowed_patrons = list(/datum/patron/old_god) //Requires your character's patron to be Psydon. This role is explicitly designed to be played by Psydonites, only, and almost everything they have - down to the equipment and statblock - is rooted in Psydonism. Do NOT make this accessable to other faiths, unless you go through the efforts of redesigning it from the ground up.
	tutorial = "Chores, Errands, Prayer. To some other, maybe such lyfe would prove unfathomaly boring, You are not one to complain, You never did. You may not be a warrior of silver and steel, or a faithful Absolutionist of the pain and death, Discounting such foolish considerations, you always remained steadfast in your particular duty to the Holy Orthodoxy - The preparing of meals, the mopping of floors, the dusting of ancient, holy tomes.. In the end, such work matters too, ensuring the Warriors of Faith remain clean, well-fed and cared for is your task. And you are certain that HE sees it the very same way as you do."
	selection_color = JCOLOR_INQUISITION
	outfit = null
	outfit_female = null
	display_order = JDO_MANORKEEPER
	min_pq = 15 // Otavan support side-bitch. 
	max_pq = null
	round_contrib_points = 2
	advclass_cat_rolls = list(CTAG_INQUISITION = 20)
	wanderer_examine = FALSE
	advjob_examine = TRUE
	give_bank_account = 25
	social_rank = SOCIAL_RANK_YEOMAN
	job_traits = list(TRAIT_OUTLANDER, TRAIT_STEELHEARTED, TRAIT_INQUISITION, TRAIT_HOMESTEAD_EXPERT, TRAIT_SILVER_BLESSED, TRAIT_ZOMBIE_IMMUNE,)
	job_subclasses = list(
		/datum/advclass/butler,
		/datum/advclass/maid
	)

/datum/advclass/manorkeeper/butler
	name = "Butler" // Yeah I am ripping off Alfred Pennyworth. What about it?
	tutorial = "You come from a grand and prestigious blood-lyne of Butlers. Your fathers and fore-fathers serving with respect, loyalty and faith. And your most extra-ordinare and steadfast commitment to your assigned task granted you an ability most unheard of - You were selected as the Custodian for one of the Holy Missions of the Blessed Inquisition. You serve with duty, care and obedience, attending to your countless tasks throughout the week. Whether that be mopping the floors, prepraring the Inquisitor's coffee or- blowing a hand-sized hole through the chest of any foolish idiot willing to intrude upon the grounds of the Manor..."
	subclass_stats = list(
		STATKEY_SPD = 2 
		STATKEY_PER = 1
		STATKEY_WIL = 1 
		STATKEY_CON = 1 // They get a reeelatively big buff from being in the Manor. We don't want them running out to frag people OUTSIDE of the Manor.
	)
traits_applied = list(TRAIT_CICERONE, TRAIT_KEENEARS, TRAIT_SLEUTH, TRAIT_DODGEEXPERT)
subclass_skills = list( // Skills are the same for both subclasses. It's really just flavour.
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/medicine = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/music = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_MASTER,
		/datum/skill/craft/sewing = SKILL_LEVEL_EXPERT, // Frankly? Wretches get the toiler for whatever reason, I should feel perfectly fine just giving the Butler MASTER in all crafting.. 
		/datum/skill/combat/firearms = SKILL_LEVEL_MASTER // Own an arquebus rifle for Manor defense, since that's what PSYDON intended. Four wretches break into my Manor. "What the Arch-devil?" As I grab my fencing gambeson and Estruscan rifle. Blow a golf ball sized hole through the first heretic, he's dead on the spot. Draw my handgonne on the second man, miss him entirely because it's smoothbore and nails the neighbors Lupian. I have to resort to the Sauterelle mounted at the top of the stairs loaded with LUX-bolts, "Purity Afloat, Infidels!" the lux-bolt shreds two berserkers in the blast, the sound and extra shrapnel set off SCOM alarms. Grab my Psydonic Halberd and charge the last terrified Knave. She Bleeds out waiting on the Garrison to arrive since silver-tipped, triple-blessed halberd wounds are impossible to stitch up, Just as PSYDON intended.
	)
	subclass_stashed_items = list(
		"Tome of Psydon" = /obj/item/book/rogue/bibble/psy
	)
/datum/outfit/job/roguetown/manorkeeper/butler/pre_equip(mob/living/carbon/human/H)
	..() // TO-DO...
	has_loadout = TRUE
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/formal
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	neck = /obj/item/clothing/neck/roguetown/psicross
	shoes = /obj/item/clothing/shoes/roguetown/boots/otavan
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/otavan
	backr =  /obj/item/storage/backpack/rogue/satchel/otavan
	r_hand = /obj/item/gun/ballistic/firearm/arquebus
	gloves = /obj/item/clothing/gloves/roguetown/otavan
	belt = /obj/item/storage/belt/rogue/leather/suspenders/butler
	beltr = /obj/item/quiver/bullet/lead
	beltl = /obj/item/roguekey/inquisition
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/rich = 1,
		/obj/item/soap = 1,
		/obj/item/natural/cloth = 1
		/obj/item/rogueweapon/huntingknife/idagger/silver/psydagger = 1,
		)

/datum/advclass/manorkeeper/maid
	name = "Maid"
	tutorial = "You are one of the 'famed' Otavan Maids. Albeit your being might be point of fantasy of the common, crude curr, You yourself are anything but a simple harlot. Yoour extensive upbringing left you with a wide array of skills, both domestic and martial, allowing you to best carry out your many duties."
	subclass_stats = list(
		STATKEY_SPD = 2 
		STATKEY_PER = 1
		STATKEY_WIL = 1 
	)

traits_applied = list(TRAIT_CICERONE, TRAIT_KEENEARS, TRAIT_SLEUTH, TRAIT_DODGEEXPERT)
subclass_skills = list( // Skills are the same for both subclasses. It's really just flavour.
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/medicine = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/music = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_MASTER,
		/datum/skill/craft/sewing = SKILL_LEVEL_EXPERT, // Frankly? Wretches get the toiler for whatever reason, I should feel perfectly fine just giving the Butler MASTER in all crafting.. 
		/datum/skill/combat/swords = SKILL_LEVEL_EXPERT
	)

/datum/outfit/job/roguetown/manorkeeper/maid/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/maidband
	armor = /obj/item/clothing/suit/roguetown/shirt/dress/maid
	shoes = /obj/item/clothing/shoes/roguetown/boots/otavan
	cloak = /obj/item/clothing/cloak/apron/maid
	backr =  /obj/item/storage/backpack/rogue/satchel/otavan
	belt = /obj/item/storage/belt/rogue/leather/sash
	beltr = /obj/item/rogueweapon/scabbard/sword
	beltl = /obj/item/roguekey/inquisition
	gloves = /obj/item/clothing/gloves/roguetown/otavan
	r_hand = /obj/item/rogueweapon/sword/rapier/psy
	backpack_contents = list(
		/obj/item/storage/belt/rogue/pouch/coins/rich = 1,
		/obj/item/soap = 1,
		/obj/item/natural/cloth = 1
		/obj/item/rogueweapon/huntingknife/idagger/silver/psydagger = 1,
		)
