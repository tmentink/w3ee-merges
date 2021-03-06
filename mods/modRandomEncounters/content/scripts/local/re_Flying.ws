//--- RandomEncounters ---
// Made by Erxv
// http://www.nexusmods.com/witcher3/mods/785?

class CRandomEncounterFlyingNPCEntity extends CEntity{
	
	private var monster, rabbit : CEntity;
	private var monsterActor, rabbitActor : CActor;
	private var monsterNPC : CNewNPC;
	private var isHunt, blood, playedVoice, isPassive, CombatCanStartBool  : bool;
	private var bloodArray : array<CEntity>;
	private var world : CWorld;
	private var playerPos : Vector;
	private var type : EFlyingMonsterType;
	
	event OnSpawned( spawnData : SEntitySpawnData ){
		super.OnSpawned(spawnData);

		AddTimer('Check', 2, true);
		
		playedVoice = false;
	}
	
	
	
	public function SetMonsterAttributes(ent : CEntity, hunt : bool, optional enableTrophies : bool, optional nr : EFlyingMonsterType, optional passive : bool, optional bloodArr : array<CEntity>){
		playerPos = thePlayer.GetWorldPosition();
		world = theGame.GetWorld();
		this.monster = ent;
		this.monsterActor = ((CActor)ent);
		this.monsterNPC = ((CNewNPC)ent);
		this.isHunt = hunt;
		this.bloodArray = bloodArr;
		this.type = nr;
		
		this.CreateAttachment( monster );
		
		isPassive = passive;
		
		
		if(!hunt)
			SpawnRabbit();
		
		if(enableTrophies)
			AddTrophy();
	}

	
	private function SpawnRabbit(){
		var resourcePath : string;
		var template : CEntityTemplate;
		var pos : Vector;
		var rot : EulerAngles;
		
		resourcePath = "characters\npc_entities\animals\hare.w2ent";
        template = (CEntityTemplate)LoadResource( resourcePath, true );			
		
		if(isPassive){
			pos = thePlayer.GetWorldPosition() + VecRingRand(10,15);
		}else{
			pos = thePlayer.GetWorldPosition() + VecRingRand(5,4);
		}
		
		
		rabbit = theGame.CreateEntity(template, pos, rot);		

		rabbitActor = ((CActor)rabbit);
		
        ((CNewNPC)rabbit).SetGameplayVisibility(false);
        ((CNewNPC)rabbit).SetVisibility(false);		
        rabbitActor.EnableCharacterCollisions(false);
        rabbitActor.EnableDynamicCollisions(false);
        rabbitActor.EnableStaticCollisions(false);
        rabbitActor.SetImmortalityMode(AIM_Immortal, AIC_Default);			
		
		monsterNPC.NoticeActor(rabbitActor);
		if(isPassive){
			AddTimer('RabbitTeleportStart', 2, false);
		}else{
			AddTimer('RabbitTeleport', 2, true);
		}	
	}
	
	timer function RabbitTeleportStart ( optional dt : float, optional id : Int32 )
	{
		var pos : Vector;

		pos = playerPos + VecRingRand( 10, 5);
		
		AddTimer('RabbitTeleport',2,true);
	}
	
	timer function RabbitTeleport ( optional dt : float, optional id : Int32 )
	{
		var pos : Vector;
	
		if(isPassive){
			pos = monster.GetWorldPosition() + VecConeRand(monster.GetHeading(), 30, 40, 40);
			FixZAxis(pos);
			pos.Z += RandRange(25,30);	
			rabbit.Teleport(pos);
			monsterNPC.NoticeActor(rabbitActor);			
		}else{
			if(VecDistance(playerPos,monster.GetWorldPosition()) < 35){
				monsterNPC.NoticeActor(thePlayer);				
				this.rabbit.Destroy();
				RemoveTimer('RabbitTeleport');
			}else{
				pos = playerPos + VecRingRand( 10, 5);
				rabbit.Teleport(pos);
				monsterNPC.NoticeActor(rabbitActor);
			}			
		}
	}

