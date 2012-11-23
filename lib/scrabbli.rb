
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
require File.join(File.dirname(__FILE__), 'scrabbli', 'tile')
require File.join(File.dirname(__FILE__), 'scrabbli', 'board_square')
require File.join(File.dirname(__FILE__), 'scrabbli', 'generator')
require File.join(File.dirname(__FILE__), 'scrabbli', 'player')
require File.join(File.dirname(__FILE__), 'scrabbli', 'game')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli', 'cli_helpers')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli', 'cli') 

game = Scrabble::Game.new

player = Scrabble::Player.new('Kristen','REG*ITY'.split(//))

puts Scrabble::DICTIONARY.get_all("HIKAMBERPT".split(//), "JACK").to_a
Benchmark.bm do |x|
	x.report {Scrabble::DICTIONARY.get_all("HIKNGPT".split(//), "JACK")}
end

# puts Scrabble::Generator.first_word player, game.board
# Benchmark.bm do |x|
# 	x.report {Scrabble::Generator.first_word player, game.board}
# end