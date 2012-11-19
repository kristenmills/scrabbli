require File.join(File.dirname(__FILE__), 'anagram_trie')
require File.join(File.dirname(__FILE__), 'constants')

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

		def make_next_move 
			trie = AnagramTrie.build_trie(@tiles.join)
			words = AnagramTrie.traverse trie
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
