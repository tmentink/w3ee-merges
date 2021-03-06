//--- RandomEncounters ---
// Made by Erxv
struct SEnemyTemplate
{
    var template : string;
    var max      : int;
	var count 	 : int;
}

function AddEnemyTemplate(template : string, optional max : int) : SEnemyTemplate
	{
		var enemyTemplate : SEnemyTemplate;

		enemyTemplate.template = template;
		enemyTemplate.count = 0;
		
		if (max > 0)
			enemyTemplate.max = max;
		else
			enemyTemplate.max = -1;

		return enemyTemplate;
	}

// ---------------------------------------------------------
// Flying
// ---------------------------------------------------------
function re_gryphon() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\gryphon_lvl1.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\gryphon_lvl3__volcanic.w2ent")); 
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\gryphon_mh__volcanic.w2ent"));
    return list;
}/*
function re_gryphonf() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\modtemplates\randomencounterdlc\data\gryphon\gryphon_lvl1.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\modtemplates\randomencounterdlc\data\gryphon\gryphon_lvl3__volcanic.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\modtemplates\randomencounterdlc\data\gryphon\gryphon_mh__volcanic.w2ent"));	
	return list;
}*/
function re_cockatrice() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;	
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\cockatrice_lvl1.w2ent"));
	return list;
}/*
function re_cockatricef() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
    list.PushBack(AddEnemyTemplate("dlc\modtemplates\randomencounterdlc\data\cockatrice\cockatrice_lvl1.w2ent"));
	return list;
}*/
function re_basilisk() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\basilisk_lvl1.w2ent"));
	return list;
}/*
function re_basiliskf() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\modtemplates\randomencounterdlc\data\cockatrice\basilisk_lvl1.w2ent"));
	return list;
}*/
function re_wyvern() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wyvern_lvl1.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wyvern_lvl2.w2ent"));
	return list;
}
function re_forktail() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\forktail_lvl1.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\forktail_lvl2.w2ent"));
	return list;
}
// ---------------------------------------------------------
// Human
// ---------------------------------------------------------
function re_novbandit() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\novigrad\nov_1h_club.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\novigrad\nov_1h_mace_t1.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\novigrad\nov_2h_hammer.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\novigrad\nov_1h_sword_t1.w2ent")); 
	return list;
}
function re_pirate() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_pirates_axe_normal.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_pirates_blunt.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_pirates_bow.w2ent", 2));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_pirates_crossbow.w2ent", 1));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_pirates_sword_easy.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_pirates_sword_hard.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_pirates_sword_normal.w2ent"));        
	return list;
}
function re_skelpirate() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_axe1h_hard.w2ent"));
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_axe1h_normal.w2ent"));      
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_axe2h.w2ent", 2));
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_blunt_hard.w2ent"));     
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_blunt_normal.w2ent"));  
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_bow.w2ent", 2));    
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_crossbow.w2ent", 1));    
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_hammer2h.w2ent", 1));
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_swordshield.w2ent"));
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_sword_easy.w2ent"));
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_sword_hard.w2ent"));
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_pirate_sword_normal.w2ent"));	
	return list;
}
function re_bandit() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
    list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_deserters_axe_normal.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_deserters_bow.w2ent", 3));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nml_deserters_sword_easy.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\novigrad_bandit_shield_1haxe.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\novigrad_bandit_shield_1hclub.w2ent"));        	
	return list;
}
function re_nilf() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nilfgaardian_deserter_bow.w2ent", 3));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nilfgaardian_deserter_shield.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\nilfgaardian_deserter_sword_hard.w2ent")); 
	return list;
}
function re_cannibal() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\lw_giggler_boss.w2ent", 1));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\lw_giggler_melee.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\lw_giggler_melee_spear.w2ent", 3));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\lw_giggler_ranged.w2ent", 3));        	
	return list;
}
function re_renegade() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_2h_axe.w2ent", 2));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_axe.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_blunt.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_boss.w2ent", 1));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_bow.w2ent", 2));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_crossbow.w2ent", 1));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_shield.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_sword_hard.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\baron_renegade_sword_normal.w2ent"));  
	return list;
}
function re_skelbandit() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_1h_axe_t1.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_1h_club.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_bow.w2ent", 3));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_2h_spear.w2ent", 3));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_shield_axe_t1.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_shield_club.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_1h_axe_t2.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_1h_sword.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_shield_axe_t2.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\skellige\ske_shield_sword.w2ent"));       
	return list;
}
function re_skel2bandit() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_axe1h_normal.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_axe1h_hard.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_blunt_normal.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_blunt_hard.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_shield_axe1h_normal.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_shield_mace1h_normal.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_axe2h.w2ent", 2));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_sword_easy.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_sword_hard.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_sword_normal.w2ent"));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_hammer2h.w2ent", 1));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_bow.w2ent", 2));        
	list.PushBack(AddEnemyTemplate("living_world\enemy_templates\skellige_bandit_crossbow.w2ent", 1));        
	return list;
}
function re_whunter() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\inquisition\inq_1h_sword_t2.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\inquisition\inq_1h_mace_t2.w2ent"));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\inquisition\inq_crossbow.w2ent", 2));        
	list.PushBack(AddEnemyTemplate("gameplay\templates\characters\presets\inquisition\inq_2h_sword.w2ent"));        
	return list;
}
// ---------------------------------------------------------
// Wild Hunt
// ---------------------------------------------------------
function re_whh() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wildhunt_minion_lvl1.w2ent"));	// hound of the wild hunt   
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wildhunt_minion_lvl2.w2ent"));	// spikier hound
	return list;
}
function re_wildhunt() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("quests\part_2\quest_files\q403_battle\characters\q403_wild_hunt_2h_axe.w2ent", 2));        
	list.PushBack(AddEnemyTemplate("quests\part_2\quest_files\q403_battle\characters\q403_wild_hunt_2h_halberd.w2ent", 2));	
	list.PushBack(AddEnemyTemplate("quests\part_2\quest_files\q403_battle\characters\q403_wild_hunt_2h_hammer.w2ent", 1));	
	list.PushBack(AddEnemyTemplate("quests\part_2\quest_files\q403_battle\characters\q403_wild_hunt_2h_spear.w2ent", 2));	
	list.PushBack(AddEnemyTemplate("quests\part_2\quest_files\q403_battle\characters\q403_wild_hunt_2h_sword.w2ent"));
	return list;
}
// ---------------------------------------------------------
// Ground
// ---------------------------------------------------------
function re_arachas() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\arachas_lvl1.w2ent"));       
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\arachas_lvl2__armored.w2ent"));	
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\arachas_lvl3__poison.w2ent"));
	return list;
}
function re_cyclop() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\cyclop_lvl1.w2ent"));
	return list;
}
function re_leshen() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\lessog_lvl1.w2ent"));  
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\lessog_lvl2__ancient.w2ent"));
	if(theGame.GetDLCManager().IsEP2Available()  &&   theGame.GetDLCManager().IsEP2Enabled()){
		list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\spriggan.w2ent"));
	}
	return list;
}
function re_werewolf() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\werewolf_lvl1.w2ent"));        
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\werewolf_lvl3__lycan.w2ent"));	
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\werewolf_lvl4__lycan.w2ent"));	
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\werewolf_lvl5__lycan.w2ent"));
	return list;
}
function re_fiend() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\bies_lvl1.w2ent"));  // fiends        
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\bies_lvl2.w2ent"));  // red fiend
	return list;
}
function re_chort() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\czart_lvl1.w2ent")); // chort
	return list;
}
function re_bear() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\bear_lvl1__black.w2ent"));			// black, like it says :)      
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\bear_lvl2__grizzly.w2ent"));			// light brown	
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\bear_lvl3__grizzly.w2ent"));			// light brown	
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\bear_berserker_lvl1.w2ent"));		// red/brown	
	return list;
}
function re_skelbear() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\bear_lvl3__white.w2ent"));			// polarbear
	return list;
}
function re_golem() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\golem_lvl1.w2ent"));					// normal greenish golem        
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\golem_lvl2__ifryt.w2ent"));			// fire golem	
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\golem_lvl3.w2ent"));					// weird yellowish golem
	return list;
}
function re_elemental() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\elemental_dao_lvl1.w2ent"));			// earth elemental        
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\elemental_dao_lvl2.w2ent"));			// stronger and cliffier elemental
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\elemental_dao_lvl3__ice.w2ent"));
	if(theGame.GetDLCManager().IsEP2Available()  &&   theGame.GetDLCManager().IsEP2Enabled()){
		list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\mq7007_item__golem_grafitti.w2ent"));
	}
	return list;
}
function re_ekimmara() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\vampire_ekima_lvl1.w2ent"));		// white vampire
	return list;
}
function re_katakan() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\vampire_katakan_lvl1.w2ent"));	// cool blinky vampire     
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\vampire_katakan_lvl3.w2ent"));	// cool blinky vamp
	return list;
}
function re_nightwraith() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\nightwraith_lvl1.w2ent"));       
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\nightwraith_lvl2.w2ent"));        
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\nightwraith_lvl3.w2ent"));
	return list;
}
function re_noonwraith() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\noonwraith_lvl1.w2ent"));
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\noonwraith_lvl2.w2ent"));
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\noonwraith_lvl3.w2ent"));
	return list;
}
function re_troll() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\troll_cave_lvl1.w2ent"));		// grey
	return list;
}
function re_skeltroll() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\troll_cave_lvl3__ice.w2ent"));	// ice   
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\troll_cave_lvl4__ice.w2ent"));	// ice
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\troll_ice_lvl13.w2ent"));		// ice
	return list;
}
function re_hag() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\hag_grave_lvl1.w2ent"));					// grave hag 1        
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\hag_water_lvl1.w2ent"));					// grey  water hag    
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\hag_water_lvl2.w2ent"));					// greenish water hag
	return list;
}
// ---------------------------------------------------------
// Group
// ---------------------------------------------------------
function re_harpy() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\harpy_lvl1.w2ent"));				// harpy
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\harpy_lvl2.w2ent"));				// harpy
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\harpy_lvl2_customize.w2ent"));		// harpy
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\harpy_lvl3__erynia.w2ent", 1));		// harpy
	return list;
}
function re_endrega() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\endriaga_lvl1__worker.w2ent"));    	// small endrega
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\endriaga_lvl2__tailed.w2ent", 2));	  	// bigger tailed endrega
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\endriaga_lvl3__spikey.w2ent", 1));	  	// big tailless endrega
	return list;
}
function re_fogling() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\fogling_lvl1.w2ent"));			  	// normal fogling
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\fogling_lvl2.w2ent"));				// normal fogling
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\fogling_lvl3__willowisp.w2ent"));	// green fogling
	return list;
}
function re_ghoul() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\ghoul_lvl1.w2ent"));					// normal ghoul   spawns from the ground
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\ghoul_lvl2.w2ent"));					// red ghoul   spawns from the ground
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\ghoul_lvl3.w2ent"));	
	return list;
}
function re_alghoul() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\alghoul_lvl1.w2ent"));				// dark
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\alghoul_lvl2.w2ent"));				// dark reddish
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\alghoul_lvl3.w2ent"));				// greyish
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\alghoul_lvl4.w2ent"));
	return list;
}
function re_nekker() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\nekker_lvl1.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\nekker_lvl2.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\nekker_lvl2_customize.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\nekker_lvl3_customize.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\nekker_lvl3__warrior.w2ent", 2));
	return list;
}
function re_drowner() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\drowner_lvl1.w2ent"));				// drowner
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\drowner_lvl2.w2ent"));				// drowner
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\drowner_lvl3.w2ent"));				// pink drowner
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\drowner_lvl4__dead.w2ent", 2));
	return list;
}function re_rotfiend() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\rotfiend_lvl1.w2ent"));        
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\rotfiend_lvl2.w2ent", 1));
	return list;
}function re_wolf() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wolf_lvl1.w2ent"));				// +4 lvls	grey/black wolf STEEL
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wolf_lvl1__alpha.w2ent", 1));		// +4 lvls brown warg  		STEEL
	return list;
}function re_skelwolf() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wolf_white_lvl2.w2ent"));		// lvl 51 white wolf		STEEL     
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wolf_white_lvl3__alpha.w2ent", 1));	// lvl 51 white wolf 		STEEL  37
	return list;
}
function re_wraith() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wraith_lvl1.w2ent"));			// all look the bloody same....
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wraith_lvl2.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wraith_lvl2_customize.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wraith_lvl3.w2ent"));
    list.PushBack(AddEnemyTemplate("characters\npc_entities\monsters\wraith_lvl4.w2ent", 2));
	return list;
}
function re_spider() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\ep1\data\characters\npc_entities\monsters\black_spider.w2ent"));
    list.PushBack(AddEnemyTemplate("dlc\ep1\data\characters\npc_entities\monsters\black_spider_large.w2ent",2));
	return list;
}
function re_boar() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\ep1\data\characters\npc_entities\monsters\wild_boar_ep1.w2ent",2));
	return list;
}
function re_detlaff() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\dettlaff_vampire.w2ent"));
	return list;
}
function re_skeleton() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\nightwraith_banshee_summon.w2ent"));
    list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\nightwraith_banshee_summon_skeleton.w2ent"));
	return list;
}
function re_barghest() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\barghest.w2ent"));
	return list;
}
function re_bruxa() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\bruxa.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\bruxa_alp.w2ent"));
	return list;
}
function re_echinops() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\echinops_hard.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\echinops_normal.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\echinops_normal_lw.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\echinops_turret.w2ent"));
	return list;
}
function re_fleder() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\fleder.w2ent"));
	return list;
}
function re_garkain() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\garkain.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\garkain_mh.w2ent"));
	return list;
}
function re_gravier() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\gravier.w2ent")); // fancy drowner
	return list;
}
function re_kikimore() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\kikimore.w2ent",2));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\kikimore_small.w2ent"));
	return list;
}
function re_panther() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\panther_black.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\panther_leopard.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\panther_mountain.w2ent"));
	return list;
}
function re_giant() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\q701_dagonet_giant.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\q704_cloud_giant.w2ent"));
	return list;
}
function re_centipede() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\scolopendromorph.w2ent")); //worm
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\mq7023_albino_centipede.w2ent"));
	return list;
}
function re_sharley() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\sharley.w2ent"));  // rock boss things
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\sharley_mh.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\sharley_q701.w2ent"));
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\sharley_q701_normal_scale.w2ent"));
	return list;
}
function re_wight() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\spooncollector.w2ent",1));  // spoon
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\wicht.w2ent",2));     // wight
	return list;
}
function re_bruxacity() : array<SEnemyTemplate>{var list : array<SEnemyTemplate>;
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\bruxa_alp_cloak_always_spawn.w2ent"));  // spoon
	list.PushBack(AddEnemyTemplate("dlc\bob\data\characters\npc_entities\monsters\bruxa_cloak_always_spawn.w2ent"));     // wight
	return list;
}