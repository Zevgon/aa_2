class Tile
	attr_accessor :revealed, :val
	attr_reader :flagged
	def initialize(val = 'r')
		@val = val
		@revealed = false
		@flagged = false
	end

	def bomb?
		@val == '*'
	end

	def flag!
		@flagged = true
	end

	def reveal!
		@revealed = true
	end

	def to_s
		if @revealed
			"|#{@val}"
		elsif @flagged
			"|f"
		else
			'|_'
		end
	end

end
