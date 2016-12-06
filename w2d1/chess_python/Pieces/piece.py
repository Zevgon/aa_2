class Piece:
	def __init__(self, board, color, pos):
		self.board = board
		self.color = color
		self.pos = pos

	def to_s(self):
		return 'Subclasses responsible for to_s method'

	def valid_moves(self):
		return 'Subclasses responsible for valid_moves method'

p = Piece(None, 'white', [0, 0])
