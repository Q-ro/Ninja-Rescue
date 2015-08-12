--	#################################################
--	# Title:		exitGame.lua					#
--	# Author:		Andres Mrad (Q-ro)				#
--	# Date:			Jan 29 2015						#
--	# Description:	Exit game confirmation menu		#
--	#################################################


local lg = love.graphics

exitGame={}

function exitGame.enter()
	-- set the current game state
	state = "EXITGAME"
	gameExit()
	
end

function exitGame.update(dt)
	--love.event.quit()
	--exitGame()
	--updateKeys()
end

function exitGame.draw()

end