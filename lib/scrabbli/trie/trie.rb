require 'benchmark'
require 'set'

module Scrabble
	# The Trie class
	class Trie

		attr_accessor :root

		# Creates a new Trie
		def initialize 
			@root = TrieNode.new ''
		end

		# Adds a new word to the trie
		def add word
			node = @root
			word.each_char do |char|
				node.children[char] ||= TrieNode.new char, node
				node = node.walk(char)
			end
			node.terminal = true
		end

		# Load the trie using a file
		def load file_name
			File.open(file_name).each_line do |line|
				add(line.chomp)
			end
		end

		# Does this try have the key word
		def has_key? word
			node = @root
			word.each_char do |char|
				break unless node = node.walk(char)
			end
			node.terminal unless node.nil?
		end

		# Gets all words that are anagrams of a given string
		def get_all word
			get_all_recursive @root, word.split(//), ''
		end

		# Recursive get's all anagrams of words
		def get_all_recursive node, word, prefix
			set = Set.new
			word.count.times do 
				s = word.rotate
				word.rotate!
				char = s.shift
				char_array = [char]
				if char == '*'
					char_array = ('A'..'Z').to_a
				end
				char_array.each do |x|
					next unless n = node.walk(x)
					set << (prefix + x) if n.terminal
				
					set += get_all_recursive(n ,s, prefix + x )
				end
			end
			set
		end
	end
end

this = Trie.new
#
# puts "Answer: #{this.load(File.join(File.dirname(__FILE__), '..', '..', '..', 'dictionary.txt'))}"
Benchmark.bm do |x|
	x.report {this.load(File.join(File.dirname(__FILE__), '..', '..', '..', 'dictionary.txt'))}
end

# def thing this
# array = "FORESTRY".split(//).permutation(8).to_set.map{|x| x = x.join}

# s = Set.new
# array.each do |y|
# 	s.merge(this.get_all(y))
# end
# end

# puts this.get_all("TEXTING**").to_a.count
# Benchmark.bm do |x|
# 	x.report { this.get_all "TEXTING**"}
# end