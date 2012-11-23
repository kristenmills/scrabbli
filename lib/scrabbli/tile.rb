module Scrabble

	#The class representing a single Tile in the game
	class Tile

		attr_accessor :letter, :value

		# Create a Tile
		#
		# @param [String] letter the letter for this tile
		# @param [Integer] value the ammount that tile is worth
		def initialize letter, value
			@letter = letter
			@value  = value
		end

		# to string for th etile
		def to_s
			@letter
		end

		# Scores an array of tiles
		#
		# @param [Array] tiles an array of tiles
		# @return the total score
		def self.score tiles
			sum = 0
			tiles.each do |x|
				sum += x.value
			end
			sum
		end
		
	end
end