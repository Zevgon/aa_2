from piece import Piece
import sys
sys.path.append('..')
from Modules import stepable

class King(Piece):
	__import__('Modules.stepable')
	def __init__(self, board, color, pos):
		Piece.__init__(self, board, color, pos)

	def all_moves(self):
		return stepable.adjacent_king_moves(self.pos)

	def possibles(self):
		return stepable.valid_king_moves(self.board, self.pos)

	def in_check(self):
		return not not Piece.being_threatened_by(self)

	def to_s(self):
		return u' \u2654 '

	#TODO Fix king valid moves method to not be able to move to a guarded square
	def valid_moves(self):
		return stepable.valid_king_moves(self.board, self.pos)
