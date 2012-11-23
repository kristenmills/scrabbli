require 'benchmark'
require 'set'
require 'colorize'

# The Module that contains things relevant the the Trie data structure
module Trie
	# The Trie class
	class Trie

		attr_accessor :root

		# Creates a new Trie
		def initialize 
			@root = TrieNode.new ''
		end

		# Adds a new word to the trie
		#
		# @param [String] word the word to add to the trie
		def add word
			node = @root
			word.each_char do |char|
				node.children[char] ||= TrieNode.new char
				node = node.walk(char)
			end
			node.terminal = true
		end

		# Load the trie using a file
		#
		# @param [String] file_name the file to add
		def load file_name
			File.open(file_name).each_line do |line|
				add(line.chomp)
			end
		end

		# Is this word a word?
		#
		# @param [String] word the string to check to see if it is a word
		def word? word
			node = @root
			word.each_char do |char|
				break unless node = node.walk(char)
			end
			node.terminal unless node.nil?
		end

		# Gets all words that are anagrams of a given string
		# Accepts wild cards as '*'
		#
		# @param [String] word the word you are looking for anagrams of
		# @return a set of all possible words
		def get_all word
			get_all_recursive @root, word, ''
		end

		# Recursive get's all anagrams of words
		#
		# @param [TrieNode] node the node you are currently on
		# @param [String] word the remain characters in the string
		# @param [String] prefix the already used characters in the word
		# @return the set of possible words
		def get_all_recursive node, word, prefix
			set = Set.new
			word.count.times do 
				s = word.rotate
				word.rotate!
				char = s.shift
				char_array = [char]
				if char == '*'
					char_array = ('A'..'Z').to_a#.map{|x| x =  x.light_yellow}
				end
				char_array.each do |x|
					next unless n = node.walk(x.uncolorize)
					set << (prefix + x) if n.terminal
				
					set += get_all_recursive(n ,s, prefix + x )
				end
			end
			set
		end
	end
end
# def thing this
# array = "FORESTRY".split(//).permutation(8).to_set.map{|x| x = x.join}

# s = Set.new
# array.each do |y|
# 	s.merge(this.get_all(y))
# end
# ed

# DICTIONARY = Trie::Trie.new
# DICTIONARY.load(File.open(File.join(File.dirname(__FILE__), '..','..', '..', 'dictionary.txt')))


#  puts DICTIONARY.get_all("FOREST*Y").count
#  Benchmark.bm do |x|
#  	x.report { DICTIONARY.get_all "FOREST*Y"}
#  end