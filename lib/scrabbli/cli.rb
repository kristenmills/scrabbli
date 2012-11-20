require 'colorize'
module Scrabble
	class CLI

		attr_accessor :game

		#create a new CLI
		def initialize game
			@game = game
		end

		#display the board to stdout
		def draw_board
			string = ''
			@game.board.each_with_index do |square, row, column|
				if column == 0
					puts string
					string =''
				end
				case square.multiplier
				when 3
					if square.type == :word
						string +="[ ".green + square.tile + " ]".green
					else
						string +="[ ".blue + square.tile + " ]".blue
					end
				when 2
					if square.type == :word
						string +="[ ".light_red + square.tile + " ]".light_red
					else
						string +="[ ".light_cyan + square.tile + " ]".light_cyan
					end
				else
					string += "[ " + square.tile + " ]"
				end
			end
			puts string
		end
	end
end