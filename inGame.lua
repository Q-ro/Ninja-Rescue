--	#####################################################################################
--	# Title:		inGame.lua															#
--	# Author:		Andres Mrad (Q-ro)													#
--	# Date:			Jan 29 2015															#
--	# Description:	bridges game evens such as loading game map, game actors and so on	#
--	#####################################################################################

local INGAME_STATES =
{
	["INTRO"] = 0,
	["COUNTDOWN"] = 1,
	["PAUSE"]=2
}

local lg = love.graphics

inGame={}

function inGame.enter(level)

	--Set the x and Y coodinates to zero
	translate_x, translate_y = 0,0
			
	-- Stops whatever music was previously playing
	--stopMusic()
	--Starts new game
	inGame.newGame(level)
end

function inGame.newGame(level)
	ingame_state = INGAME_STATES["COUNTDOWN"]

	casualities = 0
	saved = 0
	section = 1

	map = Map.create(level, section)
end

function inGame.nextSection(level, currentSection)
	
end

function inGame.draw()
	lg.push()
		
    --lg.print("LEVEL:"..map.level.." SECTION:"..section, 400, 300) --debugging
    
    --Draws the current loaded map
		map:draw()
	lg.pop()
end

function inGame.update(dt)
	-- body
end