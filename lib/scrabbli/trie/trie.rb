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

		# Deletes a word from the trie
		#
		# @param [String] word the word to delete
		def delete word
			node = @root
			word.each_char do |c|
				return nil unless node = node.walk(c)
			end
			node.terminal = false
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
		# @param [String] required a string of characters that must  be included 
		# @return a set of all possible words
		def get_all word, required = ''
			new_word = word.dup
			new_word << required.split(//) unless required == ''
			get_all_recursive @root, new_word, '', required
		end

		# Recursive get's all anagrams of words
		#
		# @param [TrieNode] node the node you are currently on
		# @param [String] word the remain characters in the string
		# @param [String] prefix the already used characters in the word
		# @param [String] required a string of characters that must  be included 
		# @return the set of possible words
		def get_all_recursive node, word, prefix, required
			set = Set.new
			word.count.times do 
				s = word.rotate
				word.rotate!
				char = s.shift
				char_array = [char].flatten
				prefix_more = prefix
				n = node
				if char_array.count >  1
					(char_array.count-1).times do 
						c = char_array.shift
						break unless n = n.walk(c.uncolorize)
						prefix_more += c
					end
					next if n.nil?
				end
				if char == '*'
					char_array = ('A'..'Z').to_a
				end
				char_array.each do |x|
					next unless nn = n.walk(x.uncolorize)
					set << (prefix_more + x) if (nn.terminal && (prefix_more + x).include?(required))
				
					set += get_all_recursive(nn ,s, prefix_more + x, required )
				end
			end
			set
		end
	end
end