class Trie

	attr_accessor :root

	def initialize 

end

require 'Benchmark'

class TrieNode

	attr_accessor :value, :parent, :children, :terminal

	def char_to_instance char
		("@"+char).to_sym
	end

	def initialize value, terminal, parent = nil
		@parent = parent
		@children = Hash.new
		@value = value
		@terminal = terminal
	end

	def walk char
		@children[char]
	end

	def walk! char
		child = walk(char)
		return nil if child.nil?
		@parent = child.parent
		@value = child.value
		@children = child.children
		return self
	end

	def leaf?
		@children.count == 0
	end

end


root = TrieNode.new 'E'
root.C = TrieNode.new 'C'
root.A = TrieNode.new 'A'
root.Z = TrieNode.new 'Z'
# root.children['C'] = TrieNode.new 'C'
# root.children['A'] = TrieNode.new 'A'
# root.children['Z'] = TrieNode.new 'Z'

puts "Answer: #{root.walk('C')}"
Benchmark.bm do |x|
	x.report {root.walk('Z')}
end