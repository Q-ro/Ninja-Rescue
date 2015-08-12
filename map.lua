--	#############################################
--	# Title:		map.lua						#
--	# Author:		Andres Mrad (Q-ro)			#
--	# Date:			Jan 29 2015					#
--	# Description:	Loads and sets up map tiles	#
--	#############################################

Map = {}
Map.__index = Map

local lg = love.graphics

--- Constructor for the map object
-- @level: the level to be loaded
-- @section: the section of the level
function Map.create( level, section )
	local self = setmetatable({}, Map)

	self.level = level
	self.section = section

	local quadInfo = {
		{ ' ', 0,  0  }, -- grass 
		{ '#', 32, 0  }, -- box
		{ '*', 0, 32  }, -- flowers
		{ '^', 32, 32 }  -- boxTop
	}

	  local mapString = [[
^########################^
^                    *   ^
^  *                     ^
^              *         ^
^                        ^
^    ##  ^##  ^## ^ ^    ^
^   ^  ^ ^  ^ ^   ^ ^    ^
^   ^  ^ ^ *# ^   ^ ^    ^
^   ^  ^ ^##  ^## # #    ^
^   ^  ^ ^  ^ ^    ^  *  ^
^ * ^  ^ ^  ^ ^    ^     ^
^   #  # ^* # ^  * ^     ^
^    ##  ###  ###  #     ^
^                        ^
^   *****************    ^
^                        ^
^  *                  *  ^
##########################
]]

	--temporary check
	self:loadMap(32,32,'Assets/IMG/Tilesets/countryside.png',quadInfo,mapString)

	return self
end

--- Loads a given map in a string format
function Map:getMapstring( level, section )
	-- body
end

--- Loads a game map using a tileset and a map string
-- @tileWidth: The width of each tile
-- @tileHeight: Height of each tile
-- @tilePath: Location of the tileset file
-- @quadInfo: The table used to parse each string from the mapString into a Quad
-- @mapString: The string representation of the map to be loaded
function Map:loadMap ( tileWidth, tileHeight, tilePath, quadInfo, mapString )
	
	
	self.TileWidth = tileWidth
	self.TileHeight = tileHeight
	
	self.TileSet = lg.newImage(tilePath)

	local tilesetW, tilesetH = self.TileSet:getWidth(), self.TileSet:getHeight()

	self.Quads = {}


	-- populate the Quad table using the quad info table
	--for _,info in ipairs(quadInfo) do
	for i=1, #quadInfo do
		
		-- store the sub set on a local variable
  		local info = quadInfo[i]

	    -- info[1] = character, info[2] = x, info[3] = y
		self.Quads[info[1]] = lg.newQuad(info[2], info[3], self.TileWidth , self.TileHeight, tilesetW, tilesetH)
  	end

  	self.TileTable = {}

  	-- Calculates the width of our map
  	local width = #(mapString:match("[^\n]+"))

  	-- Creates a new table with sub tables to store our map
  	for x = 1,width,1 do
  		self.TileTable[x] = {}
  	end
  	
  	-- 
  	local rowIndex,columnIndex = 1,1

  	-- Parse the map string into the table
  	for row in mapString:gmatch("[^\n]+") do

  		-- Make sure the row is of the correct length
  		assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))

  		for character in row:gmatch(".") do
  			-- Fill the table with the character
  			self.TileTable[columnIndex][rowIndex] = character

  			-- Advance the column counter
  			columnIndex = columnIndex + 1
		end

		--reset the column counter
		columnIndex = 1
		-- Advance the row counter
		rowIndex = rowIndex + 1

  	end	

end

function Map:draw()

local columnIndex, rowIndex = 1,1

  for columnIndex,column in ipairs(self.TileTable) do
    for rowIndex,char in ipairs(column) do
      local x,y = (columnIndex-1)*self.TileWidth, (rowIndex-1)*self.TileHeight
      lg.draw(self.TileSet, self.Quads[char], x, y)
    end
  end

end