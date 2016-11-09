class Tile
	attr_accessor :revealed, :val
	def initialize(val)
		@val = val
		@revealed = false
	end

	def bomb?
		@val == '*'
	end

	def reveal!
		@revealed = true
	end

	def to_s
		@val ? "#{@val}" : ' '
	end

end
