
# Check out this hip scrabble module
require 'matrix'
module Scrabble

	class Board < Matrix

	end

	class Square 
		attr_accessor :tile, :multiplier, :multiplied

		def initialize multiplier=0, tile=nil, multiplied=false
			@tile = tile
			@multiplier = multiplier
			@multiplied = multiplied
		end
		
	end

	class Tile

		attr_accessor :letter, :value

		def initialize

		end

	end

end