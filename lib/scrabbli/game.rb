require 'matrix'
module Scrabble
	#The class that represent all components of a game of scrabble. includes the dictionary, the boards, 
	class Game
		attr_accessor :board, :tiles, :my_score, :opponents_score

		#Initializes a Scrabble Game
		def initiialize num_players
			@board = Matrix.build(15) {BoardSquare.new}
			@players = Array.new
			num_players.time do 
				@players << Player.new
			end
		end

		def setup_board

		end
	end
end
