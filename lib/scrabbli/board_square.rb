module Scrabble
	class BoardSquare

		attr_accessor :tile, :multiplier, :multiplied

		def initialize multiplier=0, tile=nil, multiplied=false
			@tile = tile
			@type = type
			@multiplied = multiplied
		end

	end
end
