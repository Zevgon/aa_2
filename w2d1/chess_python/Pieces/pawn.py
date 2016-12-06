from piece import Piece

class Pawn(Piece):
	def __init__(self, board, color, pos):
		Piece.__init__(self, board, color, pos)
		self.has_moved = False

	def to_s(self):
		return u'\u265F'

	def valid_moves(self):
		i, j = self.pos
		if self.color == self.board.colors[0]:
			operator1 = int.__add__
			operator2 = int.__sub__
		else:
			operator1 = int.__sub__
			operator2 = int.__add__

		forward_one = [operator1(i, 1), j]
		forward_two = [operator1(i, 2), j]
		forward_left = [operator1(i, 1), operator1(j, 1)]
		forward_right = [operator1(i, 1), operator2(j, 1)]

		return self.filter_valids(forward_one, forward_two, forward_left, forward_right)

	def filter_valids(self, forward_one, forward_two, forward_left, forward_right):
		valids = []
		if self.board.in_bounds(forward_one) and not self.board.occupied(forward_one):
			valids.append(forward_one)
		if self.board.in_bounds(forward_two) and not self.board.occupied(forward_one) and not self.board.occupied(forward_two) and not self.has_moved:
			valids.append(forward_two)
		if self.board.in_bounds(forward_left) and self.board.opposite_colors(self.pos, forward_left):
			valids.append(forward_left)
		if self.board.in_bounds(forward_right) and self.board.opposite_colors(self.pos, forward_right):
			valids.append(forward_right)

		return valids
