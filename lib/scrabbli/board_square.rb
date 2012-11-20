module Scrabble
	class BoardSquare

		attr_accessor :tile, :multiplier, :multiplied, :type

		#create a new board square
		def initialize multiplier=1, type =:word , tile=" ", multiplied=false
			@tile = tile
			@multiplier = multiplier
			@type = type
			@multiplied = multiplied
		end

	end
end
