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
			word[0].each do |x|
				str += x.letter
			end
			str += " " + word[1].to_s + " " + word[2].to_s
			str
		end

	end