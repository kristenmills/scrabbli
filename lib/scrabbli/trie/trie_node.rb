module Trie
	# The Trie Node class
	class TrieNode

		attr_accessor :value, :children, :terminal

		# Create a new Trie node
		#
		# @param [String] value the character for this node
		def initialize value
			@children = Hash.new
			@value =  value
			@terminal = false
		end

		# Attempts to walk down to the tree to the given letter.
		#
		# @param [String] char the character you are trying to reach
		# @return the node for that char or nil if it doesn't exist
		def walk char
			@children[char]
		end

	end
end