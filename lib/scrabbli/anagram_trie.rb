require 'trie'

module Scrabble
  class AnagramTrie

    DICTIONARY = Trie.new

    File.open(File.join('..', '..', 'dictionary.txt')).each_line do |x|
      DICTIONARY.add(x.chomp)
    end

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

