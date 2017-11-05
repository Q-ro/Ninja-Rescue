--	#############################################
--	# Title:		mainMenu.lua				#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Jan 29 2015					#
--	# Description:	Main menu of the game		#
--	#############################################

local lg = love.graphics

-- Main menu stings and the game states they represent
local MAIN_MENU = {
	{"START GAME", "STAGESELECTION"}, 
	{"GAME MANUAL", "HOWTO"}, 
	{"OPTIONS", "OPTIONS"}, 
	{"CREDITS", "HISTORY"}, 
	{"EXIT GAME", "EXITGAME"}
}

mainMenu = {}

--- Set the initial values for the menu screen
function mainMenu.enter()

	menuSelection = 1
end

function mainMenu.update(dt)
	--updateKeys()
end

function mainMenu.draw()
	lg.push()

	lg.setFont(font.bold)

	--lg.scale(config.scale)

	-- Draw menu Background
	--lg.draw(img.splash, quad.screen, 0,0)
	
	lg.setFont(font.bold)
	for i=1,table.getn(MAIN_MENU) do
		if i == menuSelection then
			lg.print(">", 144, 86+i*13)
		end
		lg.print(MAIN_MENU[i][1], 152, 86+i*13)
	end

	lg.pop()
end

function mainMenu.keypressed(k, uni)
	if k == "down" then
		menuSelection = wrap(menuSelection + 1, 1,table.getn(MAIN_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "up" then
		menuSelection = wrap(menuSelection - 1, 1,table.getn(MAIN_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "return" or k == " " then

		setGameState(MAIN_MENU[menuSelection][2])
		
		---TODO: Add the sound effect
		--Play a sound effect
		playSound("confirm")

	-- on scape close the game
	elseif k == "escape" then
		love.event.quit()
	end
end

function mainMenu.action(k)
	if k == "down" then
		menuSelection = wrap(menuSelection + 1, 1,table.getn(MAIN_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "up" then
		menuSelection = wrap(menuSelection - 1, 1,table.getn(MAIN_MENU))
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")
	elseif k == "jump" or k == "pause" then

		setGameState(MAIN_MENU[menuSelection][2])
		
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("confirm")

	-- on scape close the game
	elseif k == "action" then
		love.event.quit()
	end
end