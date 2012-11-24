module Scrabble

	#Moudule cotaining algorithms to generate next move
	module Generator

		extend self

		# Finds the first word  that you should play
		#
		# @param [Player] player the player whose tiles you are using 
		# @param [Matrix] board the scrabble board matrix
		def first_word player, board
			words = DICTIONARY.get_all(player.tiles)
			best = ScrabbleWord.new('', 0, 0 ,0, :down)
			words.each do |word| 
				row = board.row_size/2
				col = board.row_size/2
				word.length.times do 
					score = 0
					if (0..14).cover?(row) && (0..14).cover?(col)
						score = attempt_placement word, board, row, col, :down
					end
					if score > best[1]
						if rand > 0.5
							best = ScrabbleWord.new(word, score, row, col, :down)
						else
							best = ScrabbleWord.new(word, score, col, row, :across)
						end
					end
					row -=1
				end
			end
			best
		end

		# Finds the best word by adding your letters to other words on the board
		# 
		# @param [Player] player the player whose tiles you are using 
		# @param [Matrix] board the scrabble board matrix
		# @param [Array] word_list the list of words already been played
		def check_add_to_exising player, board, word_list
			best =ScrabbleWord.new('', 0, 0, 0, 0)
			word_list.each do |word|
				list = DICTIONARY.get_all(player.tiles, word.word)
				list.each do |x|
					val = x.partition(word.word)[0].length
					row = word.row
					col = word.col
					if(word.dir == :down)
						row -= val
					else
						col -= val
					end
					score = 0
					if (0..14).cover?(row) && (0..14).cover?(col)
						score = attempt_placement(x, board, row, col, word.dir)
					end
					if score > best.score
						best = ScrabbleWord.new(x, score, row, col, word.dir)
					end
				end
			end
			best
		end

		def check_hooking player, board, word_list

		end

		def check_perpendicular player, board
		end

		def check_parallel player, board
		end

		def place word, board
			row = word.row
			col = word.col
			word.word.each_char do |char|
				board[row,col].tile = char
				board[row,col].multiplied = true
				if word.dir == :down
					row += 1
				else
					col += 1
				end
			end
		end

		# Attempts to place a tile on the board
		#
		# @param [String] word the word you are attempting to place
		# @param [Matrix] board the scrabble board
		# @param [Integer] row the row you want to start at
		# @param [Integer] col the column you want to start at
		# @param [Symbol]	dir the direction (:down or :across) that you are building in 
		# @return the score of the word or 0 if it can't be placed
		def attempt_placement word, board, row, col, dir
			sum =0
			multiplier = 1
			word.each_char do  |char|
				val = TILE_VALUE[char]
				val ||= 0
				if !board[row,col].multiplied 
					if board[row,col].type == :word
						multiplier *= board[row,col].multiplier
					else
						val *= board[row,col].multiplier
					end
				end
				sum += val
				if dir == :down
					row += 1
				else
					col += 1
				end
				return 0 unless (0..14).cover?(col) && (0..14).cover?(row)
			end
			sum*multiplier
		end
	end

end