--
--	STANDARD UTILITY SCRIPTS
--		
--		This file contains all the global scripts that the
--		  standard release of champions will need
--		The real purpose here is to stop us duplicating script calls all over the place	
--

--
-- We must have this function: the game calls it directly
--
function Std_UnloadObject(idstr)
	_G[idstr] = nil;
end

--
-- Get the difficulty based on levels (0-4)
--
function Std_GetDifficulty(heroLevel,taskLevel)
	if (taskLevel < heroLevel-6) then
		return 0;
	elseif (taskLevel < heroLevel-1) then
		return 1;
	elseif (taskLevel < heroLevel+3) then
		return 2;
	elseif (taskLevel < heroLevel+8) then
		return 3;
	end
	return 4;
end

--
-- Damage plus associated effects
--
function Std_InflictDamage(amt,src)

	local idxEnemy = GET_ENEMY(src,0);
	SUBTRACT_LIFE(idxEnemy,amt,src);
	
	-- Special FX on enemy
	local msg_damage;
	if (amt < 2) then
		msg_damage = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE1]",amt);
	else
		msg_damage = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE2]",amt);
	end
	PLAY_SOUND("snd_redskull");
	ADD_EFFECT_TO_CHARACTER(idxEnemy,"RedSkull");
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg_damage,2,6);
	
end

--
-- Damage plus associated effects
--
function Std_InflictDamageWithAnimEffect(amt,src,effname)

	local idxEnemy = GET_ENEMY(src,0);
	SUBTRACT_LIFE(idxEnemy,amt,src);
	
	-- Special FX on enemy
	local msg_damage;
	if (amt < 2) then
		msg_damage = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE1]",amt);
	else
		msg_damage = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_DAMAGE2]",amt);
	end
	PLAY_SOUND("snd_redskull");
	if (effname ~= "") then
		ADD_ANIMEFFECT_TO_CHARACTER(idxEnemy,effname);
	end
	ADD_TEXT_MESSAGE_TO_CHARACTER(idxEnemy,msg_damage,2,6);
	
end

--
-- Healing plus associated effects
--
function Std_Healing(amt,src)

	-- Heal
	ADD_LIFE(src,amt);

	-- Special FX on recipient
	local msg;
	if (amt == 1) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING1]",amt);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING2]",amt);
	end
	ADD_TEXT_MESSAGE_TO_CHARACTER(src, msg,2,6);
	
end

function Std_Healing2(amt,src)

	-- Heal
	ADD_LIFE(src,amt);

	-- Special FX on recipient
	local msg;
	if (amt == 1) then
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING1]",amt);
	else
	   msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_HEALING2]",amt);
	end
	ADD_TEXT_MESSAGE_TO_CHARACTER2(src, msg,2,6);
	
end

--
-- Inflict/receive a status effect
--
function Std_InflictStatusEffect(id,dur,src)

	local idxEnemy = GET_ENEMY(src,0);
	ADD_STATUS_EFFECT_AND_DURATION(idxEnemy,id,dur); 
	
	-- Special FX on enemy
	ADD_EFFECT_TO_CHARACTER(idxEnemy,"RedSparkle");
	
end
function Std_ReceiveStatusEffect(id,dur,src)

	ADD_STATUS_EFFECT_AND_DURATION(src,id,dur); 
	
	-- Special FX on enemy
	ADD_EFFECT_TO_CHARACTER(src,"RedSparkle");
	
end

--
-- Effects that we show from every spell
--

