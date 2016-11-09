class Tile
	attr_reader :given
	attr_accessor :val
	def initialize(val, given = false)
		@val = val
		@given = given
	end

	def to_s
		"|#{val}"
	end
end
