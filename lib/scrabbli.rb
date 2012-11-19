# The module that contains relevant scrabble things
module Scrabble

end

require File.join(File.dirname(__FILE__), 'scrabbli', 'constants')
require File.join(File.dirname(__FILE__), 'scrabbli', 'tile')
require File.join(File.dirname(__FILE__), 'scrabbli', 'board_square')
require File.join(File.dirname(__FILE__), 'scrabbli', 'board')
require File.join(File.dirname(__FILE__), 'scrabbli', 'player')
require File.join(File.dirname(__FILE__), 'scrabbli', 'game')

hand = ["A", "R", "Y", "G", "F", "P", "I"]
player =  Scrabble::Player.new hand

puts player.make_next_move 