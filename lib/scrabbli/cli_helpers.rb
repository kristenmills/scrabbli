require 'colorize'
module Scrabble
	module Helpers
		extend self

		def header
			puts stars(47).green
			puts "*  ".green + "   _____                _     _     _ _  ".light_red + "  *".green
			puts "*  ".green + "  / ____|              | |   | |   | (_) ".light_red + "  *".green
			puts "*  ".green + " | (___   ___ _ __ __ _| |__ | |__ | |_  ".light_red + "  *".green
			puts "*  ".green + "  \\___ \\ / __| '__/ _` | '_ \\| '_ \\| | | ".light_red + "  *".green
			puts "*  ".green + "  ____) | (__| | | (_| | |_) | |_) | | | ".light_red + "  *".green
			puts "*  ".green + " |_____/ \\___|_|  \\__,_|_.__/|_.__/|_|_| ".light_red + "  *".green
			puts "*  ".green + "                                         ".light_red + "  *".green
		end

		#display the board to stdout
		def draw_board game
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

		def stars count
			str = ''
			count.times do
				str += "*"
			end
			str
		end

		def menu star_color, header_color, header, *options
			puts stars(47).colorize(star_color)
			puts "* ".colorize(star_color) + " ".center(43) + " *".colorize(star_color)
			header.each do |line|
				puts "* ".colorize(star_color) + line.center(43).colorize(header_color) + " *".colorize(star_color)
			end
			puts "* ".colorize(star_color) + " ".center(43) + " *".colorize(star_color)
			puts stars(47).colorize(star_color)
			options.each_with_index do |item, index|
				puts "* ".colorize(star_color)  + "#{index+1}: #{item}".center(43) + " *".colorize(star_color)
			end
			puts stars(47).colorize(star_color) if options.count > 0
		end

		def normal_menu header, *options
			menu :green, :light_cyan, split(header, 43), *options
		end

		def alert_menu header, press_enter=true, *options
			h = split(header, 43) 
			h << "Press Enter To Continue" if  press_enter
			menu :light_red, :light_yellow, h, *options
		end

		def exit_message 
			alert_menu "Thanks for playing!", false
		end

		def invalid_option
			alert_menu "Invalid option!"
		end

		# splits string for wrapping
		# 
		# @param [String] string the string to be split
		# @param [Width] width the width of the line
		def split string, width
			split = Array.new
			if string.length > width #if the string needs to be split
				string_words = string.split(" ")
				line = ""
				string_words.each do |x|
					if x.length > width #if the word needs to be split
						#add the start of the word onto the first line (even if it has already started)
						while line.length < width
							line += x[0]
							x = x[1..-1]
						end
						split << line
						#split the rest of the word up onto new lines
						split_word = x.scan(%r[.{1,#{width}}])
						split_word[0..-2].each do |word|
							split << word
						end
						line = split_word.last+" "
					elsif (line + x).length > width-1 #if the word would fit alone on its own line
						split << line.chomp
						line = x + " "
					else #if the word can be added to this line
						line += x + " "
					end
				end
				split << line
			else #if the string doesn't need to be split
				split = [string]
			end
			#give back the split line
			return split
		end
	end
end