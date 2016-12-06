class Piece
	def initialize(color, position)
		@color = color
		@position = position
	end

	def to_s
		if @color.nil?
			'|_'
		elsif @color == 'white'
			'|w'
		else
			'|b'
		end
	end
end
