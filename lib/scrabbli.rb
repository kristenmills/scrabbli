
# The module that contains relevant scrabble things
module Scrabble

end

require File.join(File.dirname(__FILE__), 'trie', 'trie_node')
require File.join(File.dirname(__FILE__), 'trie', 'trie')
require File.join(File.dirname(__FILE__), 'scrabbli', 'constants')
require File.join(File.dirname(__FILE__), 'scrabbli', 'tile')
require File.join(File.dirname(__FILE__), 'scrabbli', 'board_square')
require File.join(File.dirname(__FILE__), 'scrabbli', 'player')
# require File.join(File.dirname(__FILE__), 'test', 'trie.rb')
require File.join(File.dirname(__FILE__), 'scrabbli', 'game')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli_helpers')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli') 
# hand =  "FORE*TRY" 
# player =  Scrabble::Player.new("Kristen", hand.split(//))
# # puts "Answer: #{Scrabble::DICTIONARY.has_key? "CHEDDAR"}"
# # Benchmark.bm do |x|
# # 	x.report {Scrabble::DICTIONARY.has_key? "CHEDDAR"}
# # end
# # puts Scrabble::DICTIONARY.has_key? "APPLE"

# #puts player.get_possible_words.to_a.count
#  puts player.get_next_moves.to_a
# Benchmark.bm do |x|
# 	#x.report {player.get_possible_words }
# 	 x.report {player.get_next_moves }
# end

# # # puts player.traverse "UDBKFB"

# # begin
# # 	Scrabble::CLI.run
# # rescue Interrupt
# # 	puts 
# # 	Scrabble::Helpers::exit_message
# # end