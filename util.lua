--	#####################################
--	# Title:		util.lua			#
--	# Author:		Andres Mrad (Q-ro)	#
--	# Date:			Jan 29 2015			#
--	# Description:	Useful functions	#
--	#####################################

local lg = love.graphics

--- Collides two rectangles
-- @param boundaryBox_1 : First bounding box
-- @param boundaryBox_2 : Second bounding box
-- @return True if they overlap
function collideBoxes(boundaryBox_1,boundaryBox_2)
	if boundaryBox_1.x > boundaryBox_2.x+boundaryBox_2.w or boundaryBox_1.x+boundaryBox_1.w < boundaryBox_2.x
	or boundaryBox_1.y > boundaryBox_2.y+boundaryBox_2.h or boundaryBox_1.y+boundaryBox_1.h < boundaryBox_2.y then
		return false
	else
		return true
	end
end

--- Returns a random entry in a table
-- @param table : Table with elements
-- @returns a random entry
function table.random(table)
	return table[math.random(#t)]
end


--- Determines the sign of a number (negative, positive or zero)
-- @param number : Number
-- @returns an int representation of the sign (1, -1, or 0)
function math.sign(number)
	if number < 0 then
		return -1
	elseif number > 0 then
		return 1
	else
		return 0
	end
end

--- Rounds down a number
-- @param number : Number
-- @returns the rounded down value
function math.round(number)
	return math.floor(number+0.5)
end


function collideX(self)
	if self.xspeed == 0 then return end

	local collision = false
	
	local last -- Last object collision detected

	for _, yoff in ipairs({self.corners[3], (self.corners[3]+self.corners[4])/2, self.corners[4]}) do
		for _, xoff in ipairs({self.corners[1], self.corners[2]}) do
			-- Collide with solid tiles
			if map:collidePoint(self.x+xoff, self.y+yoff) then
				collision = true
				local cx = math.floor((self.x+xoff)/16)*16
				if self.xspeed > 0 then
					self.x = cx-self.corners[2]-0.0001
				else
					self.x = cx+16-self.corners[1]
				end
			end
			-- Collide with objects
			for i,v in ipairs(map.objects) do
				if v.solid == true and self:collideBox(v:getBBox()) then
					collision = true
					last = v
					local bbox = v:getBBox()
					if self.xspeed > 0 then
						self.x = bbox.x-self.corners[2]-0.0001
					else
						self.x = bbox.x+bbox.w-self.corners[1]+0.0001
					end
				end
			end
		end
	end
	
	return collision, last
end

function collideY(self)
	if self.yspeed == 0 then return end
	self.onGround = false

	local collision = false

	for _, yoff in ipairs({self.corners[3], self.corners[4]}) do
		for _, xoff in ipairs({self.corners[1], self.corners[2]}) do
			-- Collide with solid tiles
			if map:collidePoint(self.x+xoff, self.y+yoff) then
				collision = true
				local cy = math.floor((self.y+yoff)/16)*16
				if self.yspeed > 0 then
					self.y = cy-self.corners[4]-0.0001
					self.onGround = true
				else
					self.y = cy+16-self.corners[3]
				end
			end
		end
	end

	return collision
end


--- Restrains a value to a given interval
-- @param val: current value
-- @param min: minimum value of the interval
-- @param max: maximum value of the interval
-- @returns the capped value
function cap(val, min, max)
	return math.max(math.min(val, max), min)
end


--- Warp around an interval of values
-- @param val: current value
-- @param min: minimum value of the interval
-- @param max: maximum value of the interval
-- @returns the warpped value
function wrap(val, min, max)
	if val < min then val = max end
	if val > max then val = min end
	return val
end


function drawBox(x,y,w,h)
	lg.setColor(30,23,18)
	lg.rectangle("fill",x+1,y+1,w-2,h-2)
	lg.setColor(255,255,255)
	-- Draw sides
	lg.draw(img.menu_box, quad.box_left, x, y+1, 0, 1, (h-2))
	lg.draw(img.menu_box, quad.box_left, x+w, y+1, 0, -1, (h-2))
	lg.draw(img.menu_box, quad.box_top,  x+1, y, 0, (w-2), 1)
	lg.draw(img.menu_box, quad.box_top,  x+1, y+h, 0, (w-2), -1)
	-- Draw corners
	lg.draw(img.menu_box, quad.box_corner, x,y)
	lg.draw(img.menu_box, quad.box_corner, x+w,y, 0, -1, 1)
	lg.draw(img.menu_box, quad.box_corner, x,y+h, 0, 1, -1)
	lg.draw(img.menu_box, quad.box_corner, x+w,y+h, 0, -1, -1)
end

--- Transform time in millisecons to time as HH:MM:SS
-- @param time: time in milliseconds
-- @returns a string in the format "HH:MM:SS"
function secondsToString(time)
	local hours =   string.format("%02d", math.floor(time / 60^2))
	local minutes = string.format("%02d", math.floor((time % 60^2) / 60))
	local seconds = string.format("%02d", math.floor(time % 60))

	return hours .. ":" .. minutes .. ":" .. seconds
end

--- Exits the game
function gameExit()
	love.event.quit()
end
