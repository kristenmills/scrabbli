class TrieNode

	attr_accessor :value, :children, :terminal

	def char_to_instance char
		("@"+char).to_sym
	end

	def initialize value, parent = nil
		@children = Hash.new
		@value =  value
		@terminal = false
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