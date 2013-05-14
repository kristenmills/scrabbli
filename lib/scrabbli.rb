
# The module that contains relevant scrabble things
module Scrabble

end

require 'benchmark'
require 'set'
require 'colorize'
require 'matrix'
require File.join(File.dirname(__FILE__), 'scrabbli', 'trie', 'trie_node')
require File.join(File.dirname(__FILE__), 'scrabbli', 'trie', 'trie')
require File.join(File.dirname(__FILE__), 'scrabbli', 'constants')
require File.join(File.dirname(__FILE__), 'scrabbli', 'board_square')
require File.join(File.dirname(__FILE__), 'scrabbli', 'generator')
require File.join(File.dirname(__FILE__), 'scrabbli', 'player')
require File.join(File.dirname(__FILE__), 'scrabbli', 'game')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli', 'cli_helpers')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli', 'cli')

Scrabble::CLI.run

# game = Scrabble::Game.new

# player = Scrabble::Player.new('Kristen',"AFTERAKDJASDRAZEBET".split(//))

# puts Scrabble::DICTIONARY.get_all("REGAL**Y".split(//)).to_a.count
# Benchmark.bm do |x|
# 	x.report {Scrabble::DICTIONARY.get_all("REGAL**Y".split(//))}
# end

# puts Scrabble::DICTIONARY.get_all("*sn".split(//), "RO").to_a
# 
# word = Scrabble::Generator.first_word player, game.board
# word = Scrabble::ScrabbleWord.new("AFTER", 132, 7, 6, :across)
# game.word_list << word
# Scrabble::Generator.place word, game.board, player
# # puts Scrabble::Generator.attempt_score "SNACKS", game.board, word.row, 14, :down
# val = Scrabble::Generator.check_add_to_existing(player, game.board, game.word_list)
# Scrabble::Generator.place(val[0], game.board, player)
# Scrabble::CLI::Helpers::draw_board game

# puts Scrabble::Generator.check_add_to_existing player, game.board, game.word_list
# Benchmark.bm do |x|
	# x.report {Scrabble::Generator.check_add_to_exising player, game.board, game.word_list}
# end

# word = Scrabble::ScrabbleWord.new("AMBER", 34, 7, 7, :across)
# # word2 = Scrabble::ScrabbleWord.new("AMBER", 55, 7, 7, :across)
# # puts Scrabble::same_word(word, word2)
# # game = Scrabble::Game.new

# Scrabble::Generator.place(word, game.board, player)
# # puts Scrabble::Generator.invalid(game.board, 'A', 7, 7, :down)
# Scrabble::CLI::run