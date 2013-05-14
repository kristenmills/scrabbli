module Scrabble

	# Moudule cotaining algorithms to generate next move
	module Generator

		extend self

		# Finds the first word  that you should play
		#
		# @param [Player] player the player whose tiles you are using
		# @param [Matrix] board the scrabble board matrix
		# @return and array containing the best word and the score you get for the round
		def first_word player, board
			words = DICTIONARY.get_all(player.tiles)
			best = ScrabbleWord.new('', 0, 0 ,0, :down)
			words.each do |word|
				row = board.row_size/2
				col = board.row_size/2
				word.length.times do
					score = 0
					if (0..14).cover?(row) && (0..14).cover?(col)
						score = attempt_score word, board, row, col, :down
					end
					if score and score > best[1]
						if rand > 0.5
							best = ScrabbleWord.new(word, score, row, col, :down)
						else
							best = ScrabbleWord.new(word, score, col, row, :across)
						end
					end
					row -=1
				end
			end
			[best, best.score]
		end

		# Finds the best word by adding your letters to other words on the board
		#
		# @param [Player] player the player whose tiles you are using
		# @param [Matrix] board the scrabble board matrix
		# @param [Array] word_list the list of words already been played
		# @return and array containing the best word and the score you get for the round
		def check_add_to_existing player, board, word_list
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
					score = attempt_score(x, board, row, col, word.dir) if (0..14).cover?(row) && (0..14).cover?(col)
					if score
						new_word = ScrabbleWord.new(x, score, row, col, word.dir)
						best = new_word if score > best.score && !Scrabble.same_word(new_word, word)
					end
				end
			end
			[best, best.score]
		end

		# Finds the best word by hooking onto an existing word
		#
		# @param [Player] player the player whose tiles you are using
		# @param [Matrix] board the scrabble board matrix
		# @param [Array] word_list the list of words already been played
		# @return and array containing the best word and the score you get for the round
		def check_hooking player, board, word_list
			best =Array.new(2, ScrabbleWord.new('', 0, 0, 0, 0))
			words = DICTIONARY.get_all(player.tiles)
			word_hash = Hash.new
			words.each do |word|
				word.each_char do |char|
					word_hash[char] ||= Set.new
					word_hash[char] << word
				end
			end
			word_list.each do |word|
				player.tiles.each do |char|
					if DICTIONARY.word?(word.word + char) || DICTIONARY.word?(char +word.word)
						word_hash[char].each do |new_word|
							row = word.row
							col = word.col
						 	word.dir == :across ? col -=1 : row -= 1
							best  = hook_helper(new_word, word.word.length , word, board, char, word.row , word.col, best, word.word + char) if DICTIONARY.word?(word.word + char)
							best = hook_helper(new_word, 0 , word, board, char, row, col, best, char + word.word) if DICTIONARY.word?(char + word.word)
						end
					end
				end
			end
		[best, best.inject(0){|sum, i| sum + i.score}]
		end

		# Finds the best word by playing words parallel to existing words
		# TODO: Fix scoring so it adds the smaller words
		#
		# @param [Player] player the player whose tiles you are using
		# @param [Matrix] board the scrabble board matrix
		# @param [Array] word_list the list of words already been played
		# @return and array containing the best word and the score you get for the round
		def check_parallel player, board, word_list
			best = [ScrabbleWord.new('',0,0,0,0)]
			words = DICTIONARY.get_all(player.tiles)
			word_list.each do |played_word|
				words.each do |new_word|
					if played_word.dir == :across
						row_1 = played_word.row-1
						row_2 = played_word.row+1
						col_1 = played_word.col - new_word.length + 1
						col_1 = col_1 >= 0 ? col_1 : 0
						col_2 = played_word.length + 2*new_word.length - 2
						col_2 = (0..14).cover?(col_2) ? col_2 : 14
						col_1.upto(col_2) do |col|
							best = parallel_helper(new_word, board, row_1, row_2, col, col, :across, best)
						end
					else
						col_1 = played_word.col-1
						col_2 = played_word.col+1
						row_1 = played_word.row - new_word.length + 1
						row_1 = row_1 >= 0 ? row_1 : 0
						row_2 = played_word.length + 2*new_word.length - 2
						row_2 = (0..14).cover?(row_2) ? row_2 : 14
						row_1.upto(row_2) do |row|
							best = parallel_helper(new_word, board, row, row, col_1, col_2, :down, best)
						end
					end
				end
			end
			[best, best[0].score] #not correct score need to account for smaller words
		end

		# Finds the best word by playing words perpendicular to an exisitng word
		#
		# @param [Player] player the player whose tiles you are using
		# @param [Matrix] board the scrabble board matrix
		# @param [Array] word_list the list of words already been played
		# @return and array containing the best word and the score you get for the round
		def check_perpendicular player, board, word_list
			best = ScrabbleWord.new('', 0, 0, 0, 0)

		end

		# Place a word on the board
		#
		# @param [ScrabbleWord] word the word to place
		# @param [Matrix] board the scrabble board
		# @param [Player] player the player playing the word
		def place word, board, player
			row = word.row
			col = word.col
			word.word.each_char do |char|
				if !board[row,col].multiplied
					board[row,col].tile = char
					board[row,col].multiplied = true
					index = player.tiles.index(char)
					index ||= player.tiles.index('*')
					player.tiles.delete_at(index)
				end
				if word.dir == :down
					row += 1
				else
					col += 1
				end
			end
		end

		# Attempts to place a word on the board
		#
		# @param [String] word the word you are attempting to place
		# @param [Matrix] board the scrabble board
		# @param [Integer] row the row you want to start at
		# @param [Integer] col the column you want to start at
		# @param [Symbol]	dir the direction (:down or :across) that you are building in
		# @return the score of the word or false if it can't be placed
		def attempt_score word, board, row, col, dir
			sum =0
			multiplier = 1
			word.each_char do  |char|
				return false if invalid(board, char, row, col, dir) || !(0..14).cover?(col) || !(0..14).cover?(row)
				if !board[row,col].multiplied
					val = TILE_VALUE[char]
					val ||= 0
					if board[row,col].type == :word
						multiplier *= board[row,col].multiplier
					else
						val *= board[row,col].multiplier
					end
				else
					val = TILE_VALUE[board[row, col].tile]
					val ||= 0
				end
				sum += val
				if dir == :down
					row += 1
				else
					col += 1
				end
			end
			sum*multiplier
		end

		# Checks if a given tile is invlaid
		#
		# @param [Matrix] board the scrabble board
		# @param [String] tile the tile trying to be placed
		# @param [Integer] row the row you are trying to place a tile in
		# @param [Integer] col the column you are trying to place a tile in
		# @param [Symbol] dir the direction the current word this tile is in is going
		def invalid board, tile, row, col, dir
			invalid = false
			word = ''
			if dir == :down
				if (!board[row, col-1].nil? && board[row, col-1].tile) || (!board[row, col+1].nil? && board[row, col+1].tile)
					temp_col = col
					while board[row, temp_col-1].tile
						temp_col -= 1
					end
					while board[row, temp_col].tile || col == temp_col
						if temp_col == col
							word += tile
						else
							word += board[row, temp_col].tile
						end
						temp_col+=1
					end
					if !DICTIONARY.word?(word)
						invalid = true
					end
				end
			else
				if(!board[row-1, col].nil? && board[row-1, col].tile) || (!board[row+1, col].nil? && board[row+1, col].tile)
					temp_row = row
					while board[temp_row-1, col].tile
						temp_row -= 1
					end
					while board[temp_row, col].tile  || row == temp_row
						if temp_row == row
							word += tile
						else
							word += board[temp_row, col].tile
						end
						temp_row+=1
					end
					if !DICTIONARY.word?(word)
						invalid = true
					end
				end
			end
			invalid
		end

		# A helper method that gets the best for a hook word
		#
		# @param [String] new_word the new word you are trying to place
		# @param [Integer] ad some adjustment to either row or column depending on direction
		# @param [ScrabbleWord] word the scrabble word you started with
		# @param [Matrix] board the scrabble board
		# @param [String] char the character you are using
		# @param [Integer] row_1 the starting row of the existing word plus the new character
		# @param [Integer] col_1 the starting column of the existing word plus the new character
		# @param [Array] best the current best word
		# @param [String] adjusted_word the adjusted word with the new hook later
		# @return the best word
		def hook_helper new_word, ad, word, board, char, row_1, col_1, best, adjusted_word
			ind = (0..new_word.length-1).find_all { |i| new_word[i,1] == char }
			ind.each do |i|
				row = row_1
				col = col_1
				dir = nil
				if word.dir == :across
					row -= i
					col += ad
					dir = :down
				else
					row += ad
					col -= i
					dir = :across
				end
				if (0..14).cover?(row) && (0..14).cover?(col)
					new_score = attempt_score(new_word, board, row, col, dir)
					hook_score = attempt_score(adjusted_word, board, row_1, col_1, word.dir)
				end
				if new_score && hook_score
					if new_score + hook_score > best.inject(0){|sum, i| sum + i.score}
						best =[ScrabbleWord.new(new_word, new_score, row, col, dir), 
							ScrabbleWord.new(adjusted_word, hook_score, row_1, col_1, word.dir)]
					end
				end
			end
			best
		end

		# A helper method for getting the best parallel word
		#
		# @param [String] new_word the new word you are trying to place
		# @param [Matrix] board the scrabble board
		# @param [Integer] row_1 the first row
		# @param [Integer] row_2 the second row
		# @param [Integer] col_1 the first col
		# @param [Integer] col_2 the second col
		# @param [Symbol] dir the direction
		# @param [Array] best the array of best words
		# @return the best word and any smaller words
		def parallel_helper new_word, board, row_1, row_2, col_1, col_2, dir, best
			score = attempt_score(new_word, board, row_1, col_1, dir)
			best = [ScrabbleWord.new(new_word, score, row_1, col_1, dir)]	if score and best[0].score < score
			score = attempt_score(new_word, board, row_2, col_2, dir)
			best = [ScrabbleWord.new(new_word, score, row_2, col_2, dir)]	if score and best[0].score < score
			best
		end
	end
end