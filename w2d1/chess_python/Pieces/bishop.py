from piece import Piece
import sys
sys.path.append('..')
from Modules import slideable

class Bishop(Piece):
	__import__('Modules.slideable')
	def __init__(self, board, color, pos):
		Piece.__init__(self, board, color, pos)

	def all_moves(self):
		return slideable.diagonals_including_same_color(self.board, self.pos)

	def possibles(self):
		return slideable.diagonals(self.board, self.pos)

	def to_s(self):
		return u' \u2657 '

	def valid_moves(self):
		possibles = self.possibles()
		would_be_checker = Piece.blocking_check_against(self)
		if would_be_checker:
			if would_be_checker.pos in possibles:
				return [would_be_checker.pos]
			else:
				return []
		else:
			return possibles
