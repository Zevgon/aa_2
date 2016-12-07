from piece import Piece

class Pawn(Piece):
	def __init__(self, board, color, pos):
		Piece.__init__(self, board, color, pos)
		self.has_moved = False
		if self.color == self.board.player1:
			self.operator1 = int.__add__
			self.operator2 = int.__sub__
		else:
			self.operator1 = int.__sub__
			self.operator2 = int.__add__

	def filter_valids(self, forward_one, forward_two, forward_left, forward_right):
		valids = []
		if self.board.in_bounds(forward_one) and not self.board.occupied(forward_one):
			valids.append(forward_one)
		if self.board.in_bounds(forward_two) and not self.board.occupied(forward_one) and not self.board.occupied(forward_two) and not self.has_moved:
			valids.append(forward_two)
		forward_left_piece = self.board.piece_at(forward_left)
		if self.board.in_bounds(forward_left) and self.board.opposite_colors(self, forward_left_piece):
			valids.append(forward_left)
		forward_right_piece = self.board.piece_at(forward_right)
		if self.board.in_bounds(forward_right) and self.board.opposite_colors(self, forward_right_piece):
			valids.append(forward_right)

		return valids

	def possibles(self):
		return self.taking_positions()

	def guarding(self, pos):
		other_piece = self.board.piece_at(pos)
		return pos in self.taking_positions() and self.color == other_piece.color

	def taking_positions(self):
		i, j = self.pos
		return [[self.operator1(i, 1), self.operator1(j, 1)], [self.operator1(i, 1), self.operator2(j, 1)]]

	def threatening(self, other_piece):
		return other_piece.pos in self.taking_positions()

	def to_s(self):
		return u' \u265F '

	def valid_moves(self):
		would_be_checker = Piece.blocking_check_against(self)
		if would_be_checker:
			if would_be_checker.pos in self.possibles():
				return [would_be_checker.pos]
			else:
				return []
		i, j = self.pos
		forward_one = [self.operator1(i, 1), j]
		forward_two = [self.operator1(i, 2), j]
		forward_left, forward_right = self.taking_positions()

		return self.filter_valids(forward_one, forward_two, forward_left, forward_right)
