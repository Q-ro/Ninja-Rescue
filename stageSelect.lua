--	#############################################
--	# Title:		stageSelect.lua				#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Jan 29 2015					#
--	# Description:	Stage selection screen		#
--	#############################################

local lg = love.graphics

local STAGE_MENU ={
	{"NINJA ISLAND",		1},
	{"MINI SUPER HEIST",	2},
	{"HOME INVASION",		3},
	{"PARTY CRASHERS",		4},
	{"PIER PERRIL",			5},
	{"SHOPPING SPREE",		6}
}

stageSelection ={}


function stageSelection.enter()

	levelSelection = 1
	
	-- TODO:
	-- Play level select music
	--playMusic("stageselect")
end

function stageSelection.update(dt)
	
end

function stageSelection.draw()
	lg.push()

	--Temporal development menu screen
	lg.setFont(font.bold)
	for i=1,table.getn(STAGE_MENU) do
		if i == levelSelection then
			lg.print(">", 144, 86+i*13)
		end
		lg.print(STAGE_MENU[i][1], 152, 86+i*13)
	end

	lg.pop()
end

function stageSelection.keypressed(k, uni)
	if k == "down" then
		levelSelection = wrap(levelSelection + 1, 1,table.getn(STAGE_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "up" then
		levelSelection = wrap(levelSelection - 1, 1,table.getn(STAGE_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "return" or k == " " then
		--inGame.enter(levelSelection)
		setGameState("INGAME",levelSelection)
		
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("confirm")

	-- on scape go back to te main menu
	elseif k == "escape" then
		-- playSound("confirm")
		-- playMusic("opening")
		setGameState("MAINMENU")
	end
end

function stageSelection.action( k )
	if k == "down" then
		level = wrap(level + 1, 1,table.getn(STAGE_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "up" then
		level = wrap(level - 1, 1,table.getn(STAGE_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "jump" or k == "pause" then
		inGame.enter(levelSelection)
		
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("confirm")

	-- on scape go back to te main menu
	elseif k == "action" then
		---TODO: Add the sound effect
		--Play a sound effect
		-- playSound("confirm")
		-- playMusic("opening")
		setGameState("MAINMENU")
		
	end
end