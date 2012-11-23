require 'trie'
require 'algorithms'
require 'benchmark'
require 'set'

DICTIONARY = Trie.new

File.open(File.join(File.dirname(__FILE__), '..', '..', 'dictionary.txt')).each_line do |x|
  DICTIONARY.add(x.chomp, 1)
end

module Scrabble
  class Player
    attr_accessor :name, :score, :tiles

    #Create a new Scrabble Player
    def initialize  name, tiles=Array.new, score=0
      @name = name
      @score = score
      @tiles = tiles
    end

    def to_s
      @name
    end

    def pp_tiles
     str = ''
     @tiles.each do |x|
      str += x + ","
     end
     (7-@tiles.count).times do
      str += "_,"
     end
     str.chomp
    end

    def get_possible_words
      # node = DICTIONARY.root
      possible_words = @tiles.permutation(8).to_set.map{|x| x = x.join}
      words = Set.new
      possible_words.each do |w|
        # words += DICTIONARY.wildcard(w)
        node = DICTIONARY.root
        # w = filter(w)
        words.merge(recursion_man(w, node))
      #   w.each do |word|
      #   word.split(//).each do |char|
      #     break unless node.walk!(char)
      #     if node.terminal?
      #       words << node.full_state
      #     end
      #   end
      # end
      end
      words
    end

    def recursion_man word, node
      words = Set.new
      word.split(//).each do |char|
        if(char == '*')
          'A'.upto('Z') do |x|
            next unless n = node.walk(x)
            if n.terminal?
              words << n.full_state
            end
            words += recursion_man(word.partition("*")[2],n)
          end
        else
          break unless node.walk!(char)
          if node.terminal?
            words << node.full_state
          end
        end
      end
      words
    end

    def filter word
      other_array = [word]
      word.count("*").times do
        array = Array.new
        other_array.each do |x|
          'A'.upto('Z') do |y|
            array << x.sub('*', y)
          end
        end
        other_array = array
      end
      other_array
    end

  end
end

# puts "Answer: #{DICTIONARY.wildcard("FORESTRY")}"
# Benchmark.bm do |x|
#   x.report {get_possible_words}
# end

# node = DICTIONARY.root.walk('Q')

# while true
# #   puts "cheese"
# #   break unless n = node.walk('U')
# # end
# p = Scrabble::Player.new "Kristen"

# puts p.recursion_man("F*ORSTRY", DICTIONARY.root).to_a