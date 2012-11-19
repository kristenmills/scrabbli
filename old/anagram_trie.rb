require 'trie'

module Scrabble
  class AnagramTrie

   
    attr_accessor :value, :children

    def initialize value = ''
      @value = value
      @children = {}
    end

    def [] val
      @children[val]
    end

    def []= val, trie
      @children[val] = trie
    end

    def next_val char
      self.value + char
    end

    def filter str, rest
      prefix = DICTIONARY.children_with_prefix(str)
      sorted = rest.chars.sort.join
      prefix.keep_if {|item| item.length <= str.length + rest.length &&(sorted.match(/#{ item.sub(str, '').chars.sort.join(".*")}/))}.nil?
    end 

    def self.build_trie str, root = nil
      root ||= AnagramTrie.new
      str.each_char do |char|
        rest = str.sub char, ''
        if char == '*'
          'A'.upto('Z') do |c|
            root[c] ||= AnagramTrie.build_trie(rest, AnagramTrie.new(root.next_val(c)))
          end
        else
          root[char] ||= AnagramTrie.build_trie(rest, AnagramTrie.new(root.next_val(char)))
        end
      end
      root
    end 

    def self.traverse root
      values = Array.new
      root.children.each do |x|
        values <<  x[1].value if DICTIONARY.has_key?(x[1].value)
        values.concat(AnagramTrie.traverse(x[1]))
      end
      values
    end
  end
end
super_hands = Array.new
hand= ["A", "R", "Y", "G", "F", "P", "I"]
super_hands.concat(hand.permutation(2).to_a.map{|x| x = x.join})
super_hands.concat(hand.permutation(3).to_a.map{|x| x = x.join})
super_hands.concat(hand.permutation(4).to_a.map{|x| x = x.join})
super_hands.concat(hand.permutation(5).to_a.map{|x| x = x.join})
super_hands.concat(hand.permutation(6).to_a.map{|x| x = x.join})
super_hands.concat(hand.permutation(7).to_a.map{|x| x = x.join})
super_duper_hands = Array.new
super_hands.each do |x|
  super_duper_hands << x if Scrabble::AnagramTrie::DICTIONARY.has_key?(x)
end
puts super_duper_hands
