class Piece:
	def __init__(self, board, color, pos):
		self.board = board
		self.color = color
		self.pos = pos

	def add_self_to_board(self):
		i, j = self.pos
		self.board.grid[i][j] = self

	def all_moves(self):
		return 'Subclasses responsible for all_moves method'

	def blocking_check_against(self):
		self.remove_self_from_board()
		threatening = self.own_king().being_threatened_by()
		self.add_self_to_board()
		return threatening

	def being_threatened_by(self):
		other_color = self.board.opposite_color(self.color)
		print self.board.all_pieces_of_color(other_color)[0].color
		for enemy_piece in self.board.all_pieces_of_color(other_color):
			if enemy_piece.threatening(self):
				return enemy_piece
		return None

	def guarding(self, pos):
		return pos in self.all_moves()

	def own_king(self):
		return filter(lambda king: king.color == self.color, [self.board.player1_king, self.board.player2_king])[0]

	def remove_self_from_board(self):
		i, j = self.pos
		self.board.grid[i][j] = self.board.null_piece(self.pos)

	def threatening(self, other_piece):
		return other_piece.pos in self.possibles()

	def to_s(self):
		return 'Subclasses responsible for to_s method'

	def valid_moves(self):
		return 'Subclasses responsible for valid_moves method'
