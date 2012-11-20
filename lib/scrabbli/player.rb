require 'set'
require 'colorize'
module Scrabble

	class Player
		attr_accessor :score, :tiles

		#Create a new Scrabble Player
		def initialize  tiles=nil, score=0
			@score = score
			@tiles = tiles
		end

		#create the tile hash
		def create_tile_hash
			tile_hash = Hash.new 0
			@tiles.each do |x|
				tile_hash[x] += 1
			end
			tile_hash
		end

		#Replace all of the wildcars with actual characters and then filter out non words
		def filter k, v
			other_array = v
			k.times do
				array = Array.new
				other_array.each do |x|
					'A'.upto('Z') do |y|
						array << x.sub('*', y)
					end
				end
				other_array = array
			end
			other_array.reject{|val| !Scrabble::DICTIONARY.has_key?(val)}
		end

		#return the characters in the word before the first asterisk
		def prefix word
			word.split('*')[0]
		end

		#get all of the real words
		def get_words perms
			set = Set.new
			perms.each do |k,v|
				set.merge(filter(k,v))
			end
			set
		end

		#returns the highest scoring word
		def best words
			tile_hash = create_tile_hash
			best_word = [[],0]
			words.each do |word|
				split_word = word.split(//)
				score = 0
				tile_word = ""
				split_word.each do |y|
					if tile_hash[y] > 0
						score += TILE_VALUE[y]
						tile_hash[y] -=1
						tile_word += y
					else
						tile_word += y.yellow
					end
				end
				if best_word[1] < score
					best_word = [tile_word, score]
				end
				tile_hash = create_tile_hash
			end
			best_word
		end

		#makes the next move
		def make_next_move 
			prefix_hash = Hash.new
			@tiles.count.downto(2) do |x|
				ti = @tiles.permutation(x)
				ti.each do |y|
					c = prefix(y.join)
					prefix_hash[c] ||= Set.new
					prefix_hash[c] << y.join
				end
			end
			words =Hash.new 
			count = 0
			prefix_hash.each do |p, v|
				if(Scrabble::DICTIONARY.children(p).count != 0)
					count +=1
					v.each do |y|
						c = y.count "*"
						words[c] ||= Set.new
						words[c] << y
					end
				end
			end
			words = get_words(words)
 			best(words)[0]
		end
	end
end