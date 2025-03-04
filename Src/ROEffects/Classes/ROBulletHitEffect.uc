//=============================================================================
// ROBulletHitEffect
//=============================================================================
// Base hit effect class for bullets
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2003-2004 Erik Christensen
// $Id: ROBulletHitEffect.uc,v 1.8 2004/02/24 02:11:11 bwright Exp $:
//=============================================================================

class ROBulletHitEffect extends ROHitEffect;

#exec OBJ LOAD FILE=..\Sounds\ProjectileSounds.uax

//=============================================================================
// defaultproperties
//=============================================================================
defaultproperties
{
	HitEffects(0)=(HitDecal=class'BulletHoleDirt',HitEffect=class'ROBulletHitRockEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Dirt')        // Default (Dirt?)
	HitEffects(1)=(HitDecal=class'BulletHoleConcrete',HitEffect=class'ROBulletHitRockEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Asphalt')     // Rock
	HitEffects(2)=(HitDecal=class'BulletHoleDirt',HitEffect=class'ROBulletHitDirtEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Dirt')        // Dirt
	HitEffects(3)=(HitDecal=class'BulletHoleMetal',HitEffect=class'ROBulletHitMetalEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Metal')      // Metal
	HitEffects(4)=(HitDecal=class'BulletHoleWood',HitEffect=class'ROBulletHitWoodEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Wood')        // Wood
	HitEffects(5)=(HitDecal=class'BulletHoleDirt',HitEffect=class'ROBulletHitGrassEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Grass')      // Plant
	HitEffects(6)=(HitDecal=class'BulletHoleFlesh',HitEffect=class'ROBulletHitFleshEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Mud')        // Flesh (dead animals)
	HitEffects(7)=(HitDecal=class'BulletHoleIce',HitEffect=class'ROBulletHitIceEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Glass')        // Ice
	HitEffects(8)=(HitDecal=class'BulletHoleSnow',HitEffect=class'ROBulletHitSnowEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Snow')        // Snow
	HitEffects(9)=(HitEffect=class'ROBulletHitWaterEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Snow')                                    // Water
	HitEffects(10)=(HitDecal=class'BulletHoleIce',HitEffect=class'ROBreakingGlass',HitSound=sound'ProjectileSounds.Bullets.Impact_Glass')            // Glass
	HitEffects(11)=(HitDecal=class'BulletHoleConcrete',HitEffect=class'ROBulletHitGravelEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Gravel')     // Gravel
	HitEffects(12)=(HitDecal=class'BulletHoleConcrete',HitEffect=class'ROBulletHitConcreteEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Asphalt')    // Concrete
	HitEffects(13)=(HitDecal=class'BulletHoleWood',HitEffect=class'ROBulletHitWoodEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Wood')       // HollowWood
	HitEffects(14)=(HitDecal=class'BulletHoleSnow',HitEffect=class'ROBulletHitMudEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Mud')        // Mud
	HitEffects(15)=(HitDecal=class'BulletHoleMetalArmor',HitEffect=class'ROBulletHitMetalArmorEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Metal')     // MetalArmor
	HitEffects(16)=(HitDecal=class'BulletHoleConcrete',HitEffect=class'ROBulletHitPaperEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Wood')       // Paper
	HitEffects(17)=(HitDecal=class'BulletHoleCloth',HitEffect=class'ROBulletHitClothEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Dirt')       // Cloth
	HitEffects(18)=(HitDecal=class'BulletHoleMetal',HitEffect=class'ROBulletHitRubberEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Dirt')       // Rubber
	HitEffects(19)=(HitDecal=class'BulletHoleDirt',HitEffect=class'ROBulletHitMudEffect',HitSound=sound'ProjectileSounds.Bullets.Impact_Mud')        // Poop
}
