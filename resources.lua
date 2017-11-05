--	#####################################################
--	# Title:		splash.lua							#
--	# Author:		Andres Mrad (Q-ro)					#
--	# Date:			Jan 29 2015							#
--	# Description:	Load and configure game resources	#
--	#####################################################

local lg = love.graphics

-- Global fonts
font={}
sfx={
	["confirm"] = love.audio.newSource("Assets/SFX/Confirm_coolsound.ogg"),
}

--- Load all resources including images, quads sound effects etc.
function loadResources()

	-- Load the pixel font from image
	font.bold = loadFont("boldfont", " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!'-:*@<>+/_$&?")
	lg.setFont(font.bold)

end


--- Loads sprite a font file
-- @name: name of the file
-- @chars: the chars on the font file
function loadFont( name, chars )
	return lg.newImageFont(lg.newImage("Assets/Fonts/".. name ..".png"), chars)
end

--- Plays a SFX
-- @name: name of the file
function playSound(name)
	love.audio.play(sfx[name])
end

--- Plays a song
-- @name: name of the file
-- @loop: difines if the song must be looped
function playMusic(name, loop)
	-- Stop previously playing music if any
	if music then
		music:stop()
	end
	-- Play new file
	music_name = name
	music = love.audio.newSource("data/sfx/"..name..".ogg", "stream")
	music:addTags("music")
	if loop ~= nil then
		music:setLooping(loop)
	else
		music:setLooping(true)
	end
	love.audio.tags.music.setVolume(config.music_volume)
	love.audio.play(music)
end


--- Stops the current song playing (if any)
function stopMusic()
	if music then
		music:stop()
	end
end