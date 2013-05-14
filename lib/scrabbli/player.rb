module Scrabble

	# The Player class
	class Player
		attr_accessor :name, :score, :tiles

		# Create a new Scrabble Player
		#
		# @param [String] name the players name
		# @param [Array] tiles the players tiles
		# @param [Integer] score the players score
		def initialize  name, tiles=Array.new, score=0
			@name = name
			@score = score
			@tiles = tiles
		end

		# Player's to string
		def to_s
			@name
		end

		# Pretty prints a player's tile
		def pp_tiles
		 str = ''
		 @tiles.each do |x|
		 	str += x + ","
		 end
		 (7-@tiles.count).times do
		 	str += "_,"
		 end
		 str.chomp.chop
		end
	end
end