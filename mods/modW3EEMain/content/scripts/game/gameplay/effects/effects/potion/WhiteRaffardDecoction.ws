/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/




class W3Potion_WhiteRaffardDecoction extends CBaseGameplayEffect
{
	default effectType = EET_WhiteRaffardDecoction;
	
	event OnEffectAddedPost()
	{
		super.OnEffectAddedPost();
		
		((W3Effect_Bleeding)target.GetBuff(EET_Bleeding)).ResetStackTimer();
	}
}