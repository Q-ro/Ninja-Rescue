--	#####################################
--	# Title:		Ninja rescue squad	#
--	# Author:		Andres Mrad (Q-ro)	#
--	# Date:			Jan 29 2015			#
--	# Description:	Ninjas rescue squad	#
--	#####################################

--- "Imports"

--Game Resources
require("resources")

--Classes
require("Map")

--Game States
require("splash")
require("mainMenu")
require("stageSelect")
require("inGame")
require("exitGame")

--Libs
require("util")

--- Variable declaration
-- Game states array
local gamestates = 
{
	["SPLASH"]=splash,
	["INGAME"]=inGame,
	["MAINMENU"]=mainMenu,
	["STAGESELECTION"]=stageSelection,
	["OPTIONS"]=options,
	["KEYBOARD"]=keyboard,
	["JOYSTICK"]=joystick,
	["HOWTO"]=howto,
	["HIGSCORELIST"]=highscoreList,
	["HIGHSCOREENTRY"]=highscoreEntry,
	["INGAMEMENU"]=ingameMenu,
	["HISTORY"]=history,
	["SUMMARY"]=summary,
	["EXITGAME"]=exitGame
}



local lg = love.graphics

--- Main load function
function love.load()

	-- Sets background color to black
	lg.setBackgroundColor(0,0,0)
	lg.setDefaultFilter("nearest","nearest")

	loadResources()

	--setMode()

	--Starts the splash screen
	--gamestates["SPLASH"].enter()
	setGameState("SPLASH")
end

--- Main update function
function love.update(dt)
	---Run update function of the current game state
	gamestates[state].update(dt)
end

--- Main draw function
function love.draw()
	lg.push()
	gamestates[state].draw()
	lg.pop()
	
end

--- Change the current game state
-- @newState: The game state to transition to
-- @value: Data to pass to the game state
function setGameState(newState,value)
	-- set the current game state
	state = newState
	gamestates[newState].enter(value)
end

--- Main keyboard handdler
function love.keypressed(k, uni)
	--let the current game state handdle the keyboard
	gamestates[state].keypressed(k, uni)
end

--- Main text input handdler
function love.textinput(text)
	if gamestates[state].textinput then
		--let the current game state handdle the input
		gamestates[state].textinput(text)
	end
end


--- Main controller handdler
-- @joy: the joystick ussuing the input
-- @k: the value of the button being pressed
function love.joystickpressed(joy, k)
	
	--let the current game state handdle the joystick
	if gamestates[state].joystickpressed then
		gamestates[state].joystickpressed(joy, k)
	else
		for a, key in pairs(config.joykeys) do
			if k == key then
				gamestates[state].action(a)
			end
		end
	end
end