function Std_GetSpellFXAsset(typ)

	local spellfx="";

	if (typ == SPELLFX_HEALING) then
		spellfx = "SpellHealing";
	elseif (typ == SPELLFX_NECRO) then
		spellfx = "SpellNecro";
	elseif (typ == SPELLFX_WATER) then
		spellfx = "SpellWater";
	elseif (typ == SPELLFX_AIR) then
		spellfx = "SpellAir";
	elseif (typ == SPELLFX_FROST) then
		spellfx = "SpellFrost";
	elseif (typ == SPELLFX_SYMBOL) then
		spellfx = "SpellSymbol";
	elseif (typ == SPELLFX_CHAOS) then
		spellfx = "SpellChaos";
	elseif (typ == SPELLFX_GOOD) then
		spellfx = "SpellGood";
	elseif (typ == SPELLFX_STONE) then
		spellfx = "SpellStone";
	elseif (typ == SPELLFX_HIDE) then
		spellfx = "SpellHide";
	elseif (typ == SPELLFX_WAR) then
		spellfx = "SpellWar";
	elseif (typ == SPELLFX_NATURE) then
		spellfx = "SpellNature";
	elseif (typ == SPELLFX_STUN) then
		spellfx = "SpellStun";
	elseif (typ == SPELLFX_FIREBALL) then
		spellfx = "SpellFireball";
	elseif (typ == SPELLFX_HURLGOBLIN) then
		spellfx = "SpellFireball";
	elseif (typ == SPELLFX_POISON) then
		spellfx = "SpellPoison";
	elseif (typ == SPELLFX_DISEASE) then
		spellfx = "SpellDisease";
	elseif (typ == SPELLFX_WEB) then
		spellfx = "SpellWeb";
	elseif (typ == SPELLFX_FEAR) then
		spellfx = "SpellFear";
	elseif (typ == SPELLFX_SPIN) then
		spellfx = "SpellSpin";
	elseif (typ == SPELLFX_SPARKLE) then
		spellfx = "SpellSparkle";
	end
	
	return spellfx;
end

function Std_GetSpellSoundAsset(typ)

	local spellfx="";

	if (typ == SPELLFX_DEFAULTSOUNDONLY) then
		spellfx = "snd_spellnature";
	elseif (typ == SPELLFX_HEALING) then
		spellfx = "snd_spellheal";
	elseif (typ == SPELLFX_NECRO) then
		spellfx = "snd_spellalter";
	elseif (typ == SPELLFX_WATER) then
		spellfx = "snd_spellalter";
	elseif (typ == SPELLFX_AIR) then
		spellfx = "snd_spellbuff";
	elseif (typ == SPELLFX_FROST) then
		spellfx = "snd_spellalter";
	elseif (typ == SPELLFX_SYMBOL) then
		spellfx = "snd_spellalter";
	elseif (typ == SPELLFX_CHAOS) then
		spellfx = "snd_spellfire";
	elseif (typ == SPELLFX_GOOD) then
		spellfx = "snd_spellbuff";
	elseif (typ == SPELLFX_STONE) then
		spellfx = "snd_spellnature";
	elseif (typ == SPELLFX_HIDE) then
		spellfx = "snd_spellbuff";
	elseif (typ == SPELLFX_WAR) then
		spellfx = "snd_spellfire";
	elseif (typ == SPELLFX_NATURE) then
		spellfx = "snd_spellnature";
	elseif (typ == SPELLFX_STUN) then
		spellfx = "snd_spelldebuff";
	elseif (typ == SPELLFX_FIREBALL) then
		spellfx = "snd_spellfire";
	elseif (typ == SPELLFX_HURLGOBLIN) then
		spellfx = "snd_spellfire";
	elseif (typ == SPELLFX_POISON) then
		spellfx = "snd_spelldebuff";
	elseif (typ == SPELLFX_DISEASE) then
		spellfx = "snd_spelldebuff";
	elseif (typ == SPELLFX_WEB) then
		spellfx = "snd_spelldebuff";
	elseif (typ == SPELLFX_FEAR) then
		spellfx = "snd_spelldebuff";
	elseif (typ == SPELLFX_SPIN) then
		spellfx = "snd_spellalter";
	elseif (typ == SPELLFX_SPARKLE) then
		spellfx = "snd_spellbuff";
	end
	
	return spellfx;
end