	timer function Check ( optional dt : float, optional id : Int32 )
	{
		var distanceBetweenBlood, dist : float;
		var pos : Vector;
		var i : int;
		
		playerPos = thePlayer.GetWorldPosition();
		
		
		pos = monster.GetWorldPosition();
		dist = VecDistance(pos,playerPos); 
					

		if (dist > 520){
			monsterActor.Kill('RandomEncounters', true);
			monster.Destroy();
		}
		
		for(i=0;i<bloodArray.Size();i+=1)
		{
			// --- Plays voice when close enough ---
			distanceBetweenBlood = VecDistance(bloodArray[i].GetWorldPosition(), playerPos);
			if (distanceBetweenBlood < 11 && !playedVoice && !thePlayer.IsInCombat())
			{
				thePlayer.PlayVoiceset( 90, "MiscInvestigateArea" );
                AddTimer('VoiceBlood',2.9,false);
                playedVoice = true;
			}
			// --- Destroys blood when too far ---
			if (distanceBetweenBlood > 350.0)
			{
				bloodArray[i].Destroy();
				bloodArray.Remove(bloodArray[i]);	
				i -= 1;
			}
		}	
		
		if( CombatCanStartBool)
		{
			if(monsterActor && !monsterActor.IsAlive() && VecDistance(monster.GetWorldPosition(), playerPos) < 40 )
			{
				AddTimer('NormalMusic',1.0,false);
				CombatCanStartBool = false;
			}
		}
		
		
		if(!monster || !monsterActor.IsAlive()){
			Clean();
		}
	}
	
	private function Clean(){
		var i : int;
		
		for(i = 0; i < bloodArray.Size(); i+=1){
			bloodArray[i].Destroy();
		}
		bloodArray.Clear();
		
		if( VecDistance(monster.GetWorldPosition(),thePlayer.GetWorldPosition()) > 500 )
			monster.Destroy();
			
		rabbit.Destroy();
		
		RemoveTimer('RabbitTeleport');
		RemoveTimer('RabbitTeleportStart');
		RemoveTimer('Check');
		theSound.SoundEvent("stop_music");
		theSound.InitializeAreaMusic( theGame.GetCommonMapManager().GetCurrentArea() );
		this.Destroy();
	}
	
	
	timer function VoiceBlood ( optional dt : float, optional id : Int32 )
	{	
		thePlayer.PlayVoiceset( 90, "MiscBloodTrail" );  
	}
	
	
	
