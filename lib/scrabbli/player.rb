require 'set'
require 'colorize'
module Scrabble

	class Player
		attr_accessor :name, :score, :tiles

		#Create a new Scrabble Player
		def initialize  name, tiles=Array.new, score=0
			@name = name
			@score = score
			@tiles = tiles
		end

		def to_s
			@name
		end

		def pp_tiles
		 str = ''
		 @tiles.each do |x|
		 	str += x + ","
		 end
		 (7-@tiles.count).times do
		 	str += "_,"
		 end
		 str.chomp
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

		def score_words words
			tile_hash = create_tile_hash
			words_scored = Hash.new
			words.each do |word|
				split_word = word.split(//)
				score = 0
				tile_word = []
				split_word.each do |y|
					if tile_hash[y] > 0
						score += TILE_VALUE[y]
						tile_hash[y] -=1
						tile_word << Tile.new(y, TILE_VALUE[y])
					else
						tile_word << Tile.new(y.yellow, 0)
					end
				end
				words_scored[score] ||= Set.new
				words_scored[score] << tile_word
				tile_hash = create_tile_hash
			end
			words_scored
		end

		#makes the next move
		def get_next_moves 
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
			get_words(words)
		end

		def new_word x, word
			nw = Array.new

			word.each do |v|
				nw << v.dup
			end
			nw[x].value = nw[x].value*2
			2 * (Tile.score nw)
		end

		def get_first_move
			words = get_next_moves
			scored_words = score_words(words)
			high = scored_words.max[0]
			scored_words.each do |k,v|
				if k < high
					v.delete_if{|x| x.length < 5}
				end
			end
			scored_words.delete_if{|k,v| v.empty?}
			rescored_words = Hash.new
			scored_words.each_value do |value|
				value.each do |word|
					best_score = 2*(Tile.score word)
					row = 7 - word.length/2
					column = 7
					(word.length - 4).times do |x|
						row_pos = 3-x
						row_neg = 7 - x
						new_score = new_word x, word
						if new_score > best_score
							best_score = new_score
							row=row_pos
						end
						new_score = new_word(-(x+1), word)
						if new_score > best_score
							best_score = new_score
							row=row_neg
						end
					end
					rescored_words[best_score] ||= Array.new
					rescored_words[best_score] << [word, row, column]
				end
			end
			Tile.display(rescored_words[rescored_words.max[0]][0])
		end
	end
end