
# The module that contains relevant scrabble things
module Scrabble

end

require File.join(File.dirname(__FILE__), 'scrabbli', 'constants')
require File.join(File.dirname(__FILE__), 'scrabbli', 'board_square')
require File.join(File.dirname(__FILE__), 'scrabbli', 'player')
require File.join(File.dirname(__FILE__), 'scrabbli', 'game')
require File.join(File.dirname(__FILE__), 'scrabbli', 'cli') 
hand =  ["A", "R", "Y", "G", "I", "*", "T", "*"] 
player =  Scrabble::Player.new hand

puts player.make_next_move
Benchmark.bm do |x|
	x.report {player.make_next_move}
end

# puts player.traverse "UDBKFB"