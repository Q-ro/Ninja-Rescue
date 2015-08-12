--	#####################################
--	# Title:		splash.lua			#
--	# Author:		Andres Mrad (Q-ro)	#
--	# Date:			Jan 29 2015			#
--	# Description:	Splash screen		#
--	#####################################

local lg = love.graphics

splash = {}

--- Splash enter function
function splash.enter()

	transition_time = 0

	-- TODO: Add the splash song
	-- play the intro song
	--playMusic("opening")

end

--- Splash update function
function splash.update(dt)
	transition_time = transition_time + dt
end

function splash.draw()
	lg.push()
	
	if transition_time < 4 then

		if transition_time < 1 then
			-- Fade in the a the logo image
			local alpha = cap(255*transition_time, 0,255)
			lg.setColor(255,255,255,alpha)
			lg.print('BRAIN FREEZE STUDIOS',300,300)
			lg.setColor(255,255,255,255)
		elseif transition_time > 3 then
			-- Fade out the logo image
			local alpha = cap(255*(1-(transition_time-3)), 0,255)
			lg.setColor(255,255,255,alpha)
			lg.print('BRAIN FREEZE STUDIOS',300,300)
			lg.setColor(255,255,255,255)
		else
			-- Keep it on screen till fade out time
			lg.print('BRAIN FREEZE STUDIOS',300,300)
		end
		
	elseif transition_time < 8 then
		if transition_time < 5 then
			-- Fade in the second splash image
			local alpha = cap(255*(transition_time-4), 0,255)
			lg.setColor(255,255,255,alpha)
			lg.print('ONE MAN ARMY PROJECT',300,300)	
			lg.setColor(255,255,255,255)

		elseif transition_time > 7 then
			-- Fade out the second splash image
			local alpha = cap(255*(1-(transition_time-7)), 0,255)
			lg.setColor(255,255,255,alpha)
			lg.print('ONE MAN ARMY PROJECT',300,300)	
			lg.setColor(255,255,255,255)		
		else		
			-- Keep it on screen till fade out time
			lg.print('ONE MAN ARMY PROJECT',300,300)
		end		
	elseif transition_time < 9 then
			-- Fade in Title screen logo
			local alpha = cap(255*(transition_time-8), 0, 255)
			lg.setColor(255,255,255,alpha)
			lg.print('TITLE SCREEN LOGO',300,300)	
			lg.setColor(255,255,255,255)
	else		
		-- Keep title creen logo on the screen
		lg.print('TITLE SCREEN LOGO',300,300)
		--Set the "old nes" font
		--lg.setFont(font.bold)
		if transition_time % 1.6 < 0.8 then
			-- Flashing press start "sign"
			lg.print("PRESS START", 150, 140)
		end
		
	end
		
	lg.pop()
end

-- Check for pressed keys
function splash.keypressed(k,uni)
	if k == "return" or k == " " or k == "escape" then
		
		---TODO: Add the sound effect
		--Play a sound effect
		--playSound("blip")

		--Go to the main screen
		setGameState("MAINMENU")
	end
end

function splash.action(k)
	
	---TODO: Add the sound effect
	--Play a sound effect
	--playSound("blip")

	--Go to the main screen
	mainMenu.enter()
end
