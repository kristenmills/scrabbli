module Scrabble
	class BoardSquare

		attr_accessor :tile, :multiplier, :multiplied, :type

		def initialize multiplier=1, type =:word , tile=nil, multiplied=false
			@tile = tile
			@multiplier = multiplier
			@type = type
			@multiplied = multiplied
		end

	end
end
