from piece import Piece

class NullPiece(Piece):
	def __init__(self, board, color, pos):
		Piece.__init__(self, board, color, pos)

	def to_s(self):
		return '   '

	def valid_moves(self):
		raise Exception('No piece at ' + str(self.pos))