function Std_CastSpellEffect(src,typ,spell_name)

	-- Special FX on caster
	if (typ == SPELLFX_DEFAULT) then
		PLAY_SOUND("snd_spellnature");
		ADD_EFFECT_TO_CHARACTER(src,"Spell0");
		ADD_EFFECT_TO_CHARACTER(src,"Spell1");
		
	elseif (typ == SPELLFX_DEFAULTGFXONLY) then
		ADD_EFFECT_TO_CHARACTER(src,"Spell0");
		ADD_EFFECT_TO_CHARACTER(src,"Spell1");
		
	else
		local spellfx = Std_GetSpellFXAsset(typ);
		local soundfx = Std_GetSpellSoundAsset(typ);
		if (spellfx ~= "") then
			ADD_ANIMEFFECT_TO_CHARACTER(src,spellfx);
		end
		if (soundfx ~= "") then
			PLAY_SOUND(soundfx);
		end
		
	end	
		
	-- Spell Name
	if (spell_name ~= "") then
		ADD_TEXT_MESSAGE(spell_name,2,6);
	end
	
end

function Std_CasterSpellEffect(src,typ,useSound)

	local spellfx = Std_GetSpellFXAsset(typ);
	local soundfx = Std_GetSpellSoundAsset(typ);
	if (spellfx ~= "") then
		ADD_ANIMEFFECT_TO_CHARACTER(src,spellfx);
	end
	if (soundfx ~= "" and useSound==1) then
		PLAY_SOUND(soundfx);
	end
		
end

function Std_EnemySpellEffect(src,typ,useSound)

	local idxEnemy = GET_ENEMY(src,0);	
	local spellfx = Std_GetSpellFXAsset(typ);
	local soundfx = Std_GetSpellSoundAsset(typ);
	if (spellfx ~= "") then
		ADD_ANIMEFFECT_TO_CHARACTER(idxEnemy,spellfx);
	end
	if (soundfx ~= "" and useSound==1) then
		PLAY_SOUND(soundfx);
	end
		
end

function Std_GridSpellEffect(x,y,typ,useSound)

	local spellfx = Std_GetSpellFXAsset(typ);
	local soundfx = Std_GetSpellSoundAsset(typ);
	if (spellfx ~= "") then
		ADD_ANIMEFFECT_TO_GRID(x,y,spellfx);
	end
	if (soundfx ~= "" and useSound==1) then
		PLAY_SOUND(soundfx);
	end
		
end

--
-- Basic chance of an AI casting a spell
--

function Std_AISpellcastingChance(modifier)

	local evaluation = EVALUATE_BOARD();
	local chance = PERCENTILE_CHANCE_SYNC();
	
	-- Standard chances
	if (chance > 50 + modifier) then
		return 0;
	end
	if (evaluation > 30) then
		return 0;
	end
	
	return 1;
	
end


--
-- Lost some gold
--
function Std_LoseGold(amt,idx)

	-- Heal
	SUBTRACT_GOLD(idx,amt);

	-- Special FX on recipient
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_GOLDLOSS]",amt);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idx, msg,2,MESSAGE_ORANGE);
	
end

--
-- Gained some gold
--
function Std_GainGold(amt,idx)

	-- Heal
	ADD_GOLD(idx,amt);

	-- Special FX on recipient
	local msg = GET_TEXT_FORMAT_INT("[SPELL_EFFECT_GOLD]",amt);
	ADD_TEXT_MESSAGE_TO_CHARACTER(idx, msg,2,MESSAGE_ORANGE);
	
end

--
-- Gained some gold
--
function Std_AddEncounter(pos1,pos2,enc)

	local encounterId = QUEST_ENCOUNTER_GET_AT(pos1,pos2);
	if (encounterId ~= enc) then
		if (encounterId ~= "") then
			QUEST_ENCOUNTER_REMOVE_AT(pos1,pos2);
		end
		QUEST_ENCOUNTER_ADD(enc);
	end
	
end

function testfx(idstr)
	local i;
	for i=1,22 do
		if (Std_GetSpellFXAsset(i)==idstr) then
			ADD_ANIMEFFECT_TO_GRID(4,4,idstr);
			return;
		end
	end
	ADD_EFFECT_TO_GRID(4,4,idstr);
end

