module Scrabble

	class Player
		attr_accessor :score, :tiles

		def initialize  tiles=nil, score=0
			@score = score
			@tiles = tiles
		end

		def create_tile_hash
			tile_hash = Hash.new 0
			@tiles.each do |x|
				tile_hash[x] += 1
			end
			tile_hash
		end

		def wildcard hands
			other_array = hands
			while (other_array[0].include? '*')
				array = Array.new
				other_array.each do |x|
					'A'.upto('Z') do |y|
						array << x.sub('*', y)
					end
				end
				other_array = array
			end
			other_array
		end

		def make_next_move 
			hands = Array.new 
			@tiles.count.downto(2) do |x|
				hands.concat(@tiles.permutation(x).to_a.map{|x| x = x.join})
			end
			hands = wildcard(hands)

			words = Array.new
			hands.each do |x|
  			words << x if Scrabble::DICTIONARY.has_key?(x)
			end
			tile_hash = create_tile_hash
			best_word = ''
			best_score = 0
			words.each do |word|
				split_word = word.split(//)
				score = 0
				split_word.each do |y|
					if tile_hash[y] > 0
						score += TILE_VALUE[y]
						tile_hash[y] -=1
					end
				end
				if best_score < score
					best_word = word
					best_score = score
				end
				tile_hash = create_tile_hash
			end
			best_word
		end
	end
end

