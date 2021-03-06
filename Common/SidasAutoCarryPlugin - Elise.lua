--[[

	SAC Elise plugin

	Version 1.2 
	- Converted to iFoundation_v2

	LAST TESTED 8.12 WORKING EXCEPT 789 LINE ERROR; HOWEVER DID NOT STOP PERFORMANCE
--]]

require "iFoundation_v2"

--[[ ELISE HUMAN ]]--
local HumanQ = Caster(_Q, 625, SPELL_TARGETED)
local HumanW = Caster(_W, 950, SPELL_LINEAR_COL, math.huge, 0, 100, true)
local HumanE = Caster(_E, 1075, SPELL_LINEAR_COL, 1450, 0.250, 50, true)

--[[ ELISE SPIDER ]]--
local SpiderQ = Caster(_Q, 475, SPELL_TARGETED)
local SpiderW = Caster(_W, math.huge, SPELL_SELF)
local SpiderE = Caster(_E, 1075, SPELL_TARGETED)

--[[ UNIVERSAL ]]--
local SkillR = Caster(_R, math.huge, SPELL_SELF)

local isSpider = false 

local monitor = nil

function PluginOnLoad()

	AutoCarry.SkillsCrosshair.range = 600

	MainMenu = AutoCarry.MainMenu
	PluginMenu = AutoCarry.PluginMenu
	PluginMenu:addParam("sep1", "-- Spell Cast Options --", SCRIPT_PARAM_INFO, "")
	--PluginMenu:addParam("", "", SCRIPT_PARAM_ONOFF, true)
	PluginMenu:addParam("EJumpOverride", "Jump with E (to Target) with Combo", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("A"))
	PluginMenu:addParam("EJump", "Spider E Distance (Jump)",SCRIPT_PARAM_SLICE, 400, 0, 1075, 0)
	PluginMenu:addParam("rDistance", "R Safty distance",SCRIPT_PARAM_SLICE, 0, 0, 800, 0)
end

function PluginOnTick()
	Target = AutoCarry.GetAttackTarget()
	isSpider = myHero:GetSpellData(_R).name == "EliseRSpider"

	if Target and MainMenu.AutoCarry then

		if not isSpider and Target then
			if HumanE:Ready() then HumanE:Cast(Target) end 
			if HumanW:Ready() then HumanW:Cast(Target) end 
			if HumanQ:Ready() then HumanQ:Cast(Target) end 
			if not isSpider and SkillR:Ready() then SkillR:Cast(Target) end 		
		end 

		if isSpider and Target then 
			if SpiderE:Ready() and ((GetDistance(Target) <= PluginMenu.EJump or DamageCalculation.CalculateRealDamage(Target) > Target.health) or PluginMenu.EJumpOverride) then
				SpiderE:Cast(Target)
			end 
			if SpiderQ:Ready() then SpiderQ:Cast(Target) end 
			if SpiderW:Ready() then	SpiderW:Cast(Target) end

			if GetDistance(Target) >= PluginMenu.rDistance and SkillR:Ready() then
				SkillR:Cast(Target)
			end 

		end 
		
	end

end