	public function AddTrophy(){
		var inv : CInventoryComponent;
		var allItems : array<SItemUniqueId>;
		var i : int;
		
		inv = monsterActor.GetInventory();
			
		allItems.Clear();
		inv.GetAllItems(allItems);
		
		for(i = 0; i < allItems.Size(); i+=1){
			inv.AddItemTag( allItems[i], 'TemporaryRandomTag' );		
		}
		
		if(type == FM_GRYPHON || type == FM_GRYPHONDLC)
		{
			if(StrContains(monster, "volcanic"))
			{
				inv.AddAnItem('mh301_gryphon_trophy',1);
			}
			else
			{
				inv.AddAnItem('q002_griffin_trophy',1);
			}						
		}
		else if(type == FM_COCKATRICE || type == FM_COCKATRICEDLC || type == FM_BASILISK || type == FM_BASILISKDLC)
		{
			if(StrContains(monster, "cockatrice"))
			{
				inv.AddAnItem('mh101_cockatrice_trophy',1);	
			}
		}
		else if(type == FM_WYVERN)
		{
			if(!StrContains(monster, "wyvern"))
			{
				inv.AddAnItem('mh105_wyvern_trophy',1);	
			}
		}
		else if(type == FM_FORKTAIL)
		{
			inv.AddAnItem('mh208_forktail_trophy',1);
		}			

		for(i=0; i<allItems.Size(); i+=1)
		{
			if( !inv.ItemHasTag( allItems[i], 'TemporaryRandomTag' ) ){
				inv.AddItemTag( allItems[i], 'Custom_Trophy' );
				inv.RemoveItemTag( allItems[i], 'Quest' );	
				break;
			}												
		}					
	
		for(i = 0; i < allItems.Size(); i+=1){
			inv.RemoveItemTag( allItems[i], 'TemporaryRandomTag' );		
		}
	}
	
	
	
	
	public function SetMonsterAttributesAlt(ent : CEntity, hunt : bool, optional enableTrophies : bool, optional nr : EFlyingMonsterType, optional bloodArr : array<CEntity>){
		playerPos = thePlayer.GetWorldPosition();
		world = theGame.GetWorld();
		this.monster = ent;
		this.monsterActor = ((CActor)ent);
		this.monsterNPC = ((CNewNPC)ent);
		this.bloodArray = bloodArr;
		this.type = nr;
		this.isHunt = hunt;
		
		this.CreateAttachment( monster );
		
		
		if(enableTrophies)
			AddTrophy();
			
		

		l_aiTreeIdleAnim = new CAIPlayAnimationSlotAction in ((CActor)ent);
		l_aiTreeIdleAnim.OnCreated();
		l_aiTreeIdleAnim.animName = 'monster_gryphon_idle';			
		l_aiTreeIdleAnim.blendInTime = 1.0f;
		l_aiTreeIdleAnim.blendOutTime = 1.0f;	
		l_aiTreeIdleAnim.slotName = 'NPC_ANIM_SLOT';	
		
		
		
		AddTimer('IdleOrFight', 0.1, false );


	}
	
	private var l_aiTreeIdleAnim : CAIPlayAnimationSlotAction;
	private var animationInt : int;
	timer function IdleOrFight( optional dt : float, optional id : Int32 ){
		var l_aiTree2 : CAIFlightIdleFreeRoam;	
		var i : int;
		var pos : Vector;
		var template : CEntityTemplate;
		var rot : EulerAngles;
		
		animationInt = monsterActor.ForceAIBehavior( l_aiTreeIdleAnim, BTAP_Emergency );
		
		monsterNPC.ForgetActor(monsterActor.GetTarget());
		
		if( VecDistance(monster.GetWorldPosition(), playerPos) > 45)
		{
			AddTimer('IdleOrFight',0.01,false);
			animationInt = monsterActor.ForceAIBehavior( l_aiTreeIdleAnim, BTAP_Emergency );
		}
		else
		{									
			monsterNPC.ForgetActor(thePlayer);
			monsterActor.CancelAIBehavior(animationInt);
			
			for(i=0;i<100;i+=1)
			{
				monsterActor.CancelAIBehavior(i);
			}

			monsterNPC.SetTemporaryAttitudeGroup( 'friendly_to_player', AGP_Default );		
			
			l_aiTree2 = new CAIFlightIdleFreeRoam in monsterActor;		
			i = monsterActor.ForceAIBehavior( l_aiTree2, BTAP_Emergency );	

			pos = playerPos;
			pos = pos + VecConeRand(thePlayer.GetHeading(), 1,-10,-11);				
			template = (CEntityTemplate)LoadResource( "characters\npc_entities\animals\hare.w2ent", true );	
			rabbit.Destroy();
			rabbit = theGame.CreateEntity(template, pos, rot);	
			((CNewNPC)rabbit).SetGameplayVisibility(false);
			((CNewNPC)rabbit).SetVisibility(false);		
			((CActor)rabbit).EnableCharacterCollisions(false);
			((CActor)rabbit).EnableDynamicCollisions(false);
			((CActor)rabbit).EnableStaticCollisions(false);
			((CActor)rabbit).SetImmortalityMode(AIM_Invulnerable, AIC_Default);	
			
			
			
			AddTimer('ActualFight',0.5,false);
			monsterNPC.NoticeActor(((CActor)rabbit));
			RemoveTimer('IdleOrFight');	
		}
	}
	
