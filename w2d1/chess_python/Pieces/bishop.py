from piece import Piece
import sys
sys.path.append('..')
from Modules import slideable

class Bishop(Piece):
	__import__('Modules.slideable')
	def __init__(self, board, color, pos):
		Piece.__init__(self, board, color, pos)

	def to_s(self):
		return u'\u2657'

	def valid_moves(self):
		return slideable.diagonals(self.board, self.pos)
