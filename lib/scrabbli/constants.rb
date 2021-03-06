module Scrabble

	extend self
	#The hash of letters to point value
	TILE_VALUE = {
		"A" => 1 ,
 		"B" => 3 ,
 		"C" => 3 ,
 		"D" => 2 ,
 		"E" => 1 ,
 		"F" => 4 ,
 		"G" => 2 ,
 		"H" => 4 ,
 		"I" => 1 ,
 		"J" => 8 ,
 		"K" => 5 ,
 		"L" => 1 ,
 		"M" => 3 ,
 		"N" => 1 ,
 		"O" => 1 ,
 		"P" => 3 ,
 		"Q" => 10 ,
 		"R" => 1 ,
 		"S" => 1 ,
 		"T" => 1 ,
 		"U" => 1 ,
 		"V" => 4 ,
 		"W" => 4 ,
 		"X" => 8 ,
 		"Y" => 4 ,
 		"Z" => 10 ,
 		"*" => 0
 	}

 	#The dictionary
	DICTIONARY = Trie::Trie.new
	DICTIONARY.load(File.open(File.join(File.dirname(__FILE__), '..', '..', 'dictionary.txt')))

	#A wrapper around scrabble words
	ScrabbleWord = Struct.new(:word, :score, :row, :col, :dir)

	# Are these two words the same?
	#
	# @param [ScrabbleWord] word1 a scrabble word struct
	# @param [ScrabbleWord] word2 a scrabble word struct
	# @return true if yes false if no
	def same_word word1, word2
		word2.word != word1.word && word2.row != word1.row && word2.col != word1.col && word2.dir != word1.dir
	end
end