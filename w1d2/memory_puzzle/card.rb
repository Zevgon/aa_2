class Card
	attr_reader :hidden, :val
	def initialize(val)
		@val = val
		@hidden = true
	end

	def hide!
		@hidden = true
	end

	def reveal!
		@hidden = false
	end

	def ==(other_card)
		other_card.val == @val
	end

	def to_s
		if @hidden
			print '|_'
		else
			print "|#{@val}"
		end
	end
end
