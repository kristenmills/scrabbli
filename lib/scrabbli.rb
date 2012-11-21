
# The module that contains relevant scrabble things
module Scrabble

end

require File.join(File.dirname(__FILE__), 'scrabbli', 'constants')
require File.join(File.dirname(__FILE__), 'scrabbli', 'tile')
require File.join(File.dirname(__FILE__), 'scrabbli', 'board_square')
require File.join(File.dirname(__FILE__), 'scrabbli', 'player')
require File.join(File.dirname(__FILE__), 'scrabbli', 'game')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli_helpers')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli') 
# hand =  ["M","I","T","E","L","Y"] 
# player =  Scrabble::Player.new hand

# # puts player.get_first_move
# Benchmark.bm do |x|
# 	x.report {player.get_first_move}
# end

# puts player.traverse "UDBKFB"

begin
	Scrabble::CLI.run
rescue Interrupt
	puts 
	Scrabble::Helpers::exit_message
end