	timer function ActualFight ( optional dt : float, optional id : Int32 )
	{
		monsterNPC.SetTemporaryAttitudeGroup( 'monsters', AGP_Default );	
		monsterNPC.NoticeActor(thePlayer);
		rabbit.Destroy();
		theSound.SoundEvent("stop_music"); 
		theSound.SoundEvent("play_music_nomansgrad");
		theSound.SoundEvent("mus_griffin_combat");
	}
	
	
	
	
	
	timer function NormalMusic ( optional dt : float, optional id : Int32 )
	{	
		theSound.SoundEvent("stop_music");
		AddTimer('IniNormalMusic',4.0,false);
	}	
	timer function IniNormalMusic ( optional dt : float, optional id : Int32 )
	{	
		theSound.InitializeAreaMusic( theGame.GetCommonMapManager().GetCurrentArea() );
	}	
	
}




statemachine class CRandomEncounterFlyingNPC extends CNewNPC{
	
	import var isVisibileFromFar : bool; 

	private var trophies, canStartBleeding, isBleeding, FlyAwayBool, CombatCanStartBool, resetEndMus, switcharoo, switcharoo2, retryLanding : bool;	
	private var bloodArray	: array<CEntity>;
	private var playerPos : Vector;
	private var l_aiTreeAnim : CAIPlayAnimationSlotAction;
	private var rabbit, rabbit2 : CEntity;
	private var bArray : array<string>;
	private var lastTurn : int;
	private var health : float;
	private var type : EFlyingMonsterType;
	private var pathToFlyingDummy		: string;  default pathToFlyingDummy		= "dlc\modtemplates\randomencounterdlc\data\re_flying.w2ent";
	private var monsterPath : string;
	private var world : CWorld;
	
	event OnSpawned( spawnData : SEntitySpawnData )	{
		
		super.OnSpawned(spawnData);		
		
		isVisibileFromFar = true;
		
		l_aiTreeAnim = new CAIPlayAnimationSlotAction in this;
		l_aiTreeAnim.OnCreated();
		l_aiTreeAnim.animName = 'monster_gryphon_special_attack_tearing_up_loop';
		l_aiTreeAnim.blendInTime = 1.0f;
		l_aiTreeAnim.blendOutTime = 1.0f;	
		l_aiTreeAnim.slotName = 'NPC_ANIM_SLOT';
		

		//bArray.PushBack("quests\part_2\quest_files\q106_tower\entities\q106_blood_clue2.w2ent");							
		bArray.PushBack("quests\prologue\quest_files\living_world\entities\clues\blood\lw_clue_blood_splat_big.w2ent");	
		bArray.PushBack("quests\prologue\quest_files\living_world\entities\clues\blood\lw_clue_blood_splat_medium.w2ent");		
		bArray.PushBack("quests\prologue\quest_files\living_world\entities\clues\blood\lw_clue_blood_splat_medium_2.w2ent");	
		bArray.PushBack("living_world\treasure_hunting\th1003_lynx\entities\generic_clue_blood_splat.w2ent");

		AddTimer('EatAnimation',0.f, false );
		AddTimer('Check', 2, true);
		AddTimer('FixPositions',3,false);
		
		
		this.SetTemporaryAttitudeGroup( 'q104_avallach_friendly_to_all', AGP_Default );		
		//entity.SetBehaviorVariable( 'Editor_MoveSpeed', f );
		// .SignalGameplayEvent( 'Despawn' );
	}
	
	private function SetMonsters(){
		this.SetTemporaryAttitudeGroup( 'monsters', AGP_Default );		
	}
	
	public function SetMonsterAttributes(bloodArr : array<CEntity>, enableTrophies : bool, nr : EFlyingMonsterType, str : string, lvl : int ){
		playerPos = thePlayer.GetWorldPosition();
		world = theGame.GetWorld();

		this.bloodArray = bloodArr;
		this.trophies = enableTrophies;
		this.type = nr;
		this.monsterPath = str;
		this.level = lvl;
	}
	
	timer function FixPositions ( optional dt : float, optional id : Int32 )
	{	
		var horseTemplate : CEntityTemplate;
		var rot : EulerAngles;
		var pos : Vector;
		var z : float;
		var deadHorse : CEntity;	

		pos = this.GetWorldPosition();
		FixZAxis(pos);	
		this.Teleport(pos);
				
		// --- Horse Corpse ---
		horseTemplate = (CEntityTemplate)LoadResource( "items\quest_items\q103\q103_item__horse_corpse_with_head_lying_beside_it_02.w2ent", true);
		rot = this.GetWorldRotation();		
		rot.Yaw += 95;			
		pos = this.GetWorldPosition() + VecFromHeading( this.GetHeading() ) * Vector(1.7, 1.7, 0);
		FixZAxis(pos);				
		deadHorse = theGame.CreateEntity(horseTemplate, pos, rot);
	}


	timer function EatAnimation (optional dt : float, optional id : Int32)
	{		
		var ANIMATION : int;	
		var i : int;	

		if (!this.IsInCombat() && VecDistance(this.GetWorldPosition(), playerPos) > 17 && this.GetDistanceFromGround(1000, /* NOP */) < 3.0 )
		{			
			ANIMATION = this.ForceAIBehavior( l_aiTreeAnim, BTAP_Emergency );				
			AddTimer('EatAnimation',0.01, false );
		}
		else
		{		
			this.ForgetActor(thePlayer);
			this.CancelAIBehavior(ANIMATION);
			
			for(i=0;i<100;i+=1)
			{
				this.CancelAIBehavior(i);
			}

			StartFlying();			
			RemoveTimer('EatAnimation');
		}
	}
	
	private function StartFlying()
	{
		var l_aiTree : CAIFlightIdleFreeRoam;
		var i : int;
		var template : CEntityTemplate;
		var pos : Vector;
		var rot : EulerAngles;		

		this.SetTemporaryAttitudeGroup( 'friendly_to_player', AGP_Default );		
		
		l_aiTree = new CAIFlightIdleFreeRoam in this;		
		i = this.ForceAIBehavior( l_aiTree, BTAP_Emergency );	

		pos = VecConeRand(theCamera.GetCameraHeading(), 10, 55, 56);
		pos = theCamera.GetCameraPosition() + pos;	
		
		template = (CEntityTemplate)LoadResource( "characters\npc_entities\animals\hare.w2ent", true );	
		rabbit = theGame.CreateEntity(template, pos, rot);	
		
		FlyAwayBool = true;
		canStartBleeding = true;
		AddTimer('FlyAway',0.5,false);
		AddTimer('BloodTrail',0.3,true);		
		
		if( VecDistance( this.GetWorldPosition(), playerPos) < 45 )
		{
			theSound.SoundEvent("stop_music");
			theSound.SoundEvent("play_music_nomansgrad");
			theSound.SoundEvent("mus_griffin_chase");
		}
	}
	
	timer function BloodTrail ( optional dt : float, optional id : Int32 )
	{
		var pos : Vector;
		var bloodTrailFlying : CEntity;
		var i : int;
		var bloodTrailTemp : CEntityTemplate;
		var z : float;
		var rot : EulerAngles;
	
		if (isBleeding && canStartBleeding)
		{		
			i = RandRange(0, 6);
			bloodTrailTemp = (CEntityTemplate)LoadResource( bArray[i], true);
			
			pos = this.GetWorldPosition();
			FixZAxis(pos);		
			if (pos.Z >= theGame.GetWorld().GetWaterLevel(pos, true))
            {
                bloodTrailFlying = theGame.CreateEntity(bloodTrailTemp, pos, rot);
                bloodArray.PushBack(bloodTrailFlying);
            }
		}
	}
	
	timer function FlyAway ( optional dt : float, optional id : Int32 )
	{
		if (FlyAwayBool)
		{
			KeepFlying();			
		}
	}
	
	
	timer function FightCheck ( optional dt : float, optional id : Int32 )
	{
		if(VecDistance(this.GetWorldPosition(),playerPos) < 30)
		{
			FlyAwayBool = false;
			AddTimer('ActualFight',0.1,false);
		}
	}
	
	timer function ActualFight ( optional dt : float, optional id : Int32 )
	{
		SetMonsters();		
		this.NoticeActor(thePlayer);
		rabbit.Destroy();
		theSound.SoundEvent("stop_music"); 
		theSound.SoundEvent("play_music_nomansgrad");
		theSound.SoundEvent("mus_griffin_combat");
	}
	
	public function KeepFlying()
	{
		var pos, posx, pos2 : Vector;
		var rot : EulerAngles;
		var z, turn : float;
		var template : CEntityTemplate;				

		AddTimer('FightCheck',5.0,false);
		
		if(!rabbit2)
		{
			template = (CEntityTemplate)LoadResource( "characters\npc_entities\animals\hare.w2ent", true );
			rabbit2 = theGame.CreateEntity(template, rabbit.GetWorldPosition(), rot);	
			((CActor)rabbit2).SetImmortalityMode(AIM_Invulnerable, AIC_Default);		
		}		
		SetMonsters();	
		
		pos2 = rabbit.GetWorldPosition();
		
		FixZAxis(pos2);	
		
		rabbit2.Teleport(pos2);

		// Because TestIsInSettlement() doesnt work in Skellige....
		if(theGame.GetCommonMapManager().GetCurrentArea() == 2)
		{
			if ( pos2.Z+0.4 <= theGame.GetWorld().GetWaterLevel(pos2, true) || ((CNewNPC)rabbit2).IsInInterior())
			{
				pos = this.GetWorldPosition();
				if(lastTurn == 0)
				{				
					if (RandRange(0,2) == 0 )
					{
						turn = RandRange(20,30);
					}
					else
					{
						turn = RandRange(-20,-30);
					}
				}
				else
				{
					turn = RandRange(20,30)*lastTurn;
				}
				pos = pos + VecConeRand(this.GetHeading()+turn, 1, 121, 122);
				
				if( this.GetDistanceFromGround(1000, /* NOP */) < 40.0)
				{
					pos.Z += 20;
				}
				else
				{
					pos.Z -= 10;
				}
				rabbit.Teleport(pos);
			}
			else
			{
				pos = this.GetWorldPosition();
				pos = pos + VecConeRand(this.GetHeading(), 30, 121, 122);
				if( this.GetDistanceFromGround(1000, /* NOP */) < 40.0)
				{
					pos.Z += 20;
				}
				else
				{
					pos.Z -= 10;
				}
				rabbit.Teleport(pos);
			}	
		}
		else
		{
			if (this.TestIsInSettlement() || ((CActor)rabbit2).TestIsInSettlement() || pos2.Z+0.4 <= theGame.GetWorld().GetWaterLevel(pos2, true) || ((CNewNPC)rabbit2).IsInInterior())
			{
				pos = this.GetWorldPosition(); 
				if(lastTurn == 0)
				{				
					if (RandRange(0,2) == 0 )
					{
						turn = RandRange(20,30);
					}
					else
					{
						turn = RandRange(-20,-30);
					}
				}
				else
				{
					turn = RandRange(20,30)*lastTurn;
				}
				pos = pos + VecConeRand(this.GetHeading()+turn, 1, 121, 122);
				if( this.GetDistanceFromGround(1000, /* NOP */) < 40.0)
				{
					pos.Z += 20;
				}
				else
				{
					pos.Z -= 10;
				}
				rabbit.Teleport(pos);
			}
			else
			{
				pos = this.GetWorldPosition();	
				pos = pos + VecConeRand(this.GetHeading(), 30, 121, 122);
				if( this.GetDistanceFromGround(1000, /* NOP */) < 40.0)
				{
					pos.Z += 20;
				}
				else
				{
					pos.Z -= 10;
				}
				rabbit.Teleport(pos);
			}	
		}
		
		// so it would turn in 1 direction, not back and forth constantly....
		if(turn > 0)
		{
			lastTurn = 1;
		}
		if(turn < 0)
		{
			lastTurn = -1;
		}	
		if(turn == 0)
		{
			lastTurn = 0;
		}	
		
		if(VecDistance(this.GetWorldPosition(),playerPos) > 160)
		{
			FlyAwayBool = false;
			FindLandingSpot();			
		}
		
		
		this.ForgetActor(thePlayer);
		this.NoticeActor(((CNewNPC)rabbit));
		
		AddTimer('FlyAway',2.1,false);
		if(FlyAwayBool)
		{
			AddTimer('ForgetNotice',0.1,false);
		}
	}
	
	timer function ForgetNotice ( optional dt : float, optional id : Int32 )
	{
		this.ForgetActor(thePlayer);
		this.NoticeActor(((CNewNPC)rabbit));
		if(FlyAwayBool)
		{
			AddTimer('ForgetNotice',0.1,false);
		}
	}
	
	
	private function FindLandingSpot()
	{
		var position, outSafeSpot : Vector;
		var personalSpace, searchRadius : float;
		var template : CEntityTemplate;
		var rot : EulerAngles;
		var i : int;
		
		AddTimer('ChaseEndMus',0.1,false);

		position = rabbit.GetWorldPosition();
		personalSpace = 2;
		searchRadius = 100;
		for(i=0;i<20;i+=1)
		{
			theGame.GetWorld().NavigationFindSafeSpot( position, personalSpace, searchRadius, outSafeSpot  );	
			
			template = (CEntityTemplate)LoadResource( "characters\npc_entities\animals\hare.w2ent", true );	
			this.rabbit.Destroy();
			this.rabbit = theGame.CreateEntity(template, outSafeSpot, rot);	
			((CNewNPC)this.rabbit).SetGameplayVisibility(false);
			((CNewNPC)this.rabbit).SetVisibility(false);		
			((CActor)this.rabbit).EnableCharacterCollisions(false);
			((CActor)this.rabbit).EnableDynamicCollisions(false);
			((CActor)this.rabbit).EnableStaticCollisions(false);
			((CActor)this.rabbit).SetImmortalityMode(AIM_Invulnerable, AIC_Default);	
			if(theGame.GetCommonMapManager().GetCurrentArea() == 2)
			{
				if(((CNewNPC)this.rabbit).IsInInterior())
				{	
					continue;
				}
				else
				{
					break;
				}
			}
			else
			{
				if(((CActor)this.rabbit).TestIsInSettlement() || ((CNewNPC)this.rabbit).IsInInterior())
				{
					continue;
				}
				else
				{
					break;
				}
			}
		}

		this.rabbit.Teleport(outSafeSpot);	
		this.NoticeActor(((CNewNPC)this.rabbit));
		
		AddTimer('LandingProcedure',0.1,false);
	}
	
	timer function LandingProcedure ( optional dt : float, optional id : Int32 )
	{
		var i : int;		
		var camRotY, camRot, rot : EulerAngles;
		var template : CEntityTemplate;
		var finalPos, pos : Vector;
		var newFlyingEntity, temp : CEntity;
		var z : float;
		
		
		var inRangeEntities  : array<CGameplayEntity>;
		var inv : CInventoryComponent;
		var allItems : array<SItemUniqueId>;

		if( this.GetDistanceFromGround(1000, /* NOP */) < 10.0  )
		{	
			this.ForgetActor(((CNewNPC)rabbit));
			this.rabbit.Destroy();	
			this.rabbit2.Destroy();		
			
			finalPos = this.GetWorldPosition();	
			health = this.GetHealthPercents();				
			
			FixZAxis(finalPos);
				
			camRotY = theCamera.GetCameraRotation();
			camRot.Yaw = AngleNormalize180(camRotY.Yaw)-180;
		
			// Kills other actors in range, since otherwise the flying dude would never ever land and it would just chase them......
			FindGameplayEntitiesInRange(inRangeEntities , this, 20, 50, /*NOP*/, /*NOP*/, /*NOP*/, 'CNewNPC');
			for(i=0;i<inRangeEntities.Size();i+=1)
			{
				if( ( ((CNewNPC)inRangeEntities[i]).HasTag('animal') || ((CActor)inRangeEntities[i]).IsMonster() || ((CActor)inRangeEntities[i]).IsAlive() || ((CActor)inRangeEntities[i]).GetAttitude( thePlayer ) == AIA_Hostile) && ((CActor)inRangeEntities[i]) != this )
				{
					((CActor)inRangeEntities[i]).Kill('RandomEncounters',true);
				}
			}	
			
			
			if(  VecDistance(this.GetWorldPosition(), playerPos) > 30  ){
				template = (CEntityTemplate)LoadResource( monsterPath, true);	
				newFlyingEntity = theGame.CreateEntity(template, finalPos, camRot);
			}
			
			((CNewNPC)newFlyingEntity).SetLevel(this.GetLevel()); 
			if(health != 0)
			{
				((CActor)newFlyingEntity).SetHealthPerc(health);
			}			

			
			template = (CEntityTemplate)LoadResource( pathToFlyingDummy, true);								
			temp = theGame.CreateEntity(template, thePlayer.GetWorldPosition(), thePlayer.GetWorldRotation());	
			((CRandomEncounterFlyingNPCEntity)temp).SetMonsterAttributesAlt(newFlyingEntity, true, trophies, type, bloodArray);
			
			this.Destroy();		
		}
		else
		{
			AddTimer('LandingProcedure',0.01,false);
            if (!retryLanding)
            {
                retryLanding = true;
                AddTimer('OnRetryLanding', 3.0f, false);
            }
		}
	}
	
	timer function OnRetryLanding( optional dt : float, optional id : Int32 )
    {
		if (!this.IsOnGround())
		{
			RemoveTimer('LandingProcedure');
			retryLanding = false;
			FindLandingSpot();  
		}
    }
	
	
	
	
	timer function Check ( optional dt : float, optional id : Int32 )
	{
		playerPos = thePlayer.GetWorldPosition();
	}
	
	
	
	
	
	
	
	
	
	
	timer function ChaseEndMus ( optional dt : float, optional id : Int32 )
	{	
		if(!thePlayer.IsInCombat())
		{
			AddTimer('NormalMusic',1.0,false);
		}
		else
		{
			AddTimer('ChaseEndMus',3.0,false);
		}
		if(!resetEndMus)
		{
			CombatCanStartBool = true;
			canStartBleeding = false;
			resetEndMus = true;
		}
	}
	
	timer function NormalMusic ( optional dt : float, optional id : Int32 )
	{	
		theSound.SoundEvent("stop_music");
		AddTimer('IniNormalMusic',4.0,false);
	}	
	timer function IniNormalMusic ( optional dt : float, optional id : Int32 )
	{	
		theSound.InitializeAreaMusic( theGame.GetCommonMapManager().GetCurrentArea() );
	}	
	
	
	
	
	
	
	
	
	
	
	
	public function ReactToBeingHit(damageAction : W3DamageAction, optional buffNotApplied : bool) : bool
	{	
		OnReactToBeingHit( damageAction );
		
		isBleeding = true;
		if(damageAction.IsActionRanged())
		{
			return false;
		}				
		
		return super.ReactToBeingHit(damageAction, buffNotApplied);
	}
	
	
	
	event OnDestroyed()
	{		
		super.OnDestroyed();
	}

	event OnDeath( damageAction : W3DamageAction )
	{
		super.OnDeath( damageAction );
	}
}






























