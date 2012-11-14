module Scrabble
	class BoardSquare
		attr_accessor :tile, :multiplier, :multiplied

		def initialize multiplier=0, tile=nil, multiplied=false
			@tile = tile
			@multiplier = multiplier
			@multiplied = multiplied
		end
	end
end
