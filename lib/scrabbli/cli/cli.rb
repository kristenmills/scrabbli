module Scrabble

	# The module that contains methods for the CLI
	module CLI
		extend self
		attr_accessor :game, :player

		#Entry point of the CLI
		def run
			option =0
			attempted = false
			Helpers::header
			until (1..2).cover?(option) do
				Helpers::invalid_option if attempted
				attempted = true
				Helpers::normal_menu "What would you like to do?", "New Game", "Exit"
				option = gets.chomp.to_i
			end
			case option
			when 1
				new_game
			when 2
				Helpers::exit_message
			end
		end

		#Starts a new game. Asks for your name.
		def new_game
			players = 0
			quit = true
			@game = Game.new
			Helpers::normal_menu "What's your name?"
			name = gets.chomp
			@player = Player.new(name)
			@game.add_player(@player)
			game_setup_menu
		end

		#Menu that allows adding players and tiles and starting the game
		def game_setup_menu
			option = 0
			relevant = true
			while relevant do
				attempted = false
				until (1..4).cover?(option) do
					Helpers::invalid_option if attempted
					attempted = true
					Helpers::normal_menu "Hello, " + @player.name + "! What would you like to do?", "Add Player", "Set Tiles", "Start Game", "Exit"
					option = gets.chomp.to_i
				end
				case option
				when 1
					add_player
				when 2
					set_tiles
				when 3
					start_game
				when 4
					relevant = false
					Helpers::exit_message
				end
				option = 0
			end
		end

		#Adds a player to the game
		def add_player
			if @game.players.count < 4
				Helpers::normal_menu "Enter Player name?"
				name = gets.chomp until !name.nil?
				@game.add_player(Player.new(name))
				Helpers::alert_menu(name + " has been added to the game.")
				gets
			else
				Helpers::alert_menu("You can't have more than 4 players.")
				gets
			end
		end

		#Add tiles to your players
		def set_tiles
			option = 0
			relevant = true
			while relevant do
				attempted = false
				until (1..4).cover?(option) do
					Helpers::invalid_option if attempted
					attempted = true
					Helpers::normal_menu "Tiles: #{@player.pp_tiles}. What do you want to do?", "Add Tile", "Remove Tile", "Reset Hand", "Return To Menu"
					option = gets.chomp.to_i
				end
				case option
				when 1
					add_tile
				when 2
					remove_tile
				when 3
					reset_hand
				when 4
					relevant = false
				end
				option = 0
			end
		end

		# Add a single tile
		def add_tile
			if(@player.tiles.count < 7)
				letter = 0
				attempted = false
				until ('A'..'Z').cover?(letter) || letter == '*' do
					Helpers::invalid_option if attempted
					attempted = true
					Helpers::normal_menu "Enter a letter to add to your hand"
					letter = gets.chomp.upcase
				end
				@player.tiles.concat(letter.split(/ /))
			else
				Helpers::alert_menu("You already have 7 tiles.")
				gets
			end
		end

		# Remove a single tile
		def remove_tile
			if(@player.tiles.count != 0)
				letter = ''
				attempted = false
				until @player.tiles.include?(letter) do
					Helpers::invalid_option if attempted
					attempted = true
					Helpers::normal_menu "Which tile do you want to remove?"
					letter = gets.chomp.upcase
				end
				i = @player.tiles.index(letter)
				@player.tiles.delete_at(i)
			else
				Helpers::alert_menu("You have no tiles to remove.")
				gets
			end
		end

		#Empties the entire hand
		def reset_hand
			@player.tiles.clear
			Helpers::alert_menu("You have emptied your hand.")
			gets
		end

		#start the game
		def start_game
			option = 0
			relevant = true
			while relevant do
				attempted = false
				until (1..6).cover?(option) do
					Helpers::invalid_option if attempted
					Helpers::draw_board @game
					Helpers::normal_menu "What do you want to do?", "Generate Move", "Add Tiles to Hand", "Add Word", "Add existing words", "Display Word List", "End Game"
					option = gets.chomp.to_i
				end
				case option
				when 1
					@game.play_word
				when 2
					set_tiles
				when 3
					add_word
				when 4
					add_existing_words
				when 5
					puts @game.word_list.to_a
				when 6
					relevant = false
				end
				option = 0
			end
		end

	end
end