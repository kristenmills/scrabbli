module Scrabble

	# The class that represents a single square on the board
	class BoardSquare

		attr_accessor :tile, :multiplier, :multiplied, :type

		# Create a new board square
		#
		# @param [Integer] multiplier the multiplier of this board square
		# @param [Symbol] type the type of mutliplier(:word or :letter) for this square 
		# @param [Tile] tile the letter tile that is currently on this square
		# @param [Boolean] multiplied has the multiplier on this square already been used?
		def initialize multiplier=1, type =:word , tile=nil, multiplied=false
			@tile = tile
			@multiplier = multiplier
			@type = type
			@multiplied = multiplied
		end

	end
end
