class CRandomEncounterInitializer extends CEntityMod {
    default modName = 'Random Encounters';
    default modAuthor = "erxv";
    default modUrl = "http://www.nexusmods.com/witcher3/mods/785?";
    default modVersion = '1.31';

    default logLevel = MLOG_DEBUG;

    default template = "dlc\modtemplates\randomencounterdlc\data\re_initializer.w2ent";
}

function modCreate_RandomEncounters() : CMod {
    return new CRandomEncounterInitializer in thePlayer;
}

enum EEncounterType
{
    ET_GROUND   = 1,
    ET_FLYING   = 2,
    ET_HUMAN    = 3,
    ET_GROUP    = 4,
    ET_WILDHUNT = 5,
};

enum EGroundEncounterType
{
    GE_SOLO  = 0,
    GE_GROUP = 1,
};


enum EHumanType
{
    HT_BANDIT       = 1,
    HT_NOVBANDIT    = 2,
    HT_SKELBANDIT   = 3,
    HT_SKELBANDIT2  = 4,
    HT_CANNIBAL     = 5,
    HT_RENEGADE     = 6,
    HT_PIRATE       = 7,
    HT_SKELPIRATE   = 8,
    HT_NILFGAARDIAN = 9,
    HT_WITCHHUNTER  = 10,
}

enum EGroundMonsterType
{
    GM_LESHEN      = 1,
    GM_WEREWOLF    = 2,
    GM_FIEND       = 3,
    GM_EKIMMARA    = 4,
    GM_KATAKAN     = 5,
    GM_BEAR        = 6,
    GM_GOLEM       = 7,
    GM_ELEMENTAL   = 8,
    GM_NIGHTWRAITH = 9,
    GM_NOONWRAITH  = 10,
    GM_CHORT       = 11,
    GM_ARACHAS     = 12,
    GM_CYCLOPS     = 13,
    GM_TROLL       = 14,
    GM_HAG         = 15,
    GM_FOGLET      = 16,
    GM_ENDREGA     = 17,
    GM_GHOUL       = 18,
    GM_ALGHOUL     = 19,
    GM_NEKKER      = 20,
    GM_DROWNER     = 21,
    GM_ROTFIEND    = 22,
    GM_WOLF        = 23,
    GM_WRAITH      = 24,
    GM_HARPY       = 25,
    GM_SPIDER      = 26,
	GM_BARGHEST	   = 27,
	GM_BRUXA	   = 28,
	GM_ECHINOPS	   = 29,
	GM_CENTIEDE    = 30,
	GM_KIKIMORE	   = 31,
	GM_FLEDER	   = 32,
	GM_GARKAIN	   = 33,
	GM_DETLAFF	   = 34,
	GM_DROWNERDLC  = 35,	
	GM_BOAR  	   = 36,	
	GM_GIANTDLC	   = 37,	
	GM_PANTHER	   = 38,	
	GM_SHARLEY	   = 39,
	GM_SKELETON	   = 40,
	GM_WIGHT	   = 41,
	GM_VAMPIRE     = 42,
};

enum EFlyingMonsterType
{
    FM_GRYPHON     		= 1,
    FM_GRYPHONDLC  		= 2,
	FM_COCKATRICE  		= 3,
    FM_COCKATRICEDLC 	= 4, 
	FM_BASILISK 		= 5,
	FM_BASILISKDLC	 	= 6,
	FM_WYVERN      		= 7,
    FM_FORKTAIL    		= 8,    
};



