module Scrabble
	module CLI

		# The module that contains helper methods for the CLI
		module Helpers
			extend self

			# Displays the ASCII Scrabbli header text
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

			# Draws an ASCII version of the game board
			#
			# @param [Game] game a Game object
			def draw_board game
				string = ''
				print " "
				0.upto(14) do |x|
					print "%5s" % [x.to_s]
				end
				game.board.each_with_index do |square, row, column|
					anti_string = square.tile
					anti_string ||= ' '
					if column == 0
						puts string
						string = "%-3s" % [row.to_s]
					end
					case square.multiplier
					when 3
						if square.type == :word
							string +="[ ".green + anti_string + " ]".green
						else
							string +="[ ".blue + anti_string + " ]".blue
						end
					when 2
						if square.type == :word
							string +="[ ".light_red + anti_string + " ]".light_red
						else
							string +="[ ".light_cyan + anti_string + " ]".light_cyan
						end
					else
						string += "[ " + anti_string + " ]"
					end
				end
				puts string
			end

			# Prints out a certain number of asterisks
			#
			# @param [Integer] count the number of asterisks to print out
			def stars count
				str = ''
				count.times do
					str += "*"
				end
				str
			end

			# Displays a menu in the CLI
			#
			# @param [Symbol] star_color the color to print the stars
			# @param [Symbol] header_color the color to print the header text
			# @param [String] header the header
			# @param [+String] options any options that would be included on this menu
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

			# Creates a normal menu which is a menu with green stars and light cyan header text
			#
			# @param [String] header the header
			# @param [+String] options any options that would be included on this menu
			def normal_menu header, *options
				menu :green, :light_cyan, split(header, 43), *options
			end

			# Creates an alert menu which is a menu with light red stars and light yellow header text
			#
			# @param [String] header the header
			# @param [Boolean] press_enter whether to include press enter to continue on the menu title
			# @param [+String] options any options that would be included on this menu
			def alert_menu header, press_enter=true, *options
				h = split(header, 43) 
				h << "Press Enter To Continue" if  press_enter
				menu :light_red, :light_yellow, h, *options
			end

			# Creates an alert menu that says "Thanks for Playing!"
			def exit_message 
				alert_menu "Thanks for playing!", false
			end

			# Creates an alert menu that says "Invalid Option"
			def invalid_option
				alert_menu "Invalid option!"
			end

			# splits string for wrapping
			# 
			# @param [String] string the string to be split
			# @param [Integer] length the length of the line
			# @return the array of each line
			def split string, length
				split = Array.new
				if string.length > length #if the string needs to be split
					string_words = string.split(" ")
					line = ""
					string_words.each do |x|
						if x.length > length #if the word needs to be split
							#add the start of the word onto the first line (even if it has already started)
							while line.length < length
								line += x[0]
								x = x[1..-1]
							end
							split << line
							#split the rest of the word up onto new lines
							split_word = x.scan(%r[.{1,#{length}}])
							split_word[0..-2].each do |word|
								split << word
							end
							line = split_word.last+" "
						elsif (line + x).length > length-1 #if the word would fit alone on its own line
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
end