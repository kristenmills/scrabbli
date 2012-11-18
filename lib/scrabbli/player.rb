module Scrabble

	class Player
		attr_accessor :score, :tiles

		def initialize score=0, tiles=nil
			@score = score
			@tiles = tiles
		end
		
	end
end