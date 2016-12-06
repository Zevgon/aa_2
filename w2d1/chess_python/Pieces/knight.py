from piece import Piece
import sys
sys.path.append('..')
from Modules import stepable

class Knight(Piece):
	__import__('Modules.stepable')
	def __init__(self, board, color, pos):
		Piece.__init__(self, board, color, pos)

	def to_s(self):
		return u'\u2658'

	def valid_moves(self):
		return stepable.valid_knight_moves(self.board, self.pos)