statemachine class CRandomEncounters extends CEntity {
	private		var rExtra		: CModRExtra;
	
	
	private var pathToFlyingDummy		: string;  default pathToFlyingDummy		= "dlc\modtemplates\randomencounterdlc\data\re_flying.w2ent";
	private var pathToGroundDummy 		: string;  default pathToGroundDummy 		= "dlc\modtemplates\randomencounterdlc\data\re_ground_solo.w2ent";
	private var pathToGroupDummy 		: string;  default pathToGroupDummy 		= "dlc\modtemplates\randomencounterdlc\data\re_ground_group.w2ent";
	private var pathToGroupAlphaDummy 	: string;  default pathToGroupAlphaDummy 	= "dlc\modtemplates\randomencounterdlc\data\re_ground_group_alpha.w2ent";
	private var pathToHumanDummy 		: string;  default pathToHumanDummy 		= "dlc\modtemplates\randomencounterdlc\data\re_human.w2ent";
	private var pathToWHDummy 			: string;  default pathToWHDummy 			= "dlc\modtemplates\randomencounterdlc\data\re_wild_hunt.w2ent";
	

	private     var isPlayerNearWater, isPlayerInForest, isPlayerInSwamp, isPlayerInSwampForest : bool;
	
	
	private		var customFlying, customGround, customGroup : bool;
	
	
	private 	var isFlyingActiveD, isGroundActiveD, isHumanActiveD, isGroupActiveD, isWildHuntActiveD : int;
    private 	var isFlyingActiveN, isGroundActiveN, isHumanActiveN, isGroupActiveN, isWildHuntActiveN : int;
	
	protected var isGryphonsD, isCockatriceD, isWyvernsD, isForktailsD, isBasiliskD : int;
    protected var isGryphonsN, isCockatriceN, isWyvernsN, isForktailsN, isBasiliskN : int;
    protected var isCGryphons, isCCockatrice, isCWyverns, isCForktails, isCBasilisk : bool;
	
	
	protected var isLeshensD, isWerewolvesD, isFiendsD, isBearsD, isGolemsD, isElementalsD, isHarpyD, isCyclopsD, isArachasD, isTrollD, isBoarD : int;
    protected var isNightWraithsD, isNoonWraithsD, isHagsD, isFoglingD, isEndregaD, isGhoulsD, isAlghoulsD, isChortsD, isEkimmaraD, isKatakanD, isBruxaD : int;
    protected var isNekkersD, isWildhuntHoundsD, isWildhuntSoldiersD, isDrownersD, isRotfiendsD, isWolvesD, isWraithsD, isHigherVampD, isFlederD, isGarkainD : int;
    protected var isSpidersD, isPantherD, isSharleyD, isGiantD, isBarghestD, isEchinopsD, isCentipedeD, isKikimoreD, isWightD, isDrownerDLCD, isSkeletonD : int;

	
    protected var isLeshensN, isWerewolvesN, isFiendsN, isBearsN, isGolemsN, isElementalsN, isHarpyN, isCyclopsN, isArachasN, isTrollN, isBoarN : int;
    protected var isNightWraithsN, isNoonWraithsN, isHagsN, isFoglingN, isEndregaN, isGhoulsN, isAlghoulsN, isChortsN, isWightN, isEchinopsN, isDrownerDLCN : int;
    protected var isNekkersN, isDrownersN, isRotfiendsN, isWolvesN, isWraithsN, isBruxaN, isHigherVampN, isGarkainN, isFlederN, isKikimoreN, isSkeletonN : int;
    protected var isSpidersN, isWildhuntHoundsN, isWildhuntSoldiersN, isEkimmaraN, isKatakanN, isPantherN, isSharleyN, isGiantN, isBarghestN, isCentipedeN : int;
	
	
	
	protected var isCHarpy, isCCyclops, isCArachas, isCChorts, isCTroll, isCEkimmara, isCKatakan, isCBruxa, isCHigherVamp, isCFleder, isCGarkain : bool;
    protected var isCLeshens, isCWerewolves, isCFiends, isCVampires, isCBears, isCGolems, isCElementals, isCPanther, isCSharley, isCGiant, isCBoar : bool;
    protected var isCNightWraiths, isCNoonWraiths, isCHags, isCFogling, isCEndrega, isCGhouls, isCAlghouls, isCNekkers, isCKikimore, isCWight : bool;
    protected var isCDrowners, isCRotfiends, isCWolves, isCWraiths, isCSpiders, isCSkeleton, isCDrownerDLC, isCBarghest, isCEchinops, isCCentipede : bool;
	
	
	
	
	protected var novbandit, pirate, skelpirate, bandit, nilf, cannibal, renegade, skelbandit, skel2bandit, whunter: array<SEnemyTemplate>;
    protected var gryphon, gryphonf, forktail, wyvern, cockatrice, cockatricef, basilisk, basiliskf, wight, sharley  : array<SEnemyTemplate>;
    protected var fiend, chort, wildHunt, endrega, fogling, ghoul, alghoul, bear, skelbear, golem, elemental, hag, nekker : array<SEnemyTemplate>;
    protected var ekimmara, katakan, whh, drowner, rotfiend, nightwraith, noonwraith, troll, skeltroll, wolf, skelwolf, wraith : array<SEnemyTemplate>;
    protected var spider, harpy, leshen, werewolf, cyclop, arachas, vampire, skelelemental, bruxacity : array<SEnemyTemplate>;
	protected var centipede, giant, panther, kikimore, gravier, garkain, fleder, echinops, bruxa, barghest, skeleton, detlaff, boar : array<SEnemyTemplate>;
	
	protected var isHosActive, isBWActive : bool;
	private var chanceDay, chanceNight : int;
	protected	var selectedDifficulty	: int;
	
	
	protected	var customDayMax, customDayMin, customNightMax, customNightMin	: int;
	protected   var flyingMonsterHunts, groundMonsterHunts, groupMonsterHunts	: int;
	protected   var customFrequency, enableTrophies : bool;

	private var tempArray : array<SEnemyTemplate>;
	private var bArray : array<string>;
	protected var activeMonsterCount : int;
	protected var currentZone : EREZone;
	
	var cityBruxa, citySpawn, howLong : int;
	


	event OnSpawned( spawnData : SEntitySpawnData ){
		var ents : array<CEntity>;
		
		theGame.GetEntitiesByTag('RandomEncounterTag', ents);
		
		
		
		if(ents.Size() > 1){
			this.Destroy();
		}else{
			this.AddTag('RandomEncounterTag');
			theInput.RegisterListener(this, 'OnRefreshSettings', 'RefreshRESettings');
			theInput.RegisterListener(this, 'OnSpawnMonster', 'RandomEncounter');
		
			super.OnSpawned( spawnData );
			
			rExtra = new CModRExtra in this;

			InitateRandomEncounters();		
		}		
	}
	
	event OnRefreshSettings(action: SInputAction){
		if (IsPressed(action)) {
			getXMLSettings(true);
		}
	}
	
	event OnSpawnMonster(action: SInputAction){
		if (IsPressed(action)) {
			AddTimer('InScene',0.1,false);
		}
	}

	function InitateRandomEncounters(){
		
		isHosActive = false;
		if(  theGame.GetDLCManager().IsEP1Available()  &&   theGame.GetDLCManager().IsEP1Enabled()  )
			isHosActive = true;
		
		isBWActive = false;
		if(  theGame.GetDLCManager().IsEP2Available()  &&   theGame.GetDLCManager().IsEP2Enabled()  )
			isBWActive = true;
		
		
		
		bArray.PushBack("quests\prologue\quest_files\living_world\entities\clues\blood\lw_clue_blood_splat_big.w2ent");	
		bArray.PushBack("quests\prologue\quest_files\living_world\entities\clues\blood\lw_clue_blood_splat_medium.w2ent");		
		bArray.PushBack("quests\prologue\quest_files\living_world\entities\clues\blood\lw_clue_blood_splat_medium_2.w2ent");	
		bArray.PushBack("living_world\treasure_hunting\th1003_lynx\entities\generic_clue_blood_splat.w2ent");
		
		novbandit = re_novbandit();
		pirate = re_pirate();
		skelpirate = re_skelpirate();
		bandit = re_bandit();
		nilf = re_nilf();
		cannibal = re_cannibal();
		renegade = re_renegade();
		skelbandit = re_skelbandit();
		skel2bandit = re_skel2bandit();
		whunter = re_whunter();
		gryphon = re_gryphon();
		//gryphonf = re_gryphonf();
		forktail = re_forktail();
		wyvern = re_wyvern();
		cockatrice = re_cockatrice();
		//cockatricef = re_cockatricef();
		basilisk = re_basilisk();
		//basiliskf = re_basiliskf();
		fiend = re_fiend();
		chort = re_chort();
		endrega = re_endrega();
		fogling = re_fogling();
		ghoul = re_ghoul();
		alghoul = re_alghoul();
		bear = re_bear();
		skelbear = re_skelbear();
		golem = re_golem();
		elemental = re_elemental();
		hag = re_hag();
		nekker = re_nekker();
		ekimmara = re_ekimmara();
		katakan = re_katakan();
		whh = re_whh();
		wildHunt = re_wildhunt();
		drowner = re_drowner();
		rotfiend = re_rotfiend();
		nightwraith = re_nightwraith();
		noonwraith = re_noonwraith();
		troll = re_troll();
		skeltroll = re_skeltroll();
		wolf = re_wolf();
		skelwolf = re_skelwolf();
		wraith = re_wraith();		
		harpy = re_harpy();
		leshen = re_leshen();
		werewolf = re_werewolf();
		cyclop = re_cyclop();
		arachas = re_arachas();
		bruxacity = re_bruxacity();
		
		if(isBWActive){
			wight = re_wight();
			sharley = re_sharley();
			centipede = re_centipede();
			giant = re_giant();
			panther = re_panther();
			kikimore = re_kikimore();
			gravier = re_gravier();
			garkain = re_garkain();
			fleder = re_fleder();
			echinops = re_echinops();
			bruxa = re_bruxa();
			barghest = re_barghest();
			skeleton = re_skeleton();
			detlaff = re_detlaff();			
		}
		
		if(isHosActive){
			spider = re_spider();
			boar = re_boar();
		}
		

		getXMLSettings( false );
		
		AddTimer('RandomEncounterTick', 1.0, true);	
		AddTimer('RandomEncounterEnabled', 3.0, false);	
	}
	
	timer function RandomEncounterEnabled ( optional dt : float, optional id : Int32 )	{
		theGame.GetGuiManager().ShowNotification("Random Encounters Mod Enabled");
	}

	timer function RandomEncounterTick ( optional dt : float, optional id : Int32 )	{
		var inv : CInventoryComponent;
		var horseManInv : CInventoryComponent;
		var allItems : array<SItemUniqueId>;
		var horseManItems : array<SItemUniqueId>;
		var i : int;
		var a : bool;
		
		/*
		chanceTmp   = RoundTo(StringToFloat(chanceDay), 2) / 100.0f;
        chanceTmp   = RoundTo(((1 - PowF((1 - chanceTmp), (1 / 60.0f))) * 100), 4);
        chanceDay   = FloorF(chanceTmp * 10000);
        chanceTmp   = RoundTo(StringToFloat(chanceNight), 2) / 100.0f;
        chanceTmp   = RoundTo(((1 - PowF((1 - chanceTmp), (1 / 60.0f))) * 100), 4);
        chanceNight = FloorF(chanceTmp * 10000);
		
		*/
		
		
		
		if(howLong <= 0){
			AddTimer('InScene',0.1,false);
		}else if(howLong == 6000 || howLong == 3000){
			howLong = CalculateTimeToNextEncounter();
		}else{
			howLong -= 1;
		}


		if( enableTrophies ){
			inv = thePlayer.GetInventory();		
			allItems.Clear();		
			allItems = inv.GetItemsByTag('Custom_Trophy');
			horseManInv = GetWitcherPlayer().GetAssociatedInventory();
			horseManItems.Clear();
			horseManItems = horseManInv.GetItemsByTag('Custom_Trophy');
			if(!thePlayer.IsInCombat())
			{
				if(allItems.Size() >= 1)
				{	
					for(i=0; i<=allItems.Size(); i+=1)
					{
						inv.RemoveItemTag( allItems[i], 'Custom_Trophy' );									
					}
					AddTimer('Cutscene',0.1,false);				
				}
				if(horseManItems.Size() >= 1)
				{		
					for(i=0; i<=horseManItems.Size(); i+=1)
					{
						horseManInv.RemoveItemTag( horseManItems[i], 'Custom_Trophy' );									
					}
					AddTimer('Cutscene',0.1,false);				
				}
			}
		}
		
	}
	
	public function CalculateTimeToNextEncounter() : int {
	
		if(customFrequency){
			if(theGame.envMgr.IsNight() ){				
				howLong = RandRange(customNightMin, customNightMax);		
			}else{
				howLong = RandRange(customDayMin, customDayMax);		
			}
		}else{
			if(theGame.envMgr.IsNight() ){	

				switch(chanceNight){
				case 0:
					howLong = 99999;					
					break;
				case 1:
					howLong = RandRange(1400, 3200);	
					break;
				case 2:
					howLong = RandRange(800, 1600);	
					break;
				case 3:
					howLong = RandRange(500, 900);	
					break;
				}				
			}else{
				switch(chanceDay){
				case 0:
					howLong = 99999;					
					break;
				case 1:
					howLong = RandRange(1400, 3900);	
					break;
				case 2:
					howLong = RandRange(800, 1800);	
					break;
				case 3:
					howLong = RandRange(500, 1100);	
					break;
				}				
			}
		}

		return howLong;
	}
	
	
	timer function Cutscene ( optional dt : float, optional id : Int32 )
	{
		var scene : CStoryScene;
		
		scene = (CStoryScene)LoadResource( "dlc\modtemplates\randomencounterdlc\data\mh_taking_trophy_no_dialogue.w2scene", true);	
		theGame.GetStorySceneSystem().PlayScene(scene, "Input");
	}
	
	
	
	timer function PlayerLocation ( optional dt : float, optional id : Int32 )	{
		currentZone = rExtra.getCustomZone(thePlayer.GetWorldPosition());
		SetPlayerArea();
		
		AddTimer('Start',0.1,false);
	}
	
	private var notInScene : bool;
	timer function InScene ( optional dt : float, optional id : Int32 )	{
		var isMeditating : CName;
		
		isMeditating = thePlayer.GetCurrentStateName();
		
		
		if( (isMeditating != 'Meditation' && isMeditating != 'MeditationWaiting') && !thePlayer.IsInInterior() && !thePlayer.IsInCombat() && !thePlayer.IsUsingBoat() && !thePlayer.IsInFistFightMiniGame() && !thePlayer.IsSwimming() && !theGame.IsDialogOrCutscenePlaying() && !thePlayer.IsInNonGameplayCutscene() && !thePlayer.IsInGameplayScene() && !theGame.IsCurrentlyPlayingNonGameplayScene() && !theGame.IsFading() && !theGame.IsBlackscreen() ){
			notInScene = true;
			AddTimer('PlayerLocation',0.1,false);
		}else{
			notInScene = false;
			howLong = CalculateTimeToNextEncounter()/2;
		}	
	}
	
	timer function Start ( optional dt : float, optional id : Int32 )	{
		var a : bool;
		
		a = OnREPressed();
		if(a){
			howLong = CalculateTimeToNextEncounter();
		}else{
			howLong = CalculateTimeToNextEncounter()/2;
		}
	}
	
	private function OnREPressed () : bool{
        var choose : array<EEncounterType>;
        var i, random : int;
        var nr : EEncounterType;
        var isFlyingActive, isGroundActive, isHumanActive, isGroupActive, isWildHuntActive, swamp, forest, water : int;
        
        if (theGame.envMgr.IsNight())
        {
            isFlyingActive = isFlyingActiveN;
            isGroundActive = isGroundActiveN;
            isHumanActive = isHumanActiveN;
            isGroupActive = isGroupActiveN;
            isWildHuntActive = isWildHuntActiveN;
        }
        else
        {
            isFlyingActive = isFlyingActiveD;
            isGroundActive = isGroundActiveD;
            isHumanActive = isHumanActiveD;
            isGroupActive = isGroupActiveD;
            isWildHuntActive = isWildHuntActiveD;
        }

        if ( (currentZone != REZ_CITY) && (currentZone != REZ_NOSPAWN) && notInScene )
        {
            if(isPlayerInForest)
                    forest = 2;
                
            if (isGroundActive != 0)    {for (i=0; i<isGroundActive; i+=1)          {choose.PushBack(ET_GROUND);}}
            if (isFlyingActive != 0)    {for (i=0; i<isFlyingActive-forest; i+=1)   {choose.PushBack(ET_FLYING);}}
            if (isHumanActive != 0)	    {for (i=0; i<isHumanActive; i+=1)           {choose.PushBack(ET_HUMAN);}}
            if (isGroupActive != 0)	    {for (i=0; i<isGroupActive; i+=1)           {choose.PushBack(ET_GROUP);}}
            if (isWildHuntActive != 0)  {for (i=0; i<isWildHuntActive; i+=1)        {choose.PushBack(ET_WILDHUNT);}}

            nr = choose[RandRange(choose.Size())];

            switch (nr)
            {
                case ET_GROUND:
                    return whichGround(GE_SOLO);
                    break;
                case ET_FLYING:
                    return OnFlyingCreature(false);
                    break;
                case ET_HUMAN:
                    return OnSpawnHuman();
                    break;
                case ET_GROUP:
                    return whichGround(GE_GROUP);
                    break;
                case ET_WILDHUNT:
                    return OnWildHunt();
                    break;
            }	
        }
		
		return false;
    }
	
	private function OnBruxaCitySpawn() : bool{	
		var pos : Vector;
		var rot : EulerAngles;
		var resourcePathGround : string;
		var GroundTemplate : CEntityTemplate;
		var tempGroundArray : array<SEnemyTemplate>;
		var temp : CEntity;
		var lvl : int;
		var animcomp, meshcomp : CComponent;
		var h : float;

		
		pos = thePlayer.GetWorldPosition();		
		pos = pos + VecConeRand(theCamera.GetCameraHeading(), 270, -15, -10);

        rot = thePlayer.GetWorldRotation();

		rot.Yaw += RandRange(100,250);

		rot.Pitch = 0;
		rot.Roll = 0;
		
		FixZAxis(pos);
		
		tempGroundArray = bruxacity;
		tempGroundArray = PrepareEnemyTemplate(tempGroundArray);	
	
		resourcePathGround = ObtainTemplateForEnemy(tempGroundArray);
		GroundTemplate = (CEntityTemplate)LoadResource( resourcePathGround, true);	
		
		temp = theGame.CreateEntity(GroundTemplate, pos, rot);  
		
		((CNewNPC)temp).SetTemporaryAttitudeGroup( 'friendly_to_player', AGP_Default );							
		((CNewNPC)temp).NoticeActor(thePlayer);
		
		if (selectedDifficulty == 2)
		{				
			if ( GetWitcherPlayer().GetLevel() < 4 )
			{
				lvl = RandRange(5, 0);
			}
			else
			{
				lvl = RandRange(7, 1);
			}
		}
		else if (selectedDifficulty == 1)
		{			
			if ( GetWitcherPlayer().GetLevel() < 4 )
			{
				lvl = RandRange(4, 0);
			}
			else
			{
				lvl = RandRange(6, -2);
			}
		}
		else
		{				
			if ( GetWitcherPlayer().GetLevel() < 4 )
			{
				lvl = RandRange(2, 0);
			}
			else
			{
				lvl = RandRange(3, -7);
			}
		}

		SetEnemyLevel((CNewNPC)temp, GetWitcherPlayer().GetLevel()+lvl);  
		
		animcomp = temp.GetComponentByClassName('CAnimatedComponent');
		meshcomp = temp.GetComponentByClassName('CMeshComponent');
		
		switch (lvl){
		case -7:
		case -6:
			h = 0.83;
			break;
		case -5:
		case -4:
		case -3:
			h = 0.94;
			break;
		case -2:
		case -1:
			h = 0.96;
			break;
		case 0:
			h = 1.0;
			break;
		case 1:
		case 2:
		case 3:
			h = 1.02;
			break;
		case 4:
		case 5:
		case 6:
			h = 1.04;
			break;
		case 7:
		case 8:
		case 9:
			h = 1.06;
			break;
		default:
			h = 1.0;
			break;
		}		

		h += RandRangeF(0.02, -0.02);

		animcomp.SetScale(Vector(h,h,h,1));
		meshcomp.SetScale(Vector(h,h,h,1));
		
		return true;		
	}

	
	protected function PrepareEnemyTemplate( temp : array<SEnemyTemplate> ) : array<SEnemyTemplate>
    {
        var i : int;

        for (i = 0; i < temp.Size(); i += 1)
        {
            temp[i].count = 0;
        }
		
		return temp;
    }
	
	protected function ObtainTemplateForEnemy( tempArray : array<SEnemyTemplate> ) : string
    {
        var i : int;
        var _tempArray : array<SEnemyTemplate>;
        var _templateid : int;
        var _template : SEnemyTemplate;

        for (i = 0; i < tempArray.Size(); i += 1)
        {
            if (tempArray[i].max < 0 || tempArray[i].count < tempArray[i].max)
            {
                _tempArray.PushBack(tempArray[i]);
            }
        }

        _templateid = RandRange(_tempArray.Size());
        _template = _tempArray[_templateid];

        for (i = 0; i < tempArray.Size(); i += 1)
        {
            if (tempArray[i] == _template)
            {
                tempArray[i].count += 1;
                break;
            }
        }

        return _template.template;
    }

	
	var usedTemplate : array<CEntityTemplate>;	
	protected function SpawnEntity( temp : CEntityTemplate, optional pos : Vector, optional rot : EulerAngles, optional highVisibility : bool) : CEntity {
		var entity : CEntity;		
		var mesh : CMesh;
		var meshComp : array<CMeshComponent>;
		var comp : array<CComponent>;
		var i : int;		
		
		entity = theGame.CreateEntity( temp, pos, rot );
		
		if(!usedTemplate.Contains(temp) && highVisibility){
			comp = entity.GetComponentsByClassName('CMeshComponent');
			for(i = 0; i < comp.Size(); i+=1){
				meshComp.PushBack(  ((CMeshComponent)comp[i])  );
			}
			
			for(i = 0; i < meshComp.Size(); i+=1){
				meshComp[i].mesh.autoHideDistance = 500;
			}
			
			entity.Destroy();
			entity = theGame.CreateEntity( temp, pos, rot );
			
			usedTemplate.PushBack(temp);
		}
		
		return entity;
	}
	
	
	
	
	
	
	private function OnFlyingCreature ( optional passive : bool ) : bool
    {
        var str, str1, str2, resourcePath, currentArea, resourcePathBlood, resourcePathFlying : string;
        var FlyingTemplate, template, BloodTemplate : CEntityTemplate;
        var lvl, i, j, rando : int;
        var nr : EFlyingMonsterType;
        var Int1, Int2, h, z : float;
        var pos, posPrev: Vector;		
        var temp7, temp, temp2 : CEntity;
		var tempx : CRandomEncounterFlyingNPCEntity;
        var choose : array<EFlyingMonsterType>;	
        var meshcomp, animcomp : CComponent;
        var rot	: EulerAngles;	
        var inRangeEntities  : array<CGameplayEntity>;		
        var isGryphons, isCockatrice, isWyverns, isForktails, isBasilisk : int;
        var vectorArray : array<Vector>;
        var bloodArray	: array<CEntity>;
		var tempFlyingArray : array<SEnemyTemplate>;
		var isHunt : bool;
		
        currentArea = AreaTypeToName(theGame.GetCommonMapManager().GetCurrentArea());
        
        if (customFlying)
        {
            if (theGame.envMgr.IsNight())
            {
                isGryphons = isGryphonsN;
                isCockatrice = isCockatriceN;
				isBasilisk = isBasiliskN;
                isWyverns = isWyvernsN;
                isForktails = isForktailsN;
            }
            else
            {
                isGryphons = isGryphonsD;
                isCockatrice = isCockatriceD;
				isBasilisk = isBasiliskD;
                isWyverns = isWyvernsD;
                isForktails = isForktailsD;
            }

            if (currentArea == "prolog_village")
            {
                if (isCockatrice != 0)	{for (i=0; i<isCockatrice; i+=1){choose.PushBack(FM_COCKATRICE);}}
				if (isBasilisk != 0)	{for (i=0; i<isBasilisk; i+=1){choose.PushBack(FM_BASILISK);}}
                if (isGryphons != 0)	{for (i=0; i<isGryphons; i+=1)  {choose.PushBack(FM_GRYPHON); }}

                if (choose.Size() == 0) return false;

                nr = choose[RandRange(choose.Size())];

                switch (nr)
                {
                    case FM_COCKATRICE:
                        tempArray = cockatrice;
                        break;
                    case FM_GRYPHON:
                        tempArray = gryphon;
                        break;
					case FM_BASILISK:
                        tempArray = basilisk;
                        break;
                }
            }
            else if (currentArea == "skellige" || currentArea == "novigrad" || currentArea == "kaer_morhen" || currentArea == "no_mans_land" || currentArea == "bob")
            {
                if (isWyverns != 0)		{for (i=0; i<isWyverns; i+=1)	{choose.PushBack(FM_WYVERN);}}
                if (isForktails != 0)	{for (i=0; i<isForktails; i+=1) {choose.PushBack(FM_FORKTAIL);}}
                if (isCockatrice != 0)
                {
                    Int1=((10-flyingMonsterHunts)/10.0f)*isCockatrice;
                    Int2=isCockatrice-Int1;
                    for (i=0; i<RoundMath(Int1); i+=1)	{choose.PushBack(FM_COCKATRICE);}
                    for (i=0; i<RoundMath(Int2); i+=1)	{choose.PushBack(FM_COCKATRICEDLC);}
                }
				if (isBasilisk != 0)
                {
                    Int1=((10-flyingMonsterHunts)/10.0f)*isBasilisk;
                    Int2=isBasilisk-Int1;
                    for (i=0; i<RoundMath(Int1); i+=1)	{choose.PushBack(FM_BASILISK);}
                    for (i=0; i<RoundMath(Int2); i+=1)	{choose.PushBack(FM_BASILISKDLC);}
                }	
                if (isGryphons != 0)
                {
                    Int1=((10-flyingMonsterHunts)/10.0f)*isGryphons;
                    Int2=isGryphons-Int1;
                    for (i=0; i<RoundMath(Int1); i+=1)	{choose.PushBack(FM_GRYPHON);}
                    for (i=0; i<RoundMath(Int2); i+=1)	{choose.PushBack(FM_GRYPHONDLC);}
                }
                
                if (choose.Size() == 0) return false;

                nr = choose[RandRange(choose.Size())];

                switch (nr)
                {
                    case FM_WYVERN:
                        tempArray = wyvern;
                        break;
                    case FM_FORKTAIL:
                        tempArray = forktail;
                        break;
                    case FM_COCKATRICE:
                        tempArray = cockatrice;
                        break;
                    case FM_COCKATRICEDLC:
                        tempArray = cockatricef;
                        break;
					case FM_BASILISK:
                        tempArray = basilisk;
                        break;
					case FM_BASILISKDLC:
                        tempArray = basiliskf;
                        break;
                    case FM_GRYPHON:
                        tempArray = gryphon;
                        break;
                    case FM_GRYPHONDLC:
                        tempArray = gryphonf;
                        break;
                }
            }
            else
            {
                return false;
            }
        }
        else
        {
            if (currentArea == "prolog_village")
            {
                if (isCCockatrice)	{for (i=0; i<2; i+=1)	{choose.PushBack(FM_COCKATRICE);}}
                if (isCGryphons)	{for (i=0; i<3; i+=1)	{choose.PushBack(FM_GRYPHON);}}
				if (isCBasilisk)	{for (i=0; i<2; i+=1)	{choose.PushBack(FM_BASILISK);}}
                
                if (choose.Size() == 0) return false;

                nr = choose[RandRange(choose.Size())];

                switch (nr)
                {
                    case FM_COCKATRICE:
                        tempArray = cockatrice;
                        break;
                    case FM_GRYPHON:
                        tempArray = gryphon;
                        break;
					case FM_BASILISK:
                        tempArray = basilisk;
                        break;
                }
            }
            else if (currentArea == "skellige" || currentArea == "novigrad" || currentArea == "kaer_morhen" || currentArea == "no_mans_land" || currentArea == "bob")
            {
                if(RandRange(10) < (10-flyingMonsterHunts))
                {
                    if (isCWyverns)		{for (i=0; i<3; i+=1){choose.PushBack(FM_WYVERN);}}
                    if (isCForktails)	{for (i=0; i<2; i+=1){choose.PushBack(FM_FORKTAIL);}}		
                }
                if (isCCockatrice)
                {
                    Int1=((10-flyingMonsterHunts)/10.0f)*3;
                    Int2=3-Int1;
                    for (i=0; i<RoundMath(Int1); i+=1) {choose.PushBack(FM_COCKATRICE);}
                    for (i=0; i<RoundMath(Int2); i+=1) {choose.PushBack(FM_COCKATRICEDLC);}
                }
				if (isCBasilisk)
                {
                    Int1=((10-flyingMonsterHunts)/10.0f)*3;
                    Int2=3-Int1;
                    for (i=0; i<RoundMath(Int1); i+=1)	{choose.PushBack(FM_BASILISK);}
                    for (i=0; i<RoundMath(Int2); i+=1)	{choose.PushBack(FM_BASILISKDLC);}
                }	
                if (isCGryphons)
                {
                    Int1=((10-flyingMonsterHunts)/10.0f)*3;
                    Int2=3-Int1;
                    for (i=0; i<RoundMath(Int1); i+=1){choose.PushBack(FM_GRYPHON);}
                    for (i=0; i<RoundMath(Int2); i+=1){choose.PushBack(FM_GRYPHONDLC);}
                }
                
                if (choose.Size() == 0) return false;

                nr = choose[RandRange(choose.Size())];

                switch (nr)
                {
                    case FM_WYVERN:
                        tempArray = wyvern;
                        break;
                    case FM_FORKTAIL:
                        tempArray = forktail;
                        break;
                    case FM_COCKATRICE:
                        tempArray = cockatrice;
                        break;
                    case FM_COCKATRICEDLC:
                        tempArray = cockatricef;
                        break;
					case FM_BASILISK:
                        tempArray = basilisk;
                        break;
					case FM_BASILISKDLC:
                        tempArray = basiliskf;
                        break;
                    case FM_GRYPHON:
                        tempArray = gryphon;
                        break;
                    case FM_GRYPHONDLC:
                        tempArray = gryphonf;
                        break;
                }
            }
            else
            {
                return false;
            }
        }

        tempFlyingArray = tempArray;

        if (selectedDifficulty == 2)
        {
            if ( GetWitcherPlayer().GetLevel() < 4 )
            {
                lvl = RandRange(5, 0);
            }
            else
            {
                lvl = RandRange(10, 0);
            }
        }
        else if (selectedDifficulty == 1)
        {
            if ( GetWitcherPlayer().GetLevel() < 4 )
            {
                lvl = RandRange(4, 0);
            }
            else
            {
                lvl = RandRange(6, -4);
            }
        }
        else
        {
            if ( GetWitcherPlayer().GetLevel() < 4 )
            {
                lvl = RandRange(2, 0);
            }
            else
            {
                lvl = RandRange(3, -7);
            }
        }

        
		if(nr == FM_GRYPHONDLC){
			nr = FM_GRYPHON;
			tempFlyingArray == gryphon;
		}
		if(nr == FM_COCKATRICEDLC){
			nr = FM_COCKATRICE;
			tempFlyingArray == cockatrice;
		}
		if(nr == FM_BASILISKDLC){
			nr = FM_BASILISK;
			tempFlyingArray == basilisk;
		}
		
		
		tempFlyingArray = PrepareEnemyTemplate(tempFlyingArray);			
        resourcePathFlying = ObtainTemplateForEnemy(tempFlyingArray);
        FlyingTemplate = (CEntityTemplate)LoadResource( resourcePathFlying, true);

        if (nr == FM_GRYPHONDLC || nr == FM_COCKATRICEDLC || nr == FM_BASILISKDLC )
        {
			
            if(nr == FM_GRYPHONDLC)
            {
                str1 = "dlc\modtemplates\randomencounterdlc\data\gryphon";
            }
            else if(nr == FM_BASILISKDLC)
            {
                str1 = "dlc\modtemplates\randomencounterdlc\data\basilisk";
            }
            else if(nr == FM_COCKATRICEDLC)
            {
                str1 = "dlc\modtemplates\randomencounterdlc\data\cockatrice";
            }
            str2 = "characters\npc_entities\monsters";
            str = StrReplace(resourcePathFlying, str1, str2);				

            for (j=0; j<20; j+=i)
            {
                rot = thePlayer.GetWorldRotation();
                rando = RandRange(60, -60);
                rot.Yaw = AngleNormalize(rot.Yaw);
                rot.Yaw += rando;
                rot.Yaw = AngleNormalize180(rot.Yaw);
                pos = theCamera.GetCameraPosition();
                pos = pos + VecConeRand(theCamera.GetCameraHeading(), 10, 15, 16);
    
                BloodTemplate = (CEntityTemplate)LoadResource( "items\quest_items\q103\q103_item__horse_corpse_with_head_lying_beside_it_01.w2ent", true);

                FixZAxis(pos);

                if (!CanSpawnEnt(pos))
                {
                    if (j < 19) {continue;} else {return false;}
                }
                // --- Horses head and interactable blood ---
                temp = theGame.CreateEntity(BloodTemplate, pos, rot);
                ((CGameplayEntity)temp).SetFocusModeVisibility(  FMV_Clue  );
                BloodTemplate = (CEntityTemplate)LoadResource( "quests\part_2\quest_files\q106_tower\entities\q106_blood_clue2.w2ent", true);
                temp7 = theGame.CreateEntity(BloodTemplate, pos, rot );	

                // --- Possible blood trail positions into array ---			
                posPrev = pos;
                rando = RandRange(50, 40);

                for( i=0;i<rando;i+=1)
                {	
                    pos = pos + VecConeRand(rot.Yaw, 20, 2, 5);

                    FixZAxis(pos);

                    rot = VecToRotation(pos - posPrev);	
                    posPrev = pos;

                    if (!CanSpawnEnt(pos))
                    {
                        continue;
                    }
            
                    vectorArray.PushBack(pos);			
                }		
 
                if (!CanSpawnEnt(pos))
                {
                    temp.Destroy();
                    temp7.Destroy();
                    vectorArray.Clear();

                    if (j < 19) {continue;} else {return false;}
                }

                break;
            }

            // --- Creates blood trail at the positions of the VectorArray ---
            bloodArray.PushBack(temp7);
            bloodArray.PushBack(temp);

            for(i=0; i<vectorArray.Size();i+=1)
            {
                resourcePathBlood = bArray[RandRange(bArray.Size())];		
                BloodTemplate = (CEntityTemplate)LoadResource( resourcePathBlood, true);
                temp = theGame.CreateEntity(BloodTemplate, vectorArray[i], rot);
                bloodArray.PushBack(temp);
            }

            // --- Flying monster that is on the ground and eating a corpse ---	
            rot.Roll = 0;
            rot.Pitch = 0;

            if(RandRange(10) > 4)
            {
                rando = RandRange(-50,-75);
            }
            else
            {
                rando = RandRange(75, -50);
            }

            rot.Yaw += rando;
            FlyingTemplate = (CEntityTemplate)LoadResource( resourcePathFlying, true);
            pos = pos + VecConeRand(thePlayer.GetHeading(), 20, 5, 6);	
            temp = SpawnEntity(FlyingTemplate, pos, rot, true);	
            
			
            ((CNewNPC)temp).SetTemporaryAttitudeGroup( 'monsters', AGP_Default );
            SetEnemyLevel((CNewNPC)temp, GetWitcherPlayer().GetLevel()+lvl);

            FindGameplayEntitiesInRange(inRangeEntities , temp, 20, 100, /*NOP*/, /*NOP*/, /*NOP*/, 'CNewNPC');

            for(i=0;i<inRangeEntities.Size();i+=1)
            {
                if ((((CNewNPC)inRangeEntities[i]).HasTag('animal') || ((CActor)inRangeEntities[i]).IsMonster()) && (((CActor)inRangeEntities[i]).IsAlive() && ((CActor)inRangeEntities[i]).GetAttitude( thePlayer ) == AIA_Hostile) && ((CActor)inRangeEntities[i]) != temp )
                {
                    ((CActor)inRangeEntities[i]).Kill('RandomEncounters', true);
                }
            }


			((CRandomEncounterFlyingNPC)temp).SetMonsterAttributes( bloodArray, enableTrophies, nr, str, GetEnemyLevel(GetWitcherPlayer().GetLevel()+lvl, tempFlyingArray) );
        }
        else
        {		
            // --- Flying monster ---
            for (j=0; j<20; j+=i)
            {		
                pos = thePlayer.GetWorldPosition();
                pos = pos + VecConeRand(theCamera.GetCameraHeading(), 240, -200, -250);			
                pos.Z += RandRange(71, 60);

                if (!CanSpawnEnt(pos))
                {
                    if (j == 19)
                        return false;
                }
                else
                {
                    break;
                }
            }

			temp = SpawnEntity(FlyingTemplate, pos, rot, true);		
            ((CNewNPC)temp).SetTemporaryAttitudeGroup( 'monsters', AGP_Default );		
            SetEnemyLevel((CNewNPC)temp, GetWitcherPlayer().GetLevel()+lvl);  	


			FlyingTemplate = (CEntityTemplate)LoadResource( pathToFlyingDummy, true);								
			tempx = (CRandomEncounterFlyingNPCEntity)theGame.CreateEntity(FlyingTemplate, thePlayer.GetWorldPosition(), thePlayer.GetWorldRotation());	
			tempx.SetMonsterAttributes(temp, false, enableTrophies, nr);
			
			
        }

        animcomp = temp.GetComponentByClassName('CAnimatedComponent');
        meshcomp = temp.GetComponentByClassName('CMeshComponent');
			
        switch (lvl){
        case -7:
        case -6:
            h = 0.89;
            break;
        case -5:
        case -4:
        case -3:
            h = 0.91;
            break;
        case -2:
        case -1:
            h = 0.93;
            break;
        case 0:
            h = 1.0;
            break;
        case 1:
        case 2:
        case 3:
            h = 1.06;
            break;
        case 4:
        case 5:
        case 6:
            h = 1.08;
            break;
        case 7:
        case 8:
        case 9:
            h = 1.1;
            break;
        default:
            h = 1.0;
            break;
        }

        h += RandRangeF(0.04, -0.04);
		
        animcomp.SetScale(Vector(h,h,h,1));
        meshcomp.SetScale(Vector(h,h,h,1));	

		return true;
    }
	
	
	
	private function IsMonsterGroupEncounter(cTempArray : array<SEnemyTemplate>) : bool
    {
        if (cTempArray == werewolf || cTempArray == leshen || cTempArray == fiend || cTempArray == ekimmara || cTempArray == katakan || cTempArray == bear || cTempArray == skelbear || cTempArray == nightwraith || cTempArray == noonwraith || cTempArray == golem || cTempArray == elemental || cTempArray == arachas || cTempArray == cyclop || cTempArray == troll || cTempArray == skeltroll || cTempArray == chort || cTempArray == hag || cTempArray == bruxa || cTempArray == garkain || cTempArray == fleder || cTempArray == detlaff || cTempArray == giant || cTempArray == sharley || cTempArray == panther)
        {
            return false;
        }
        return true;
    }
	
	private function CanHaveMonsterHunt(cTempArray : array<SEnemyTemplate>) : bool
    {
        if (cTempArray == spider || cTempArray == fogling || cTempArray == nightwraith || cTempArray == noonwraith || cTempArray == cyclop || cTempArray == harpy|| cTempArray == troll || cTempArray == skeltroll || cTempArray == echinops || cTempArray == centipede || cTempArray == bruxa || cTempArray == detlaff || cTempArray == giant || cTempArray == boar || cTempArray == wight || cTempArray == sharley)
        {
            return false;
        }
        return true;
    }
	
	

	private function IsLesserGroup(cTempArray : array<SEnemyTemplate>) : bool
    {
        if (cTempArray == boar || cTempArray == echinops || cTempArray == centipede || cTempArray == kikimore || cTempArray == spider || cTempArray == spider || cTempArray == wraith || cTempArray == hag || cTempArray == wight || cTempArray == fogling || cTempArray == alghoul || cTempArray == rotfiend)
        {
            return true;
        }
        return false;
    }
	
	private function GetInitialMonsterPosition(out initialPos : Vector, out hunt : bool, cTempArray : array<SEnemyTemplate>) : bool
    {
        var i : int;
        var pos : Vector;
        var z : float;

		for(i=0; i<30; i+=1)
        {
            pos = thePlayer.GetWorldPosition();

			if(!CanHaveMonsterHunt(cTempArray))
			{
                if (cTempArray == echinops || cTempArray == centipede)
                {
                    pos += VecRingRand(10,25);
                }
                else if(cTempArray == bruxa)
                {
                    pos = pos + VecConeRand(theCamera.GetCameraHeading(), 210, -15, -26);
                }
				else if(cTempArray == fleder || cTempArray == garkain)
                {
                    pos = pos + VecConeRand(theCamera.GetCameraHeading(), 40, 10, 16);
                }
				else if(cTempArray == skeleton)
                {
                    pos = pos + VecConeRand(theCamera.GetCameraHeading(), 40, -10, -16);
                }
                else
                {
                    pos = pos + VecConeRand(theCamera.GetCameraHeading(), 210, -25, -26);
                }

				hunt = false;
			}	
			else if (hunt)
			{	
				pos = pos + VecConeRand(thePlayer.GetHeading(), 40, 75, 86);
			}
			else
			{
                pos = pos + VecConeRand(theCamera.GetCameraHeading(), 210, -35, -36);
			}

            FixZAxis(pos);
			
			if (CanSpawnEnt(pos))
            {
				initialPos = pos;
                return true;
			}
		}

        return false;
    }
	
	
	private function OnGroundCreature(  tempGroundArray : array<SEnemyTemplate>, type : EGroundMonsterType ) : bool
    {
        var i,j, lvl, rando, huntc, howMany : int;	
        var GroundTemplate, template : CEntityTemplate;
        var resourcePathGround, resourcePath : string;   
        var meshcomp, animcomp : CComponent;
        var rot : EulerAngles;
        var pos : Vector;
        var h, z : float;                 		
        var hunt : bool;	
        var skipMonster : bool;
        var skippedMonsters : int;
        var initialPos : Vector;
		var temp, temp2 : CEntity;
		var tempg : CRandomEncounterGroundGroupNPC;
		var temps : CRandomEncounterGroundSoloNPC;
        var groundEnemies : array<CEntity>;
		var canHaveHunt : bool;
		
		
		canHaveHunt = CanHaveMonsterHunt(tempGroundArray);
		

        if (!IsMonsterGroupEncounter(tempGroundArray))
        {
            howMany = 1;
        }
		else if (selectedDifficulty == 0)
        {
			if (IsLesserGroup(tempGroundArray))
			{
				howMany = RandRange(3, 2);
			}else{
				howMany = RandRange(5, 2);
			}            
        }
		else if (selectedDifficulty == 1)
        {
			if (IsLesserGroup(tempGroundArray))
			{
				howMany = RandRange(4, 2);
			}else{
				howMany = RandRange(6, 3);
			} 
        }
		else
        {
			if (IsLesserGroup(tempGroundArray))
			{
				howMany = RandRange(4, 3);
			}else{
				howMany = RandRange(7, 4);
			} 
        }
		

        if (tempGroundArray == hag)
        {
            if (isPlayerNearWater || isPlayerInSwamp || isPlayerInSwampForest)
            {
                tempGroundArray.Erase(0);
            }
            else
            {
                tempGroundArray.Erase(2);
                tempGroundArray.Erase(1);
            }
        }

        tempGroundArray = PrepareEnemyTemplate(tempGroundArray);

        hunt = false;
        huntc = RandRange(10);

        if (!IsMonsterGroupEncounter(tempGroundArray))
        {			
            if(groundMonsterHunts > huntc)		
            {
                hunt = true;
            }
        }
        else
        {
            if(groupMonsterHunts > huntc)
            {
                hunt = true;
            }
		}

		if (!GetInitialMonsterPosition(initialPos, hunt,tempGroundArray))
        {
            return false;
        }

        skippedMonsters = 0;
        
        for (i = 0; i < howMany; i+=1)
        {
            skipMonster = false;

            for(j=0;j<20;j+=1)
            {
                pos = initialPos + VecRingRand(1,3);

                if (!CanSpawnEnt(pos))
                {
                    if (j == 19)
                    {
                        skipMonster = true;
                    }
                }
                else
                {
                    break;
                }
            }

            if (skipMonster)
            {
                skippedMonsters += 1;
                continue;
            }

            rot = thePlayer.GetWorldRotation();
        
            rando = RandRange(70,-70);			
            rot.Yaw = AngleNormalize(rot.Yaw);
            rot.Yaw += 180;
            rot.Yaw += rando;
            rot.Yaw = AngleNormalize180(rot.Yaw);
        
            rot.Pitch = 0;
            rot.Roll = 0;
        
            resourcePathGround = ObtainTemplateForEnemy(tempGroundArray);
            GroundTemplate = (CEntityTemplate)LoadResource( resourcePathGround, true);	

			
			if(tempGroundArray == fleder || tempGroundArray == garkain){
				if(RandRange(10)>5){
					rot.Yaw += RandRange(80,100);
				}else{
					rot.Yaw += RandRange(-80,-100);
				}	
			}
			
			if(hunt || tempGroundArray == skeleton){
				temp = SpawnEntity(GroundTemplate, pos, rot, true);  
			}else{
				temp = theGame.CreateEntity(GroundTemplate, pos, rot);  
			}
            
			groundEnemies.PushBack(temp);
			
            
            ((CNewNPC)temp).SetTemporaryAttitudeGroup( 'monsters', AGP_Default );				

            if (selectedDifficulty == 2)
            {				
                if ( GetWitcherPlayer().GetLevel() < 4 )
                {
                    lvl = RandRange(5, 0);
                }
                else
                {
                    lvl = RandRange(7, 1);
                }
            }
            else if (selectedDifficulty == 1)
            {			
                if ( GetWitcherPlayer().GetLevel() < 4 )
                {
                    lvl = RandRange(4, 0);
                }
                else
                {
                    lvl = RandRange(6, -2);
                }
            }
            else
            {				
                if ( GetWitcherPlayer().GetLevel() < 4 )
                {
                    lvl = RandRange(2, 0);
                }
                else
                {
                    lvl = RandRange(3, -7);
                }
            }

            SetEnemyLevel((CNewNPC)temp, GetWitcherPlayer().GetLevel()+lvl);  
            
            animcomp = temp.GetComponentByClassName('CAnimatedComponent');
            meshcomp = temp.GetComponentByClassName('CMeshComponent');
            
            switch (lvl){
            case -7:
            case -6:
                h = 0.83;
                break;
            case -5:
            case -4:
            case -3:
                h = 0.94;
                break;
            case -2:
            case -1:
                h = 0.96;
                break;
            case 0:
                h = 1.0;
                break;
            case 1:
            case 2:
            case 3:
                h = 1.02;
                break;
            case 4:
            case 5:
            case 6:
                h = 1.04;
                break;
            case 7:
            case 8:
            case 9:
                h = 1.06;
                break;
            default:
                h = 1.0;
                break;
            }		

            h += RandRangeF(0.02, -0.02);

            animcomp.SetScale(Vector(h,h,h,1));
            meshcomp.SetScale(Vector(h,h,h,1));
        }

        if (skippedMonsters >= howMany)
        {
            return false;
        }

		if(howMany == 1){
			GroundTemplate = (CEntityTemplate)LoadResource( pathToGroundDummy, true);	
			temps = (CRandomEncounterGroundSoloNPC)theGame.CreateEntity(GroundTemplate, thePlayer.GetWorldPosition(), thePlayer.GetWorldRotation());	
			temps.SetArray(groundEnemies, hunt, type);
		}else{
			GroundTemplate = (CEntityTemplate)LoadResource( pathToGroupDummy, true);	
			tempg = (CRandomEncounterGroundGroupNPC)theGame.CreateEntity(GroundTemplate, thePlayer.GetWorldPosition(), thePlayer.GetWorldRotation());	
			tempg.SetArray(groundEnemies, hunt, type);	
		}
		
		return true;							
    }
    
    private function whichGround( type : EGroundEncounterType) : bool
    {
        var currentArea : string;		
        var choose : array<EGroundMonsterType>;
        var i : int;
        var nr : EGroundMonsterType;
        var isLeshens, isWerewolves, isFiends, isEkimmara, isKatakan, isBears, isGolems, isElementals, isHarpy, isCyclops, isArachas, isTroll : int;
        var isNightWraiths, isNoonWraiths, isHags, isFogling, isEndrega, isGhouls, isAlghouls, isChorts, isHigherVamp, isFleder, isGarkain, isPanther : int;
        var isNekkers, isDrowners, isRotfiends, isWolves, isWraiths, isSpiders, isSkeleton, isDrownerDLC, isBoar, isGiant, isSharley, isWight : int;

		var isBarghest, isBruxa, isEchinops : int;
		var	isCentipede : int;
		var	isKikimore : int;

        currentArea = AreaTypeToName(theGame.GetCommonMapManager().GetCurrentArea());			

        if (type == GE_SOLO)
        {
            if (customGround)
            {
                if (theGame.envMgr.IsNight())
                {
                    isLeshens = isLeshensN;
                    isWerewolves = isWerewolvesN;
                    isFiends = isFiendsN;
                    isChorts = isChortsN;
                    isArachas = isArachasN;
                    isCyclops = isCyclopsN;
                    isEkimmara = isEkimmaraN;
                    isKatakan = isKatakanN;
                    isBears = isBearsN;
                    isGolems = isGolemsN;
                    isElementals = isElementalsN;
                    isNightWraiths = isNightWraithsN;
                    isNoonWraiths = isNoonWraithsN;
                    isTroll = isTrollN;
                    isHags = isHagsN;

                    isBruxa = isBruxaN;
					isHigherVamp = isHigherVampN;
					isFleder = isFlederN;
					isGarkain = isGarkainN;
					isPanther = isPantherN;
					isSharley = isSharleyN;
					isGiant = isGiantN;
					isBoar = isBoarN;
                }
                else
                {
                    isLeshens = isLeshensD;
                    isWerewolves = isWerewolvesD;
                    isFiends = isFiendsD;
                    isChorts = isChortsD;
                    isArachas = isArachasD;
                    isCyclops = isCyclopsD;
                    isEkimmara = isEkimmaraD;
                    isKatakan = isKatakanD;
                    isBears = isBearsD;
                    isGolems = isGolemsD;
                    isElementals = isElementalsD;
                    isNightWraiths = isNightWraithsD;
                    isNoonWraiths = isNoonWraithsD;
                    isTroll = isTrollD;
                    isHags = isHagsD;

                    isBruxa = isBruxaD;
					isHigherVamp = isHigherVampD;
					isFleder = isFlederD;
					isGarkain = isGarkainD;
					isPanther = isPantherD;
					isSharley = isSharleyD;
					isGiant = isGiantD;
					isBoar = isBoarD;
                }

                if (currentArea == "prolog_village")
                {
                    if (isWerewolves != 0 && !isPlayerInSwamp)		{for (i=0; i<isWerewolves; i+=1)  {choose.PushBack(GM_WEREWOLF);}}
                    if (isBears != 0)			{for (i=0; i<isBears; i+=1)       {choose.PushBack(GM_BEAR);}}
                    if (isNightWraiths != 0 && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest && theGame.envMgr.IsNight())	{for (i=0; i<isNightWraiths; i+=1){choose.PushBack(GM_NIGHTWRAITH);}}
                    if (isNoonWraiths != 0 && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest && !theGame.envMgr.IsNight())	{for (i=0; i<isNoonWraiths; i+=1) {choose.PushBack(GM_NOONWRAITH);}}
					if (isBruxa != 0 && IsLevelMet(GM_BRUXA))			{for (i=0; i<isBruxa; i+=1)       {choose.PushBack(GM_BRUXA);}}
					if (isHigherVamp != 0)			{for (i=0; i<isHigherVamp; i+=1)       {choose.PushBack(GM_DETLAFF);}}
					if (isGarkain != 0)			{for (i=0; i<isGarkain; i+=1)       {choose.PushBack(GM_GARKAIN);}}
					if (isFleder != 0)			{for (i=0; i<isFleder; i+=1)       {choose.PushBack(GM_FLEDER);}}
					if (isPanther != 0)			{for (i=0; i<isPanther; i+=1)       {choose.PushBack(GM_PANTHER);}}
					if (isBoar != 0)			{for (i=0; i<isBoar; i+=1)       {choose.PushBack(GM_BOAR);}}

                    if (choose.Size() == 0) return false;

                    nr = choose[RandRange(choose.Size())];

                    switch (nr)
                    {
                        case GM_WEREWOLF:
                            tempArray = werewolf;
                            break;
                        case GM_BEAR:
                            tempArray = bear;
                            break;
                        case GM_NIGHTWRAITH:
                            tempArray = nightwraith;
                            break;
                        case GM_NOONWRAITH:
                            tempArray = noonwraith;
                            break;
						case GM_BRUXA:
							tempArray = bruxa;
                            break;
						case GM_DETLAFF:
							tempArray = detlaff;
                            break;
						case GM_GARKAIN:
							tempArray = garkain;
                            break;
						case GM_FLEDER:
							tempArray = fleder;
                            break;
						case GM_PANTHER:
							tempArray = panther;
                            break;
						case GM_BOAR:
							tempArray = boar;
                            break;
                    }
                }		
                else if (currentArea == "skellige" || currentArea == "novigrad" || currentArea == "kaer_morhen" || currentArea == "no_mans_land" || currentArea == "bob")
                {
                    if (isLeshens != 0 && isPlayerInForest)		{for (i=0; i<isLeshens; i+=1)     {choose.PushBack(GM_LESHEN);}}
                    if (isWerewolves != 0 && !isPlayerInSwamp)	{for (i=0; i<isWerewolves; i+=1)  {choose.PushBack(GM_WEREWOLF);}}
                    if (isFiends != 0)		{for (i=0; i<isFiends; i+=1)      {choose.PushBack(GM_FIEND);}}
                    if (isBears != 0)		{for (i=0; i<isBears; i+=1)       {choose.PushBack(GM_BEAR);}}
                    if (isGolems != 0)		{for (i=0; i<isGolems; i+=1)      {choose.PushBack(GM_GOLEM);}}
                    if (isElementals != 0 && !isPlayerInSwamp && !isPlayerInSwampForest)	{for (i=0; i<isElementals; i+=1)  {choose.PushBack(GM_ELEMENTAL);}}
                    if (isNightWraiths != 0 && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest && theGame.envMgr.IsNight()){for (i=0; i<isNightWraiths; i+=1){choose.PushBack(GM_NIGHTWRAITH);}}
                    if (isNoonWraiths != 0 && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest && !theGame.envMgr.IsNight()) {for (i=0; i<isNoonWraiths; i+=1) {choose.PushBack(GM_NOONWRAITH);}}					
                    if (isChorts != 0)		{for (i=0; i<isChorts; i+=1)      {choose.PushBack(GM_CHORT);}}
                    if (isArachas != 0 && (isPlayerInForest || isPlayerInSwampForest))		{for (i=0; i<isArachas; i+=1)     {choose.PushBack(GM_ARACHAS);}}
                    if (isCyclops != 0)		{for (i=0; i<isCyclops; i+=1)     {choose.PushBack(GM_CYCLOPS);}}
                    if (isTroll != 0)		{for (i=0; i<isTroll; i+=1)       {choose.PushBack(GM_TROLL);}}
                    if (isHags != 0)		{for (i=0; i<isHags; i+=1)        {choose.PushBack(GM_HAG);}}
                    if (isEkimmara != 0 && IsLevelMet(GM_EKIMMARA))	{for (i=0; i<isEkimmara; i+=1)    {choose.PushBack(GM_EKIMMARA);}}
                    if (isKatakan != 0 && IsLevelMet(GM_KATAKAN))	{for (i=0; i<isKatakan; i+=1)     {choose.PushBack(GM_KATAKAN);}}
					if (isBruxa != 0 && IsLevelMet(GM_BRUXA))		{for (i=0; i<isBruxa; i+=1)       {choose.PushBack(GM_BRUXA);}}      		                  
					if (isHigherVamp != 0)			{for (i=0; i<isHigherVamp; i+=1)       {choose.PushBack(GM_DETLAFF);}}
					if (isGarkain != 0)			{for (i=0; i<isGarkain; i+=1)       {choose.PushBack(GM_GARKAIN);}}
					if (isFleder != 0)			{for (i=0; i<isFleder; i+=1)       {choose.PushBack(GM_FLEDER);}}
					if (isPanther != 0)			{for (i=0; i<isPanther; i+=1)       {choose.PushBack(GM_PANTHER);}}
					if (isSharley != 0)			{for (i=0; i<isSharley; i+=1)       {choose.PushBack(GM_SHARLEY);}}
					if (isGiant != 0)			{for (i=0; i<isGiant; i+=1)       {choose.PushBack(GM_GIANTDLC);}}
					if (isBoar != 0)			{for (i=0; i<isBoar; i+=1)       {choose.PushBack(GM_BOAR);}}
					
                    if (choose.Size() == 0) return false;

                    nr = choose[RandRange(choose.Size())];

                    switch (nr)
                    {
                        case GM_LESHEN:
                            tempArray = leshen;
                            break;
                        case GM_WEREWOLF:
                            tempArray = werewolf;
                            break;
                        case GM_FIEND:
                            tempArray = fiend;
                            break;
                        case GM_EKIMMARA:
                            tempArray = ekimmara;
                            break;
                        case GM_KATAKAN:
                            tempArray = katakan;
                            break;
                        case GM_BEAR:
                            if (currentArea == "skellige"){
								if(RandRange(10)>5)							
									tempArray = skelbear;
								else
									tempArray = bear;
							}
                            else
								tempArray = bear;
                            break;
                        case GM_GOLEM:
                            tempArray = golem;
                            break;
                        case GM_ELEMENTAL:
                            tempArray = elemental;
                            break;
                        case GM_NIGHTWRAITH:
                            tempArray = nightwraith;
                            break;
                        case GM_NOONWRAITH:
                            tempArray = noonwraith;
                            break;
                        case GM_CHORT:
                            tempArray = chort;
                            break;
                        case GM_ARACHAS:
                            tempArray = arachas;
                            break;
                        case GM_CYCLOPS:
                            tempArray = cyclop;
                            break;
                        case GM_TROLL:
							if (currentArea == "skellige"){
								if(RandRange(10)>5)							
									tempArray = skeltroll;
								else
									tempArray = troll;
							}
                            else
								tempArray = troll;
                            break;
                        case GM_HAG:
                            tempArray = hag;
                            break;
						case GM_BRUXA:
                            tempArray = bruxa;
                            break;
						case GM_DETLAFF:
							tempArray = detlaff;
                            break;
						case GM_GARKAIN:
							tempArray = garkain;
                            break;
						case GM_FLEDER:
							tempArray = fleder;
                            break;
						case GM_PANTHER:
							tempArray = panther;
                            break;
						case GM_SHARLEY:
							tempArray = sharley;
                            break;
						case GM_GIANTDLC:
							tempArray = giant;
                            break;
						case GM_BOAR:
							tempArray = boar;
                            break;
                    }	
                }
                else
                {
                    return false;
                }
            }
            else
            {
                if (currentArea == "prolog_village")
                {	
                    if (isCWerewolves && !isPlayerInSwamp)		{for (i=0; i<3; i+=1){choose.PushBack(GM_WEREWOLF);}}
                    if (isCBears)			{for (i=0; i<3; i+=1){choose.PushBack(GM_BEAR);}}
                    if (isCNightWraiths && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest && theGame.envMgr.IsNight())	{for (i=0; i<1; i+=1){choose.PushBack(GM_NIGHTWRAITH);}}
                    if (isCNoonWraiths && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest && !theGame.envMgr.IsNight())	{for (i=0; i<1; i+=1){choose.PushBack(GM_NOONWRAITH);}}
					if (isCBruxa && IsLevelMet(GM_BRUXA))	{for (i=0; i<2; i+=1)       {choose.PushBack(GM_BRUXA);}}
					if (isCHigherVamp)			{for (i=0; i<1; i+=1)       {choose.PushBack(GM_DETLAFF);}}
					if (isCGarkain)				{for (i=0; i<2; i+=1)       {choose.PushBack(GM_GARKAIN);}}
					if (isCFleder)				{for (i=0; i<2; i+=1)       {choose.PushBack(GM_FLEDER);}}
					if (isCPanther)				{for (i=0; i<1; i+=1)       {choose.PushBack(GM_PANTHER);}}
					if (isCBoar)				{for (i=0; i<1; i+=1)       {choose.PushBack(GM_BOAR);}}
					
                    if (choose.Size() == 0) return false;

                    nr = choose[RandRange(choose.Size())];

                    switch (nr)
                    {
                        case GM_WEREWOLF:
                            tempArray = werewolf;
                            break;
                        case GM_BEAR:
                            tempArray = bear;
                            break;
                        case GM_NIGHTWRAITH:
                            tempArray = nightwraith;
                            break;
                        case GM_NOONWRAITH:
                            tempArray = noonwraith;
                            break;
						case GM_BRUXA:
							tempArray = bruxa;
                            break;
						case GM_DETLAFF:
							tempArray = detlaff;
                            break;
						case GM_GARKAIN:
							tempArray = garkain;
                            break;
						case GM_FLEDER:
							tempArray = fleder;
                            break;
						case GM_PANTHER:
							tempArray = panther;
                            break;
						case GM_BOAR:
							tempArray = boar;
                            break;
                    }
                }		
                else if (currentArea == "skellige" || currentArea == "novigrad" || currentArea == "kaer_morhen" || currentArea == "no_mans_land" || currentArea == "bob")
                {
                    if (isCLeshens && isPlayerInForest)		{for (i=0; i<1; i+=1){choose.PushBack(GM_LESHEN);}}
                    if (isCWerewolves && !isPlayerInSwamp)	{for (i=0; i<2; i+=1){choose.PushBack(GM_WEREWOLF);}}
                    if (isCFiends)		{for (i=0; i<2; i+=1){choose.PushBack(GM_FIEND);}}
                    if (isCBears)		{for (i=0; i<2; i+=1){choose.PushBack(GM_BEAR);}}
                    if (isCGolems)		{for (i=0; i<1; i+=1){choose.PushBack(GM_GOLEM);}}
                    if (isCElementals && !isPlayerInSwamp && !isPlayerInSwampForest)	{for (i=0; i<1; i+=1){choose.PushBack(GM_ELEMENTAL);}}
                    if (isCNightWraiths && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest && theGame.envMgr.IsNight()){for (i=0; i<1; i+=1){choose.PushBack(GM_NIGHTWRAITH);}}
                    if (isCNoonWraiths && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest && !theGame.envMgr.IsNight()) {for (i=0; i<1; i+=1){choose.PushBack(GM_NOONWRAITH);}}					
                    if (isCChorts)		{for (i=0; i<1; i+=1){choose.PushBack(GM_CHORT);}}
                    if (isCArachas && (isPlayerInForest || isPlayerInSwampForest))		{for (i=0; i<1; i+=1){choose.PushBack(GM_ARACHAS);}}
                    if (isCCyclops)		{for (i=0; i<1; i+=1){choose.PushBack(GM_CYCLOPS);}}
                    if (isCTroll)		{for (i=0; i<1; i+=1){choose.PushBack(GM_TROLL);}}
                    if (isCHags)	    {for (i=0; i<1; i+=1){choose.PushBack(GM_HAG);}}
                    if (isCEkimmara && IsLevelMet(GM_EKIMMARA))	{for (i=0; i<1; i+=1){choose.PushBack(GM_EKIMMARA);}}
                    if (isCKatakan && IsLevelMet(GM_KATAKAN))	{for (i=0; i<1; i+=1){choose.PushBack(GM_KATAKAN);}}
					if (isCBruxa && IsLevelMet(GM_BRUXA))		{for (i=0; i<2; i+=1){choose.PushBack(GM_BRUXA);}}   		                    		              
					if (isCHigherVamp)		{for (i=0; i<1; i+=1)       {choose.PushBack(GM_DETLAFF);}}
					if (isCGarkain)			{for (i=0; i<2; i+=1)       {choose.PushBack(GM_GARKAIN);}}
					if (isCFleder)			{for (i=0; i<2; i+=1)       {choose.PushBack(GM_FLEDER);}}
					if (isCPanther)			{for (i=0; i<1; i+=1)       {choose.PushBack(GM_PANTHER);}}
					if (isCSharley)			{for (i=0; i<1; i+=1)       {choose.PushBack(GM_SHARLEY);}}
					if (isCGiant)			{for (i=0; i<1; i+=1)       {choose.PushBack(GM_GIANTDLC);}}
					if (isCBoar)				{for (i=0; i<1; i+=1)       {choose.PushBack(GM_BOAR);}}
					
                    if (choose.Size() == 0) return false;

                    nr = choose[RandRange(choose.Size())];

                    switch (nr)
                    {
                        case GM_LESHEN:
                            tempArray = leshen;
                            break;
                        case GM_WEREWOLF:
                            tempArray = werewolf;
                            break;
                        case GM_FIEND:
                            tempArray = fiend;
                            break;
                        case GM_EKIMMARA:
                            tempArray = ekimmara;
                            break;
                        case GM_KATAKAN:
                            tempArray = katakan;
                            break;
                        case GM_BEAR:
                            if (currentArea == "skellige"){
								if(RandRange(10)>5)							
									tempArray = skelbear;
								else
									tempArray = bear;
							}
                            else
								tempArray = bear;
                            break;
                        case GM_GOLEM:
                            tempArray = golem;
                            break;
                        case GM_ELEMENTAL:
                            tempArray = elemental;
                            break;
                        case GM_NIGHTWRAITH:
                            tempArray = nightwraith;
                            break;
                        case GM_NOONWRAITH:
                            tempArray = noonwraith;
                            break;
                        case GM_CHORT:
                            tempArray = chort;
                            break;
                        case GM_ARACHAS:
                            tempArray = arachas;
                            break;
                        case GM_CYCLOPS:
                            tempArray = cyclop;
                            break;
                        case GM_TROLL:
							if (currentArea == "skellige"){
								if(RandRange(10)>5)							
									tempArray = skeltroll;
								else
									tempArray = troll;
							}
                            else
								tempArray = troll;
                            break;
                        case GM_HAG:
                            tempArray = hag;
                            break;						
						case GM_BRUXA:
                            tempArray = bruxa;
                            break;
						case GM_DETLAFF:
							tempArray = detlaff;
                            break;
						case GM_GARKAIN:
							tempArray = garkain;
                            break;
						case GM_FLEDER:
							tempArray = fleder;
                            break;
						case GM_PANTHER:
							tempArray = panther;
                            break;
						case GM_SHARLEY:
							tempArray = sharley;
                            break;
						case GM_GIANTDLC:
							tempArray = giant;
                            break;
						case GM_BOAR:
							tempArray = boar;
                            break;
                    }
                }
                else
                {
                    return false;
                }
            }
        }
        else if (type == GE_GROUP)
        {
            if (customGroup)
            {
                if (theGame.envMgr.IsNight())
                {
                    isHarpy = isHarpyN;
                    isFogling = isFoglingN;
                    isEndrega = isEndregaN;
                    isGhouls = isGhoulsN;
                    isAlghouls = isAlghoulsN;
                    isNekkers = isNekkersN;
                    isDrowners = isDrownersN;
                    isRotfiends = isRotfiendsN;
                    isWolves = isWolvesN;
                    isWraiths = isWraithsN;
                    isSpiders = isSpidersN;

                    isBarghest = isBarghestN;
                    isEchinops = isEchinopsN;
                    isCentipede = isCentipedeN;
                    isKikimore = isKikimoreN;
					isWight = isWightN;
					isDrownerDLC = isDrownerDLCN;
					isSkeleton = isSkeletonN;
                }
                else
                {
                    isHarpy = isHarpyD;
                    isFogling = isFoglingD;
                    isEndrega = isEndregaD;
                    isGhouls = isGhoulsD;
                    isAlghouls = isAlghoulsD;
                    isNekkers = isNekkersD;
                    isDrowners = isDrownersD;
                    isRotfiends = isRotfiendsD;
                    isWolves = isWolvesD;
                    isWraiths = isWraithsD;
                    isSpiders = isSpidersD;

                    isBarghest = isBarghestD;
                    isEchinops = isEchinopsD;
                    isCentipede = isCentipedeD;
                    isKikimore = isKikimoreD;
					isWight = isWightD;
					isDrownerDLC = isDrownerDLCD;
					isSkeleton = isSkeletonD;
                }

                if (currentArea == "prolog_village")
                {
                    if (isGhouls != 0)		{for (i=0; i<isGhouls; i+=1)   {choose.PushBack(GM_GHOUL);}}
                    if (isNekkers != 0)		{for (i=0; i<isNekkers; i+=1)  {choose.PushBack(GM_NEKKER);}}
                    if (isDrowners != 0 && (isPlayerNearWater || isPlayerInSwamp || isPlayerInSwampForest))	{for (i=0; i<isDrowners; i+=1) {choose.PushBack(GM_DROWNER);}}
                    if (isWolves != 0)		{for (i=0; i<isWolves; i+=1)   {choose.PushBack(GM_WOLF);}}
                    if (isWraiths != 0)		{for (i=0; i<isWraiths; i+=1)  {choose.PushBack(GM_WRAITH);}}
                    if (isSpiders != 0 && (isPlayerInForest || isPlayerInSwampForest))   {for (i=0; i<isSpiders; i+=1)  {choose.PushBack(GM_SPIDER);}}
					if (isWight != 0)		{for (i=0; i<isWight; i+=1)  {choose.PushBack(GM_WIGHT);}}
					if (isSkeleton != 0)		{for (i=0; i<isWight; i+=1)  {choose.PushBack(GM_WIGHT);}}
					if (isWight != 0)		{for (i=0; i<isWight; i+=1)  {choose.PushBack(GM_WIGHT);}}
					if (isDrownerDLC != 0)		{for (i=0; i<isDrownerDLC; i+=1)  {choose.PushBack(GM_DROWNERDLC);}}
					if (isSkeleton != 0)		{for (i=0; i<isSkeleton; i+=1)  {choose.PushBack(GM_SKELETON);}}

                    if (choose.Size() == 0) return false;

                    nr = choose[RandRange(choose.Size())];

                    switch (nr)
                    {
                        case GM_GHOUL:
                            tempArray = ghoul;
                            break;
                        case GM_NEKKER:
                            tempArray = nekker;
                            break;
                        case GM_DROWNER:
                            tempArray = drowner;
                            break;
                        case GM_WOLF:
                            tempArray = wolf;
                            break;
                        case GM_WRAITH:
                            tempArray = wraith;
                            break;
                        case GM_SPIDER:
                            tempArray = spider;
                            break;
						case GM_WIGHT:
							tempArray = wight;
							break;
						case GM_DROWNERDLC:
							tempArray = gravier;
							break;
						case GM_SKELETON:
							tempArray = skeleton;
							break;
                    }
                }		
                else if (currentArea == "skellige" || currentArea == "novigrad" || currentArea == "kaer_morhen" || currentArea == "no_mans_land" || currentArea == "bob")
                {
                    if (isFogling != 0 && (isPlayerInSwamp || isPlayerInSwampForest))		           {for (i=0; i<isFogling; i+=1)  {choose.PushBack(GM_FOGLET);}}
                    if (isEndrega != 0 && (isPlayerInForest || isPlayerInSwampForest))		       {for (i=0; i<isEndrega; i+=1)  {choose.PushBack(GM_ENDREGA);}}
                    if (isGhouls != 0)		           {for (i=0; i<isGhouls; i+=1)   {choose.PushBack(GM_GHOUL);}}
                    if (isAlghouls != 0)	           {for (i=0; i<isAlghouls; i+=1) {choose.PushBack(GM_ALGHOUL);}}
                    if (isNekkers != 0)		           {for (i=0; i<isNekkers; i+=1)  {choose.PushBack(GM_NEKKER);}}
                    if (isDrowners != 0 && (isPlayerNearWater || isPlayerInSwamp || isPlayerInSwampForest))	           {for (i=0; i<isDrowners; i+=1) {choose.PushBack(GM_DROWNER);}}
                    if (isRotfiends != 0)	           {for (i=0; i<isRotfiends; i+=1){choose.PushBack(GM_ROTFIEND);}}
                    if (isWolves != 0)		           {for (i=0; i<isWolves; i+=1)   {choose.PushBack(GM_WOLF);}}
                    if (isWraiths != 0)		           {for (i=0; i<isWraiths; i+=1)  {choose.PushBack(GM_WRAITH);}}
                    if (isHarpy != 0 && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest)	           {for (i=0; i<isHarpy; i+=1)    {choose.PushBack(GM_HARPY);}}
                    if (isSpiders != 0 && (isPlayerInForest || isPlayerInSwampForest))              {for (i=0; i<isSpiders; i+=1)  {choose.PushBack(GM_SPIDER);}}
					if (isCentipede != 0 && IsLevelMet(GM_CENTIEDE) && !isPlayerNearWater && !isPlayerInSwamp && !isPlayerInSwampForest)           {for (i=0; i<isCentipede; i+=1){choose.PushBack(GM_CENTIEDE);}}
					if (isEchinops != 0 && IsLevelMet(GM_ECHINOPS))	           {for (i=0; i<isEchinops; i+=1) {choose.PushBack(GM_ECHINOPS);}}						
					if (isKikimore != 0 && IsLevelMet(GM_KIKIMORE))	           {for (i=0; i<isKikimore; i+=1) {choose.PushBack(GM_KIKIMORE);}}				
					if (isBarghest != 0 && IsLevelMet(GM_BARGHEST) && !isPlayerInForest && !isPlayerInSwampForest)	           {for (i=0; i<isBarghest; i+=1) {choose.PushBack(GM_BARGHEST);}}
					if (isWight != 0)		{for (i=0; i<isWight; i+=1)  {choose.PushBack(GM_WIGHT);}}
					if (isDrownerDLC != 0)		{for (i=0; i<isDrownerDLC; i+=1)  {choose.PushBack(GM_DROWNERDLC);}}
					if (isSkeleton != 0)		{for (i=0; i<isSkeleton; i+=1)  {choose.PushBack(GM_SKELETON);}}
					
                    if (choose.Size() == 0) return false;
                    
                    nr = choose[RandRange(choose.Size())];	

                    switch (nr)
                    {
                        case GM_FOGLET:
                            tempArray = fogling;
                            break;
                        case GM_ENDREGA:
                            tempArray = endrega;
                            break;
                        case GM_GHOUL:
                            tempArray = ghoul;
                            break;
                        case GM_ALGHOUL:
                            tempArray = alghoul;
                            break;
                        case GM_NEKKER:
                            tempArray = nekker;
                            break;
                        case GM_DROWNER:
                            tempArray = drowner;
                            break;
                        case GM_ROTFIEND:
                            tempArray = rotfiend;
                            break;
                        case GM_WOLF:
							if (currentArea == "skellige"){
								if(RandRange(10)>5)							
									tempArray = skelwolf;
								else
									tempArray = wolf;
							}
                            else
								tempArray = wolf;
                            break;
                        case GM_WRAITH:
                            tempArray = wraith;
                            break;
                        case GM_HARPY:
                            tempArray = harpy;
                            break;
                        case GM_SPIDER:
                            tempArray = spider;
                            break;
						case GM_HAG:
                            tempArray = hag;
                            break;
						case GM_CENTIEDE:   // BLOOD AND WINE
                            tempArray = centipede;
                            break;
						case GM_ECHINOPS:
                            tempArray = echinops;
                            break;
						case GM_KIKIMORE:
                            tempArray = kikimore;
                            break;
						case GM_BARGHEST:
                            tempArray = barghest;
                            break;	
						case GM_WIGHT:
							tempArray = wight;
							break;
						case GM_DROWNERDLC:
							tempArray = gravier;
							break;
						case GM_SKELETON:
							tempArray = skeleton;
							break;
                    }
                }
                else
                {
                    return false;
                }
            }
            else
            {
                if (currentArea == "prolog_village")
                {
                    if (isCGhouls)		{for (i=0; i<4; i+=1){choose.PushBack(GM_GHOUL);}}
                    if (isCNekkers)		{for (i=0; i<4; i+=1){choose.PushBack(GM_NEKKER);}}
                    if (isCDrowners && (isPlayerNearWater || isPlayerInSwamp || isPlayerInSwampForest))	{for (i=0; i<3; i+=1){choose.PushBack(GM_DROWNER);}}
                    if (isCWolves)		{for (i=0; i<3; i+=1){choose.PushBack(GM_WOLF);}}
                    if (isCWraiths)		{for (i=0; i<2; i+=1){choose.PushBack(GM_WRAITH);}}
                    if (isCSpiders && (isPlayerInForest || isPlayerInSwampForest))   {for (i=0; i<1; i+=1){choose.PushBack(GM_SPIDER);}}	
					if (isCWight)		{for (i=0; i<2; i+=1)  {choose.PushBack(GM_WIGHT);}}
					if (isCSkeleton)		{for (i=0; i<1; i+=1)  {choose.PushBack(GM_SKELETON);}}
					
                    if (choose.Size() == 0) return false;

                    nr = choose[RandRange(choose.Size())];

                    switch (nr)
                    {
                        case GM_GHOUL:
                            tempArray = ghoul;
                            break;
                        case GM_NEKKER:
                            tempArray = nekker;
                            break;
                        case GM_DROWNER:
                            tempArray = drowner;
                            break;
                        case GM_WOLF:
                            tempArray = wolf;
                            break;
                        case GM_WRAITH:
                            tempArray = wraith;
                            break;
                        case GM_SPIDER:
                            tempArray = spider;
                            break;
						case GM_WIGHT:
							tempArray = wight;
							break;
						case GM_SKELETON:
							tempArray = skeleton;
							break;
                    }
                }		
                else if (currentArea == "skellige" || currentArea == "novigrad" || currentArea == "no_mans_land" || currentArea == "bob" || currentArea == "kaer_morhen")
                {
                    if (isCFogling && (isPlayerInSwamp || isPlayerInSwampForest))			      {for (i=0; i<1; i+=1){choose.PushBack(GM_FOGLET);}}
                    if (isCEndrega && (isPlayerInForest || isPlayerInSwampForest))			  {for (i=0; i<2; i+=1){choose.PushBack(GM_ENDREGA);}}
                    if (isCGhouls)			      {for (i=0; i<2; i+=1){choose.PushBack(GM_GHOUL);}}
                    if (isCAlghouls)		      {for (i=0; i<1; i+=1){choose.PushBack(GM_ALGHOUL);}}
                    if (isCNekkers)			      {for (i=0; i<2; i+=1){choose.PushBack(GM_NEKKER);}}
                    if (isCDrowners && (isPlayerNearWater || isPlayerInSwamp || isPlayerInSwampForest))		      {for (i=0; i<2; i+=1){choose.PushBack(GM_DROWNER);}}
                    if (isCRotfiends)		      {for (i=0; i<2; i+=1){choose.PushBack(GM_ROTFIEND);}}
                    if (isCWolves)			      {for (i=0; i<2; i+=1){choose.PushBack(GM_WOLF);}}
                    if (isCWraiths)			      {for (i=0; i<1; i+=1){choose.PushBack(GM_WRAITH);}}
                    if (isCHarpy && !isPlayerInForest && !isPlayerInSwamp && !isPlayerInSwampForest)			  {for (i=0; i<2; i+=1){choose.PushBack(GM_HARPY);}}
                    if (isCSpiders && (isPlayerInForest || isPlayerInSwampForest))             {for (i=0; i<1; i+=1){choose.PushBack(GM_SPIDER);}}			
					if (isCCentipede && IsLevelMet(GM_CENTIEDE) && !isPlayerNearWater && !isPlayerInSwamp && !isPlayerInSwampForest)          {for (i=0; i<1; i+=1){choose.PushBack(GM_CENTIEDE);}}
					if (isCEchinops && IsLevelMet(GM_ECHINOPS))	          {for (i=0; i<1; i+=1){choose.PushBack(GM_ECHINOPS);}}				
					if (isCKikimore && IsLevelMet(GM_KIKIMORE))	          {for (i=0; i<2; i+=1){choose.PushBack(GM_KIKIMORE);}}			
					if (isCBarghest && IsLevelMet(GM_BARGHEST) && !isPlayerInForest && !isPlayerInSwampForest)	          {for (i=0; i<2; i+=1){choose.PushBack(GM_BARGHEST);}}
					if (isCWight)		{for (i=0; i<2; i+=1)  {choose.PushBack(GM_WIGHT);}}
					if (isCDrownerDLC)		{for (i=0; i<1; i+=1)  {choose.PushBack(GM_DROWNERDLC);}}
					if (isCSkeleton)		{for (i=0; i<1; i+=1)  {choose.PushBack(GM_SKELETON);}}
					
                    if (choose.Size() == 0) return false;
                    
                    nr = choose[RandRange(choose.Size())];	

                    switch (nr)
                    {
                        case GM_FOGLET:
                            tempArray = fogling;
                            break;
                        case GM_ENDREGA:
                            tempArray = endrega;
                            break;
                        case GM_GHOUL:
                            tempArray = ghoul;
                            break;
                        case GM_ALGHOUL:
                            tempArray = alghoul;
                            break;
                        case GM_NEKKER:
                            tempArray = nekker;
                            break;
                        case GM_DROWNER:
                            tempArray = drowner;
                            break;
                        case GM_ROTFIEND:
                            tempArray = rotfiend;
                            break;
                        case GM_WOLF:
                            if (currentArea == "skellige"){
								if(RandRange(10)>5)							
									tempArray = skelwolf;
								else
									tempArray = wolf;
							}
                            else
								tempArray = wolf;
                            break;
                        case GM_WRAITH:
                            tempArray = wraith;
                            break;
                        case GM_HARPY:
                            tempArray = harpy;
                            break;
                        case GM_SPIDER:
                            tempArray = spider;
                            break;
						case GM_CENTIEDE:  // BLOOD AND WINE
                            tempArray = centipede;
                            break;
						case GM_ECHINOPS:
                            tempArray = echinops;
                            break;
						case GM_KIKIMORE:
                            tempArray = kikimore;
                            break;	
						case GM_BARGHEST:
                            tempArray = barghest;
                            break;
						case GM_WIGHT:
							tempArray = wight;
							break;
						case GM_DROWNERDLC:
							tempArray = gravier;
							break;
						case GM_SKELETON:
							tempArray = skeleton;
							break;
                    }
                }
                else
                {
                    return false;
                }
            }
        }
        else
        {
            return false;
        }

        return OnGroundCreature(tempArray, nr);
    }
	
	
	
	
	

	
	
	
	
	private function GetInitialHumanPosition(out initialPos : Vector) : bool
    {
        var i : int;
        var pos : Vector;
        var z : float;

		for(i=0; i<30; i+=1)
        {
            pos = thePlayer.GetWorldPosition() + VecConeRand(theCamera.GetCameraHeading(),  170 , -20, -25);

            FixZAxis(pos);
			
			if (CanSpawnEnt(pos))
            {
				initialPos = pos;
                return true;
			}
		}

        return false;
    }
	
	private function OnSpawnHuman () : bool
    {
        var humanTemplate : CEntityTemplate;
        var i, j, lvl, howMany, nr, skippedHumans : int;
        var resourcePathHuman	: string; 
        var currentArea : string;			
        var rot : EulerAngles;
        var pos, initialPos : Vector;
        var z : float;
        var skipHuman : bool;
		var temp : CEntity;
		var humanEnemies : array<CEntity>;
		var tempHumanArray : array<SEnemyTemplate>;
		var choose : array<EHumanType>;
		var temph : CRandomEncounterHumanNPC;

        currentArea = AreaTypeToName(theGame.GetCommonMapManager().GetCurrentArea());
            
        if (currentArea == "prolog_village")
        {
            for (i=0; i<3; i+=1) {choose.PushBack(HT_BANDIT);}
            for (i=0; i<2; i+=1) {choose.PushBack(HT_CANNIBAL);}
            for (i=0; i<2; i+=1) {choose.PushBack(HT_RENEGADE);}
        }	
        else if (currentArea == "skellige")
        {
                                    for (i=0; i<3; i+=1) {choose.PushBack(HT_SKELBANDIT);}
                                    for (i=0; i<3; i+=1) {choose.PushBack(HT_SKELBANDIT2);}
            if (isPlayerNearWater) {for (i=0; i<2; i+=1) {choose.PushBack(HT_SKELPIRATE);}}
        }
        else if (currentArea == "kaer_morhen")
        {
            for (i=0; i<3; i+=1) {choose.PushBack(HT_BANDIT);}
            for (i=0; i<2; i+=1) {choose.PushBack(HT_CANNIBAL);}
            for (i=0; i<2; i+=1) {choose.PushBack(HT_RENEGADE);}		
        }	
        else if (currentArea == "novigrad" || currentArea == "no_mans_land")
        {
                                    for (i=0; i<2; i+=1) {choose.PushBack(HT_NOVBANDIT);}
            if (isPlayerNearWater) {for (i=0; i<2; i+=1) {choose.PushBack(HT_PIRATE);}}
                                    for (i=0; i<3; i+=1) {choose.PushBack(HT_BANDIT);}
                                    for (i=0; i<1; i+=1) {choose.PushBack(HT_NILFGAARDIAN);}
                                    for (i=0; i<2; i+=1) {choose.PushBack(HT_CANNIBAL);}
                                    for (i=0; i<2; i+=1) {choose.PushBack(HT_RENEGADE);}
                                    for (i=0; i<1; i+=1) {choose.PushBack(HT_WITCHHUNTER);}			
        }
		else if (currentArea == "bob")
        {
            for (i=0; i<1; i+=1) {choose.PushBack(HT_NOVBANDIT);}
            for (i=0; i<4; i+=1) {choose.PushBack(HT_BANDIT);}
            for (i=0; i<1; i+=1) {choose.PushBack(HT_NILFGAARDIAN);}
            for (i=0; i<1; i+=1) {choose.PushBack(HT_CANNIBAL);}
            for (i=0; i<2; i+=1) {choose.PushBack(HT_RENEGADE);}		
        }
        else
        {
            return false;
        }
		
		if (choose.Size() == 0) return false;
        
        nr = choose[RandRange(choose.Size())];	

        switch (nr)
        {
            case HT_BANDIT:
                tempHumanArray = bandit;
                break;
            case HT_NOVBANDIT:
                tempHumanArray = novbandit;
                break;
            case HT_SKELBANDIT:
                tempHumanArray = skelbandit;
                break;
            case HT_SKELBANDIT2:
                tempHumanArray = skel2bandit;
                break;
            case HT_CANNIBAL:
                tempHumanArray = cannibal;
                break;
            case HT_RENEGADE:
                tempHumanArray = renegade;
                break;
            case HT_PIRATE:
                tempHumanArray = pirate;
                break;
            case HT_SKELPIRATE:
                tempHumanArray = skelpirate;
                break;
            case HT_NILFGAARDIAN:
                tempHumanArray = nilf;
                break;
            case HT_WITCHHUNTER:
                tempHumanArray = whunter;
                break;
        }
		

        if (selectedDifficulty == 0)
        {
            howMany = RandRange(4,6);
        }
        else if (selectedDifficulty == 1)
        {
            howMany = RandRange(4,7);
        }
        else if (selectedDifficulty == 2)
        {
            howMany = RandRange(5,8);
        }

        tempHumanArray = PrepareEnemyTemplate( tempHumanArray );
        
        skippedHumans = 0;

        if (!GetInitialHumanPosition(initialPos))
        {
            return false;
        }
        
        for (i = 0; i < howMany; i+=1)
        {
            skipHuman = false;

            for (j = 0; j<20; j += 1)
            {
                pos = initialPos + VecRingRand(1,3);

                if (!CanSpawnEnt(pos))
                {
                    if (j == 19)
                    {
                        skipHuman = true;
                    }
                }
                else
                {
                    break;
                }
            }

            if (skipHuman)
            {
                skippedHumans += 1;
                continue;
            }

            resourcePathHuman = ObtainTemplateForEnemy( tempHumanArray );
            humanTemplate = (CEntityTemplate)LoadResource( resourcePathHuman, true);					   
            temp = theGame.CreateEntity(humanTemplate, pos, rot);	 

			if (selectedDifficulty == 2)
            {				
                if ( GetWitcherPlayer().GetLevel() < 4 )
                {
                    lvl = RandRange(5, 0);
                }
                else
                {
                    lvl = RandRange(7, 0);					
                }
            }
            else if (selectedDifficulty == 1)
            {			
                if ( GetWitcherPlayer().GetLevel() < 4 )
                {
                    lvl = RandRange(4, 0);
                }
                else
                {
                    lvl = RandRange(6, -2);
                }
            }
			else
            {				
                if ( GetWitcherPlayer().GetLevel() < 4 )
                {
                    lvl = RandRange(2, 0);
                }
                else
                {
                    lvl = RandRange(3, -5);
                }
            }

        
            SetEnemyLevel((CNewNPC)temp, GetWitcherPlayer().GetLevel()+lvl);                    
            ((CNewNPC)temp).SetTemporaryAttitudeGroup( 'hostile_to_player', AGP_Default );
            ((CNewNPC)temp).NoticeActor(thePlayer);

            humanEnemies.PushBack(temp);
        }

        if (skippedHumans < howMany)
        {
			humanTemplate = (CEntityTemplate)LoadResource( pathToHumanDummy, true);								
			temph = (CRandomEncounterHumanNPC)theGame.CreateEntity(humanTemplate, thePlayer.GetWorldPosition(), thePlayer.GetWorldRotation());	
			temph.SetArray(humanEnemies);
			temph.AddTimer('BattleCry', 1, false);	
		}
		
		return true;
    }
	
	
	

	
	private function GetInitialWildHuntPosition(out initialPos : Vector, a, b, c : float) : bool
    {
        var i : int;
        var pos : Vector;
        var z : float;

		for(i=0; i<30; i+=1)
        {
            pos = thePlayer.GetWorldPosition() + VecConeRand(theCamera.GetCameraHeading(), a, b, c);

            FixZAxis(pos);
			
			if (CanSpawnEnt(pos))
            {
				initialPos = pos;
                return true;
			}
		}

        return false;
    }
	
	private function OnWildHunt() : bool
    {
        var lvl, howMany, howManyS, howManyLosers, i, j, ran : int;		
        var resourcePath, currentArea : string;
        var template, template2 : CEntityTemplate;		
        var rot : EulerAngles;
        var pos : Vector;		
        var z : float;
        var portals : array<CEntity>;
        var skipMonster : bool;
        var skippedMonsters : int;
        var initialPos : Vector;
		var tempWHArray : array<SEnemyTemplate>;
		var temp, temp2 : CEntity;
		var wildHuntEnemies : array<CEntity>;
		var tempw : CRandomEncounterWildHuntNPC;
		

        if (selectedDifficulty == 2)
        {
            howMany = RandRange(5, 1);
            howManyS = RandRange(4, 1);
            howManyLosers = RandRange(6, 2);
        }
        else if (selectedDifficulty == 1)
        {
            howMany = RandRange(4, 1);
            howManyS = RandRange(3, 1);
            howManyLosers = RandRange(5, 2);
        }
        else
        {
            howMany = RandRange(3, 1);
            howManyS = 1;
            howManyLosers = RandRange(4, 2);
        }

        skippedMonsters = 0;

        tempWHArray = whh;	
		tempWHArray = PrepareEnemyTemplate( tempWHArray );

        if (GetInitialWildHuntPosition(initialPos, 60, 20, 31))
        {
            for (i = 0; i < howMany; i+=1)
            {
                skipMonster = false;

                for (j = 0; j<20; j += 1)
                {
                    pos = initialPos + VecRingRand(1,3);

                    if (!CanSpawnEnt(pos))
                    {
                        if (j == 19)
                        {
                            skipMonster = true;
                        }
                    }
                    else
                    {
                        break;
                    }
                }

                if (skipMonster)
                {
                    skippedMonsters += 1;
                    continue;
                }

                resourcePath = ObtainTemplateForEnemy(tempWHArray);
                template = (CEntityTemplate)LoadResource( resourcePath, true);								
                            
                rot.Yaw = RandRange(180, -180);
                temp = theGame.CreateEntity(template, pos, rot);	
                template2 = (CEntityTemplate)LoadResource( "gameplay\interactive_objects\rift\rift.w2ent", true);			
                temp2 = theGame.CreateEntity(template2, pos, rot);
                portals.PushBack(temp2);
        
                SetEnemyLevel((CNewNPC)temp, RoundF(GetWitcherPlayer().GetLevel()/2));           
                ((CNewNPC)temp).SetTemporaryAttitudeGroup( 'hostile_to_player', AGP_Default );
                ((CNewNPC)temp).NoticeActor(thePlayer);		
                
                wildHuntEnemies.PushBack(temp);
            }
        }

        tempWHArray = wildHunt;	
		tempWHArray = PrepareEnemyTemplate( tempWHArray );

        if (GetInitialWildHuntPosition(initialPos, 170, -20, -31))
        {
            for (i = 0; i < howManyS; i+=1)
            {
                skipMonster = false;

                for (j = 0; j<20; j += 1)
                {
                    pos = initialPos + VecRingRand(1,3);

                    if (!CanSpawnEnt(pos))
                    {
                        if (j == 19)
                        {
                            skipMonster = true;
                        }
                    }
                    else
                    {
                        break;
                    }
                }

                if (skipMonster)
                {
                    skippedMonsters += 1;
                    continue;
                }

                resourcePath = ObtainTemplateForEnemy(tempWHArray);
                template = (CEntityTemplate)LoadResource( resourcePath, true);								
                    
                temp = theGame.CreateEntity(template, pos, rot);
                template2 = (CEntityTemplate)LoadResource( "gameplay\interactive_objects\rift\rift.w2ent", true);			
                temp2 = theGame.CreateEntity(template2, pos, rot);
                portals.PushBack(temp2);

                if (selectedDifficulty == 2)
                {				
                    if ( GetWitcherPlayer().GetLevel() < 4 )
                    {
                        lvl = RandRange(5, 0);
                    }
                    else
                    {
                        lvl = RandRange(10, 0);					
                    }
                }
                else if (selectedDifficulty == 1)
                {			
                    if ( GetWitcherPlayer().GetLevel() < 4 )
                    {
                        lvl = RandRange(4, 0);
                    }
                    else
                    {
                        lvl = RandRange(6, -4);
                    }
                }
                else
                {				
                    if ( GetWitcherPlayer().GetLevel() < 4 )
                    {
                        lvl = RandRange(2, 0);
                    }
                    else
                    {
                        lvl = RandRange(3, -7);
                    }
                }
            
                SetEnemyLevel((CNewNPC)temp, GetWitcherPlayer().GetLevel()+lvl);                    
                ((CNewNPC)temp).SetTemporaryAttitudeGroup( 'hostile_to_player', AGP_Default );
                ((CNewNPC)temp).NoticeActor(thePlayer);
            
                wildHuntEnemies.PushBack(temp);
            }
        }

        if (GetInitialWildHuntPosition(initialPos, 170, -20, -31))
        {
            for (i = 0; i < howManyLosers; i+=1)
            {
                skipMonster = false;

                for (j = 0; j<20; j += 1)
                {
                    pos = initialPos + VecRingRand(1,3);

                    if (!CanSpawnEnt(pos))
                    {
                        if (j == 19)
                        {
                            skipMonster = true;
                        }
                    }
                    else
                    {
                        break;
                    }
                }

                if (skipMonster)
                {
                    skippedMonsters += 1;
                    continue;
                }

                template = (CEntityTemplate)LoadResource( "quests\part_2\quest_files\q403_battle\characters\q403_wild_hunt_2h_sword.w2ent", true);								

                temp = theGame.CreateEntity(template, pos, rot);	 
                
                SetEnemyLevel((CNewNPC)temp, RoundF(GetWitcherPlayer().GetLevel()/1.4));                    
                ((CNewNPC)temp).SetTemporaryAttitudeGroup( 'hostile_to_player', AGP_Default );
                ((CNewNPC)temp).NoticeActor(thePlayer);

                wildHuntEnemies.PushBack(temp);
                
                ran = RandRange(8);
        
                switch(ran){
                case 0:
                    ((CNewNPC)temp).ApplyAppearance( "wild_hunt_01" );
                    break;
                case 1:
                    ((CNewNPC)temp).ApplyAppearance( "wild_hunt_02" );
                    break;
                case 2:
                    ((CNewNPC)temp).ApplyAppearance( "wild_hunt_03" );
                    break;
                case 3:
                    ((CNewNPC)temp).ApplyAppearance( "wild_hunt_04" );
                    break;
                case 4:
                    ((CNewNPC)temp).ApplyAppearance( "wild_hunt_05" );
                    break;
                case 5:
                    ((CNewNPC)temp).ApplyAppearance( "wild_hunt_06" );
                    break;
                case 6:
                    ((CNewNPC)temp).ApplyAppearance( "wild_hunt_07" );
                    break;
                case 7:
                    ((CNewNPC)temp).ApplyAppearance( "wild_hunt_08" );
                    break;
                }
            }
        }

        if (skippedMonsters < (howMany + howManyS + howManyLosers))
        {
            currentArea = AreaTypeToName(theGame.GetCommonMapManager().GetCurrentArea());

			if (currentArea == "skellige" || currentArea == "kaer_morhen")	
			{
				RequestWeatherChangeTo('WT_Blizzard',7, false );			
			}
			else
			{
				RequestWeatherChangeTo('WT_Snow',7, false );
			}	

            template = (CEntityTemplate)LoadResource( pathToWHDummy, true);								
			tempw = (CRandomEncounterWildHuntNPC)theGame.CreateEntity(template, thePlayer.GetWorldPosition(), thePlayer.GetWorldRotation());	
			tempw.SetArray(wildHuntEnemies);
			tempw.AddTimer('BattleCry', 1, false);
			tempw.AddTimer('NormalWeather',60, false);
			tempw.OnSetPortals(portals);
			tempw.AddTimer('PortalEffect',0.09,false);	

			return true;
        }else{
			return false;
		}
    }
	
	
	
	private function GetEnemyLevel(level : int, cTempArray : array<SEnemyTemplate>) : int
    {
        var flevel : int;

        flevel = Clamp(level, 1, 100);

        if (cTempArray == werewolf)
        {
            flevel -= 4;
        }
        else if (cTempArray == ekimmara)
        {
            flevel -= 6;
        }
        else if (cTempArray == katakan)
        {
            flevel -= 9;
        }
        else if (cTempArray == wolf)
        {
            flevel -= 4;
        }
        else if (cTempArray == skelwolf)
        {
            flevel -= 14;
        }

        return flevel;
    }
	
	public function IsLevelMet(monster : EGroundMonsterType) : bool
    {
        var rlvl : int;

        switch (monster)
        {
            case GM_BARGHEST:
                rlvl = 10;
                break;
            case GM_BRUXA:
                rlvl = 20;
                break;
            case GM_ECHINOPS:
                rlvl = 15;
                break;
            case GM_KIKIMORE:
                rlvl = 15;
                break;
            case GM_CENTIEDE:
                rlvl = 18;
                break;
            case GM_EKIMMARA:
                rlvl = 15;
                break;
            case GM_KATAKAN:
                rlvl = 20;
                break;
            default:
                rlvl = 0;
                break;
        }

        return GetWitcherPlayer().GetLevel() >= rlvl;
    }
	
	
	
	private function SetEnemyLevel(enemy : CNewNPC, level : int, optional cTempArray : array<SEnemyTemplate> )
    {
        var flevel : int;

        flevel = Clamp(level, 1, 100);

        if (cTempArray == werewolf)
        {
            flevel -= 4;
        }
        else if (cTempArray == ekimmara)
        {
            flevel -= 6;
        }
        else if (cTempArray == katakan)
        {
            flevel -= 9;
        }
        else if (cTempArray == wolf)
        {
            flevel -= 4;
        }
        else if (cTempArray == skelwolf)
        {
            flevel -= 14;
        }

        enemy.SetLevel(flevel);
    }
	
	public function CanSpawnEnt(pos : Vector) : bool
    {
        var template : CEntityTemplate;
		var rot : EulerAngles;
        var canSpawn : bool;
        var ract : CActor;
        var currentArea : string;
        var inSettlement : bool;

        canSpawn = false;

        template = (CEntityTemplate)LoadResource( "characters\npc_entities\animals\hare.w2ent", true );	
        ract = (CActor)theGame.CreateEntity(template, pos, rot);	
        ((CNewNPC)ract).SetGameplayVisibility(false);
        ((CNewNPC)ract).SetVisibility(false);		
        ract.EnableCharacterCollisions(false);
        ract.EnableDynamicCollisions(false);
        ract.EnableStaticCollisions(false);
        ract.SetImmortalityMode(AIM_Invulnerable, AIC_Default);

        currentArea = AreaTypeToName(theGame.GetCommonMapManager().GetCurrentArea());

        if (currentArea == "skellige")
        {
            //inSettlement = ract.TestIsInSettlement2();
			// TODO
        }
        else
        {
            inSettlement = ract.TestIsInSettlement();
        }

        if (!inSettlement && pos.Z >= theGame.GetWorld().GetWaterLevel(pos, true) && !((CNewNPC)ract).IsInInterior())
        {
            canSpawn = true;
        }

        ract.Destroy();

        return canSpawn;
    }
	
	
	
	
	
	public function IsPlayerNearWater() : bool
    {
        var i, j : int;
        var pos, newPos : Vector;
        var vectors : array<Vector>;
        var world : CWorld;
        var waterDepth : float;

        pos = thePlayer.GetWorldPosition();

        world = theGame.GetWorld();

        for (i = 2; i <= 50; i += 2)
        {
            vectors = VecSphere(10, i);
        
            for (j = 0; j < vectors.Size(); j += 1)
            {
                newPos = pos + vectors[j];
                FixZAxis(newPos);
                waterDepth = world.GetWaterDepth(newPos, true);

                if (waterDepth > 1.0f && waterDepth != 10000.0)
                {
                    return true;
                }
            }
        }

        return false;
    }

    public function IsPlayerInForest() : bool
    {
        var cg : array<name>;
        var i, j, k : int;
        var compassPos : array<Vector>;
        var angles : array<int>;
        var angle : int;
        var vectors : array<Vector>;
        var tracePosStart, tracePosEnd : Vector;
        var material : name;
        var component : CComponent;
        var outPos, normal : Vector;
        var angularQuantity, totalQuantity : int;
        var lastPos : Vector;
        var skip : bool;
        var skipIdx : int;

		cg.PushBack('Foliage');

        compassPos = VecSphere(90, 20);
        compassPos.Insert(0, thePlayer.GetWorldPosition());

        for (i = 1; i < compassPos.Size(); i += 1)
        {
            compassPos[i] = compassPos[0] + compassPos[i];
            FixZAxis(compassPos[i]);
            compassPos[i].Z += 10;
        }

        compassPos[0].Z += 10;

        angles.PushBack(0);
        angles.PushBack(90);
        angles.PushBack(180);
        angles.PushBack(270);

        totalQuantity = 0;

        skip = false;
        skipIdx = -1;

        for (i = 0; i < compassPos.Size(); i += 1)
        {
            for (j = 0; j < angles.Size(); j += 1)
            {
                angularQuantity = 0;
                angle = angles[j];
                vectors = VecArc(angle, angle+90, 5, 25);

                for (k = 0; k < vectors.Size(); k += 1)
                {
                    tracePosStart = compassPos[i];
                    tracePosEnd = tracePosStart;
                    tracePosEnd.Z -= 10;
                    tracePosEnd = tracePosEnd + vectors[k];
                    FixZAxis(tracePosEnd);
                    tracePosEnd.Z += 10;

                    if (theGame.GetWorld().StaticTraceWithAdditionalInfo(tracePosStart, tracePosEnd, outPos, normal, material, component, cg))
                    {
                        if (material == 'default' && !component)
                        {
                            if (VecDistanceSquared(lastPos, outPos) > 10)
                            {
                                lastPos = outPos;
                                angularQuantity += 1;
                                totalQuantity += 1;
                            }
                        }
                    }
                }

                if (angularQuantity < 1)
                {
                    if (i > 0 && (!skip || skipIdx == i))
                    {
                        skip = true;
                        skipIdx = i;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }

        return totalQuantity > 10;
    }

    public function IsPlayerInSwamp() : bool
    {

        var i, j : int;
        var pos, newPos : Vector;
        var vectors : array<Vector>;
        var world : CWorld;
        var waterDepth : float;
        var wetTerrainQuantity : int;

        pos = thePlayer.GetWorldPosition();

        world = theGame.GetWorld();

        wetTerrainQuantity = 0;

        for (i = 2; i <= 50; i += 2)
        {
            vectors = VecSphere(10, i);
        
            for (j = 0; j < vectors.Size(); j += 1)
            {
                newPos = pos + vectors[j];
                FixZAxis(newPos);
                waterDepth = world.GetWaterDepth(newPos, true);

                if (waterDepth > 0 && waterDepth < 1.5f)
                {
                    wetTerrainQuantity += 1;
                }
                else
                {
                    wetTerrainQuantity -= 1;
                }
            }
        }

        return wetTerrainQuantity > -300;
    }

    private function SetPlayerArea()
    {
        isPlayerNearWater = IsPlayerNearWater();
        isPlayerInForest = IsPlayerInForest();
        isPlayerInSwamp = IsPlayerInSwamp();
		
		if (isPlayerInForest && isPlayerInSwamp)
        {
            isPlayerInSwampForest = true;
            isPlayerInForest = false;
            isPlayerInSwamp = false;
        }
        else
        {
            isPlayerInSwampForest = false;
        }
    }
	
	
	
	
	function getXMLSettings( show : bool ){
		var inGameConfigWrapper : CInGameConfigWrapper;

		if(show)
			theGame.GetGuiManager().ShowNotification("Random Encounter settings have been saved!");

        inGameConfigWrapper = theGame.GetInGameConfigWrapper();
        
		// Encounter chances for day and night
        isFlyingActiveD  = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceDay', 'enableFlyingMonsters')); 
        isGroundActiveD = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceDay', 'enableGroundMonsters'));	
        isHumanActiveD = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceDay', 'enableHumanEnemies'));
        isWildHuntActiveD = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceDay', 'enableWildHunt'));
        isGroupActiveD = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceDay', 'enableGroupMonsters'));

        isFlyingActiveN  = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceNight', 'enableFlyingMonsters')); 
        isGroundActiveN = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceNight', 'enableGroundMonsters'));	
        isHumanActiveN = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceNight', 'enableHumanEnemies'));
        isWildHuntActiveN = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceNight', 'enableWildHunt'));
        isGroupActiveN = StringToInt(inGameConfigWrapper.GetVarValue('encounterChanceNight', 'enableGroupMonsters'));
		
		// Day/night chances
		chanceDay   = StringToInt(inGameConfigWrapper.GetVarValue('RandomEncountersMENU', 'dayFrequency'));
		chanceNight = StringToInt(inGameConfigWrapper.GetVarValue('RandomEncountersMENU', 'nightFrequency'));
        
		// Trophy cutscene and collection of trophies from certain monsters
		enableTrophies = inGameConfigWrapper.GetVarValue('RandomEncountersMENU', 'enableTrophies'); 	

		// Difficulty
        selectedDifficulty = StringToInt(inGameConfigWrapper.GetVarValue('RandomEncountersMENU', 'Difficulty'));
		
		// City spawns in general and special bruxa/alp spawns in cities
		citySpawn = StringToInt(inGameConfigWrapper.GetVarValue('RandomEncountersMENU', 'citySpawn'));
		cityBruxa = StringToInt(inGameConfigWrapper.GetVarValue('RandomEncountersMENU', 'cityBruxa'));
		
		// Hunts
        flyingMonsterHunts = StringToInt(inGameConfigWrapper.GetVarValue('monsterHuntChance', 'flyingMonsterHunts'));
        groundMonsterHunts = StringToInt(inGameConfigWrapper.GetVarValue('monsterHuntChance', 'groundMonsterHunts'));
        groupMonsterHunts = StringToInt(inGameConfigWrapper.GetVarValue('monsterHuntChance', 'groupMonsterHunts'));	
		
		// Custom frequencies and monsters
		customFrequency = inGameConfigWrapper.GetVarValue('custom', 'customFrequencyToggle'); 		
		customDayMax = StringToInt(inGameConfigWrapper.GetVarValue('custom', 'customdFrequencyHigh'));
		customDayMin = StringToInt(inGameConfigWrapper.GetVarValue('custom', 'customdFrequencyLow'));
		customNightMax = StringToInt(inGameConfigWrapper.GetVarValue('custom', 'customnFrequencyHigh'));
		customNightMin = StringToInt(inGameConfigWrapper.GetVarValue('custom', 'customnFrequencyLow'));	
        customFlying = inGameConfigWrapper.GetVarValue('custom', 'customFlyingMonsters'); 		
        customGround = inGameConfigWrapper.GetVarValue('custom', 'customGroundMonsters'); 
        customGroup = inGameConfigWrapper.GetVarValue('custom', 'customGroupMonsters');
		
		flyingMonsterList();
		customFlyingMonsterList();
		groundMonsterList();
		customGroundMonsterList();
		groupMonsterList();
		customGroupMonsterList();
	}
	
	
	
	function flyingMonsterList ()
    {
        var inGameConfigWrapper : CInGameConfigWrapper;

        inGameConfigWrapper = theGame.GetInGameConfigWrapper();
        
        isCGryphons = inGameConfigWrapper.GetVarValue('monsterList', 'Gryphons');
        isCCockatrice = inGameConfigWrapper.GetVarValue('monsterList', 'Cockatrice');
        isCWyverns = inGameConfigWrapper.GetVarValue('monsterList', 'Wyverns');
        isCForktails = inGameConfigWrapper.GetVarValue('monsterList', 'Forktails');
    }
	
	function customFlyingMonsterList ()
    {
        var inGameConfigWrapper : CInGameConfigWrapper;

        inGameConfigWrapper = theGame.GetInGameConfigWrapper();
    
        isGryphonsD = StringToInt(inGameConfigWrapper.GetVarValue('customFlyingDay', 'Gryphons'));
        isCockatriceD = StringToInt(inGameConfigWrapper.GetVarValue('customFlyingDay', 'Cockatrice'));
        isWyvernsD = StringToInt(inGameConfigWrapper.GetVarValue('customFlyingDay', 'Wyverns'));
        isForktailsD = StringToInt(inGameConfigWrapper.GetVarValue('customFlyingDay', 'Forktails'));

        isGryphonsN = StringToInt(inGameConfigWrapper.GetVarValue('customFlyingNight', 'Gryphons'));
        isCockatriceN = StringToInt(inGameConfigWrapper.GetVarValue('customFlyingNight', 'Cockatrice'));
        isWyvernsN = StringToInt(inGameConfigWrapper.GetVarValue('customFlyingNight', 'Wyverns'));
        isForktailsN = StringToInt(inGameConfigWrapper.GetVarValue('customFlyingNight', 'Forktails'));
    }	
	
	
    
    function groundMonsterList ()
    {
        var inGameConfigWrapper : CInGameConfigWrapper;

        inGameConfigWrapper = theGame.GetInGameConfigWrapper();
        
        isCLeshens = inGameConfigWrapper.GetVarValue('monsterList', 'Leshens');
        isCWerewolves = inGameConfigWrapper.GetVarValue('monsterList', 'Werewolves');
        isCCyclops = inGameConfigWrapper.GetVarValue('monsterList', 'Cyclops');
        isCArachas = inGameConfigWrapper.GetVarValue('monsterList', 'Arachas');
        isCFiends = inGameConfigWrapper.GetVarValue('monsterList', 'Fiends');
        isCChorts = inGameConfigWrapper.GetVarValue('monsterList', 'Chorts');
        isCEkimmara = inGameConfigWrapper.GetVarValue('monsterList', 'Ekimmara');
        isCKatakan = inGameConfigWrapper.GetVarValue('monsterList', 'Katakan');
        isCBears = inGameConfigWrapper.GetVarValue('monsterList', 'Bears');
        isCGolems = inGameConfigWrapper.GetVarValue('monsterList', 'Golems');
        isCElementals = inGameConfigWrapper.GetVarValue('monsterList', 'Elementals');
        isCNightWraiths = inGameConfigWrapper.GetVarValue('monsterList', 'NightWraiths');
        isCNoonWraiths = inGameConfigWrapper.GetVarValue('monsterList', 'NoonWraiths');
        isCTroll = inGameConfigWrapper.GetVarValue('monsterList', 'Troll');
        isCHags = inGameConfigWrapper.GetVarValue('monsterList', 'Hags');

		// Blood and Wine
		isCBruxa = inGameConfigWrapper.GetVarValue('monsterList', 'Bruxa');
		isCHigherVamp = inGameConfigWrapper.GetVarValue('monsterList', 'HigherVamp');
		isCFleder = inGameConfigWrapper.GetVarValue('monsterList', 'Fleder');
		isCGarkain = inGameConfigWrapper.GetVarValue('monsterList', 'Garkain');
		isCPanther = inGameConfigWrapper.GetVarValue('monsterList', 'Panther');
		isCSharley = inGameConfigWrapper.GetVarValue('monsterList', 'Sharley');
		isCGiant = inGameConfigWrapper.GetVarValue('monsterList', 'Giant');
		isCBoar = inGameConfigWrapper.GetVarValue('monsterList', 'Boars');
    }

	 function customGroundMonsterList ()
    {
        var inGameConfigWrapper : CInGameConfigWrapper;

        inGameConfigWrapper = theGame.GetInGameConfigWrapper();
        
        isLeshensD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Leshens'));
        isWerewolvesD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Werewolves'));
        isCyclopsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Cyclops'));
        isArachasD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Arachas'));
        isFiendsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Fiends'));
        isChortsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Chorts'));
        isEkimmaraD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Ekimmara'));
        isKatakanD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Katakan'));
        isBearsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Bears'));
        isGolemsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Golems'));
        isElementalsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Elementals'));
        isNightWraithsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'NightWraiths'));
        isNoonWraithsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'NoonWraiths'));
        isTrollD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Troll'));
        isHagsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Hags'));

        isLeshensN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Leshens'));
        isWerewolvesN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Werewolves'));
        isCyclopsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Cyclops'));
        isArachasN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Arachas'));
        isFiendsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Fiends'));
        isChortsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Chorts'));
        isEkimmaraN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Ekimmara'));
        isKatakanN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Katakan'));
        isBearsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Bears'));
        isGolemsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Golems'));
        isElementalsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Elementals'));
        isNightWraithsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'NightWraiths'));
        isNoonWraithsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'NoonWraiths'));
        isTrollN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Troll'));
        isHagsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Hags'));

		// Blood and Wine

		isBruxaD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Bruxa'));
		isHigherVampD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'HigherVamp'));
		isFlederD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Fleder'));
		isGarkainD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Garkain'));
		isPantherD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Panther'));
		isSharleyD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Sharley'));		
		isGiantD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Giant'));
		isBoarD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Boars'));
		
		isBruxaN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Bruxa'));
		isHigherVampN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'HigherVamp'));
		isFlederN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Fleder'));
		isGarkainN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Garkain'));
		isPantherN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Panther'));
		isSharleyN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Sharley'));		
		isGiantN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Giant'));
		isBoarN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Boars'));
    }		
	
	
	
	
    function groupMonsterList ()
    {
        var inGameConfigWrapper : CInGameConfigWrapper;

        inGameConfigWrapper = theGame.GetInGameConfigWrapper();
        
        isCHarpy = inGameConfigWrapper.GetVarValue('monsterList', 'Harpies');
        isCFogling = inGameConfigWrapper.GetVarValue('monsterList', 'Fogling');
        isCEndrega = inGameConfigWrapper.GetVarValue('monsterList', 'Endrega');
        isCGhouls = inGameConfigWrapper.GetVarValue('monsterList', 'Ghouls');
        isCAlghouls = inGameConfigWrapper.GetVarValue('monsterList', 'Alghouls');
        isCNekkers = inGameConfigWrapper.GetVarValue('monsterList', 'Nekkers');
        isCDrowners = inGameConfigWrapper.GetVarValue('monsterList', 'Drowners');
        isCRotfiends = inGameConfigWrapper.GetVarValue('monsterList', 'Rotfiends');
        isCWolves = inGameConfigWrapper.GetVarValue('monsterList', 'Wolves');
        isCWraiths = inGameConfigWrapper.GetVarValue('monsterList', 'Wraiths');
        isCSpiders = inGameConfigWrapper.GetVarValue('monsterList', 'Spiders');

		// Blood and Wine
		isCDrownerDLC = inGameConfigWrapper.GetVarValue('monsterList', 'DrownerDLC');
		isCSkeleton = inGameConfigWrapper.GetVarValue('monsterList', 'Skeleton');
		isCBarghest = inGameConfigWrapper.GetVarValue('monsterList', 'Barghest');
		isCEchinops = inGameConfigWrapper.GetVarValue('monsterList', 'Echinops');
		isCCentipede = inGameConfigWrapper.GetVarValue('monsterList', 'Centipede');
		isCKikimore = inGameConfigWrapper.GetVarValue('monsterList', 'Kikimore');
		isCWight = inGameConfigWrapper.GetVarValue('monsterList', 'Wight');
    }
    
   
    function customGroupMonsterList ()
    {
        var inGameConfigWrapper : CInGameConfigWrapper;

        inGameConfigWrapper = theGame.GetInGameConfigWrapper();

        isHarpyD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Harpies'));
        isFoglingD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Fogling'));
        isEndregaD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Endrega'));
        isGhoulsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Ghouls'));
        isAlghoulsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Alghouls'));
        isNekkersD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Nekkers'));
        isDrownersD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Drowners'));
        isRotfiendsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Rotfiends'));
        isWolvesD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Wolves'));
        isWraithsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Wraiths'));
        isSpidersD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Spiders'));

        isHarpyN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Harpies'));
        isFoglingN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Fogling'));
        isEndregaN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Endrega'));
        isGhoulsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Ghouls'));
        isAlghoulsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Alghouls'));
        isNekkersN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Nekkers'));
        isDrownersN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Drowners'));
        isRotfiendsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Rotfiends'));
        isWolvesN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Wolves'));
        isWraithsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Wraiths'));
        isSpidersN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Spiders'));

		// Blood and Wine
		isBarghestD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Barghest')); 
		isEchinopsD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Echinops')); 
		isCentipedeD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Centipede'));
		isKikimoreD = StringToInt(inGameConfigWrapper.GetVarValue('customGroupDay', 'Kikimore'));
		isWightD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Wight'));
		isSkeletonD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'Skeleton'));
		isDrownerDLCD = StringToInt(inGameConfigWrapper.GetVarValue('customGroundDay', 'DrownerDLC'));
		
		isBarghestN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Barghest')); 
		isEchinopsN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Echinops')); 
		isCentipedeN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Centipede'));
		isKikimoreN = StringToInt(inGameConfigWrapper.GetVarValue('customGroupNight', 'Kikimore'));	
		isWightN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Wight'));
		isSkeletonN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'Skeleton'));
		isDrownerDLCN = StringToInt(inGameConfigWrapper.GetVarValue('customGroundNight', 'DrownerDLC'));
    }
	
	
	
	
	
	
	
	
}


function VecArc(angleStart : int, angleEnd : int, angleStep : int, radius : float) : array<Vector>
{
    var i : int;
	var angle : float;
    var v : Vector;
    var vectors: array<Vector>;

    for (i = angleStart; i < angleEnd; i += angleStep)
    {
        angle = Deg2Rad(i);
        v = Vector(radius * CosF(angle), radius * SinF(angle), 0.0, 1.0);
        vectors.PushBack(v);
    }

    return vectors;
}

function VecSphere(angleStep : int, radius : float) : array<Vector>
{
    var i : int;
	var angle : float;
    var v : Vector;
    var vectors: array<Vector>;

    for (i = 0; i < 360; i += angleStep)
    {
        angle = Deg2Rad(i);
        v = Vector(radius * CosF(angle), radius * SinF(angle), 0.0, 1.0);
        vectors.PushBack(v);
    }

    return vectors;
}

function FixZAxis(out pos : Vector)
{
    var world : CWorld;
    var z : float;

    world = theGame.GetWorld();

    if (world.NavigationComputeZ(pos, pos.Z - 128, pos.Z + 128, z))
    {
        pos.Z = z;
    }

    if (world.PhysicsCorrectZ(pos, z))
    {
        pos.Z = z;
    }
}
















