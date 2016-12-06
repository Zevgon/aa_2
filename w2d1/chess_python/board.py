from Pieces import *
from termcolor import colored
import sys

class Board:
	@classmethod
	def new_empty_grid(self, size):
		return [[None for i in range(size)] for i in range(size)]

	def __init__(self, size = 8):
		self.colors = ['red', 'white']
		self.null_color = 'yellow'
		self.grid = Board.new_grid(self, size)
		self.size = size

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

	def occupied(self, pos):
		if self.grid[pos[0]][pos[1]].__class__ == null_piece.NullPiece:
			return False
		else:
			return True

	def opposite_colors(self, pos1, pos2):
		piece1 = self.grid[pos1[0]][pos1[1]]
		piece2 = self.grid[pos2[0]][pos2[1]]
		colors = [piece1.color, piece2.color]
		colors.sort()
		self_colors = list(self.colors)
		self_colors.sort()
		return colors == self_colors

	def same_colors(self, pos1, pos2):
		piece1 = self.grid[pos1[0]][pos1[1]]
		piece2 = self.grid[pos2[0]][pos2[1]]
		colors = [piece1.color, piece2.color]
		if colors[0] == colors[1]:
			return True
		else:
			return False

	def to_s(self):
		print
		for row in range(8):
			print '|',
			for col in range(8):
				piece = self.grid[row][col]
				sys.stdout.write(colored(piece.to_s(), piece.color) + '|')
			print
		print

	def move(self, pos1, pos2):
		if not self.occupied(pos1):
			return None
		i1, j1 = pos1
		i2, j2 = pos2
		piece = self.grid[i1][j1]
		if pos2 in piece.valid_moves():
			self.grid[i2][j2] = self.grid[i1][j1]
			self.grid[i1][j1] = null_piece.NullPiece(self, None, [i1, j1])

b = Board()
b.move([6, 3], [3, 3])
b.to_s()
