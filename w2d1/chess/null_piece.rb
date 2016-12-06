require_relative 'piece'

class NullPiece < Piece
	def initialize(color = nil, position = nil)
		super(color, position)
	end
end
