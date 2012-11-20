	class Tile

		attr_accessor :letter, :value

		def initialize letter, value
			@letter = letter
			@value  = value
		end

		def to_s
			str = "#{@letter}"
		end

		def self.score tiles
			sum = 0
			tiles.each do |x|
				sum += x.value
			end
			sum
		end

		def self.display word
			str = ''
			word.each do |x|
				str += x.letter
			end
			str
		end

	end