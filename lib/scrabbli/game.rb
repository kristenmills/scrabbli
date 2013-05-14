module Scrabble

	# The class that represent all components of a game of scrabble. includes the dictionary, the boards, 
	class Game

		attr_accessor :board, :players, :word_list

		# Initializes a Scrabble Game
		def initialize
			@board = Matrix.build(15){BoardSquare.new}
			setup_board
			@players = Array.new
			@word_list = Set.new
		end

		# Adds a Player to the game
		#
		# @param [Player] player the player to add to the game
		def add_player player
			@players << player
		end

		# Parse the board.txt file to get the multiplier information
		def parse_board
			multiplier_board = Array.new
			File.open(File.join(File.dirname(__FILE__), '..', '..', 'board.txt')).each_line do |line|
				line.chomp!
			 	line.delete!('[')
			 	line.delete!(']')
				multiplier_board<<line.split(//)
			end
			multiplier_board
		end

		# Setup the board matrix
		def setup_board
			multiplier_board = parse_board
			multiplier_board.each_with_index do |line, row|
				line.each_with_index do |square, column|
					case square
					when 'T'
						@board[row,column].multiplier = 3
						@board[row,column].type = :word
					when 't'
						@board[row,column].multiplier = 3
						@board[row,column].type = :letter
					when 'D'
						@board[row,column].multiplier = 2
						@board[row,column].type = :word
					when 'd'
						@board[row,column].multiplier = 2
						@board[row,column].type = :letter
					end
				end
			end
		end

		# def add word
		# 	@word_list << word
		# end

		def play_word
			best_word = ScrabbleWord.new('',0, 0, 0, 0)
			best_score = 0
			if @word_list.empty?
				word  = Generator::first_word @players[0], @board
				best_word = word[0]
				best_score = word[1]
			else
				word = Generator::check_add_to_existing(@players[0], @board, @word_list)
				if word[1] > best_score
					best_word = word[0]
					best_score = word[1]
				end
				word = Generator::check_hooking(@players[0], @board, @word_list)
				if word[1] > best_score
					best_word = word[0]
					best_score = word[1]
				end
				word = Generator::check_parallel(@players[0], @board, @word_list)
				if word[1] > best_score
					best_word = word[0]
					best_score = word[1]
				end
				word = Generator::check_perpendicular(@players[0], @board, @word_list)
				if word[1] > best_score
					best_word = word[0]
					best_score = word[1]
				end
			end
			@word_list << best_word if best_word.word != ''
			Generator::place(best_word, @board, @players[0])
		end
	end
end