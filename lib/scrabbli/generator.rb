module Scrabble

	#Moudule cotaining algorithms to generate next move
	module Generator

		extend self

		# Finds the first word  that you should play
		#
		# @param [Player] player the player who tiles you are using 
		# @param [Matrix] board the scrabble board matrix
		def first_word player, board
			words = DICTIONARY.get_all(player.tiles)
			best = ['', 0, 0, 0]
			words.each do |word| 
				row = board.row_size/2
				col = board.row_size/2
				word.length.times do 
					score = attempt_placement word, board, row, col, :down
					if score > best[1]
						best = [word, score, row, col]
					end
					row -=1
				end
			end
			best
		end

		def check_hooking player, board
		end

		def check_add_to_exising player, board
		end

		def check_perpendicular player, board
		end

		def check_parallel player, board
		end

		# Attempts to place a tile on the board
		#
		# @param [String] word the word you are attempting to place
		# @oaram [Matrix] board the scrabble board
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