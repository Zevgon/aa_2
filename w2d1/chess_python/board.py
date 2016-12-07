from Pieces import *
from termcolor import colored
import sys

class Board:
	@classmethod
	def new_empty_grid(self, size):
		return [[None for i in range(size)] for i in range(size)]

	@classmethod
	def find_king(self, board, player_color):
		for row in board.grid:
			for piece in row:
				if piece.__class__ == king.King and piece.color == player_color:
					return piece
		raise Exception('King not found')

	def __init__(self, size = 8):
		self.colors = ['red', 'white']
		self.player1 = self.colors[0]
		self.player2 = self.colors[1]
		self.bg_colors = ['blue', 'yellow']
		self.null_color = 'yellow'
		self.grid = Board.new_grid(self, size)
		self.player1_king = Board.find_king(self, self.player1)
		self.player2_king = Board.find_king(self, self.player2)
		self.size = size

		self.letter_map = {
		  'a': 0,
		  'b': 1,
		  'c': 2,
		  'd': 3,
		  'e': 4,
		  'f': 5,
		  'g': 6,
		  'h': 7
		}

		self.number_map = [8, 7, 6, 5, 4, 3, 2, 1, 0]

		self.background_colors = {
		  'blue': '\033[44;1m',
		  'yellow': '\033[43;1m'
		}
		self.foreground_colors = {
		  'red': '\033[31;1m',
		  'white': '\033[37;1m',
		  'yellow': '\033[33;1m'
		}
		self.end_color = '\033[0m'

	def all_pieces_of_color(self, color):
		pieces = []
		for row in self.grid:
			for piece in row:
				if piece.color == color:
					pieces.append(piece)
		return pieces

	def at(self, alpha_num):
		pos = self.alphanum_to_pos(alphanum)
		return self.piece_at([row_idx, col_idx])

	def check_mate(self):
		if self.player1_king.in_check() and not self.player1_king.valid_moves():
			return True
		elif self.player2_king.in_check() and not self.player2_king.valid_moves():
			return True
		else:
			return False

	def alphanum_to_pos(self, alpha_num):
		letter = alpha_num[0]
		num = int(alpha_num[1])
		row_idx = self.number_map[num]
		col_idx = self.letter_map[letter]
		return [row_idx, col_idx]

	def create_ansi_string(self, string, bg, fg):
		fg_start = self.foreground_colors[fg]
		if not fg_start:
			return 'Foreground color not available'
		bg_start = self.background_colors[bg]
		if not bg_start:
			return 'Background color not available'
		return fg_start + bg_start + string + self.end_color + self.end_color

	def different_colors(self, pos1, pos2):
		piece1 = self.grid[pos1[0]][pos1[1]]
		piece2 = self.grid[pos2[0]][pos2[1]]
		colors = [piece1.color, piece2.color]
		if colors[0] != colors[1]:
			return True
		else:
			return False

	def in_bounds(self, pos):
		return all(el >= 0 and el <= self.size for el in pos)

	def move(self, pos1, pos2):
		if not self.occupied(pos1):
			print 'No piece there'
			return None
		i1, j1 = pos1
		i2, j2 = pos2
		piece = self.grid[i1][j1]
		print piece.valid_moves()
		if pos2 in piece.valid_moves():
			self.grid[i2][j2] = self.grid[i1][j1]
			piece.pos = pos2
			self.grid[i1][j1] = null_piece.NullPiece(self, self.null_color, [i1, j1])

	def new_grid(self, size):
		empty_grid = Board.new_empty_grid(size)
		piece_map = {
		  0: rook.Rook,
		  1: knight.Knight,
		  2: bishop.Bishop,
		  3: queen.Queen,
		  4: king.King,
		  5: bishop.Bishop,
		  6: knight.Knight,
		  7: rook.Rook
		}
		color = self.colors[0]
		for row in [0, 7]:
			if row == 7:
				color = self.colors[1]
			for col in range(8):
				empty_grid[row][col] = piece_map[col](self, color, [row, col])

		color = self.colors[0]
		for row in [1, 6]:
			if row == 6:
				color = self.colors[1]
			for col in range(8):
				empty_grid[row][col] = pawn.Pawn(self, color, [row, col])

		color = self.null_color
		for row in [2, 3, 4, 5]:
			for col in range(8):
				empty_grid[row][col] = null_piece.NullPiece(self, color, [row, col])

		return empty_grid

	def no_moves_for_team(self, color):
		for piece in self.all_pieces_of_color(color):
			if piece.valid_moves():
				return False
		return True

	def null_piece(self, pos):
		return null_piece.NullPiece(self, self.null_color, pos)

	def occupied(self, pos):
		if self.grid[pos[0]][pos[1]].__class__ == null_piece.NullPiece:
			return False
		else:
			return True

	def opposite_color(self, color):
		if color == self.player1:
			return self.player2
		else:
			return self.player1

	def opposite_colors(self, piece1, piece2):
		colors = [piece1.color, piece2.color]
		colors.sort()
		self_colors = list(self.colors)
		self_colors.sort()
		return colors == self_colors

	def over(self):
		return self.stale_mate() or self.check_mate()

	def piece_at(self, pos):
		i, j = pos
		return self.grid[i][j]

	def same_colors(self, piece1, piece2):
		return piece1.color == piece2.color

	#TODO Fix this so it accounts for whose move it is
	def stale_mate(self):
		if not self.player1_king.in_check() and self.no_moves_for_team(self.player1):
			return True
		elif not self.player2_king.in_check() and self.no_moves_for_team(self.player2):
			return True
		else:
			return False

	def render(self):
		bgs = {
		  True: self.bg_colors[0],
		  False: self.bg_colors[1]
		}
		bg = True
		print
		for row in range(8):
			bg = not bg
			print str(8 - row) + " ",
			for col in range(8):
				bg = not bg
				piece = self.grid[row][col]
				sys.stdout.write(self.create_ansi_string(piece.to_s(), bgs[bg], piece.color))
			print
		print '   a  b  c  d  e  f  g  h'

	def test_move(self, pos1, pos2):
		if not self.occupied(pos1):
			print 'No piece there'
			return None
		i1, j1 = pos1
		i2, j2 = pos2
		piece = self.grid[i1][j1]
		self.grid[i2][j2] = self.grid[i1][j1]
		piece.pos = pos2
		self.grid[i1][j1] = null_piece.NullPiece(self, self.null_color, [i1, j1])

# b = Board()
# b.test_move([0, 3], [2, 4])
# print b.at('e2')
# b.render()
# b = Board()
# print b.piece_at([0, 0]).valid_moves()
