from piece import Piece
import sys
sys.path.append("..")
from Modules import slideable

class Queen(Piece):
	__import__('Modules.slideable')
	def __init__(self, board, color, pos):
		Piece.__init__(self, board, color, pos)

	def to_s(self):
		return u'\u2655'

	def valid_moves(self):
		return slideable.perpendiculars(self.board, self.pos) + slideable.diagonals(self.board, self.pos)
