class Card:
	def __init__(self, suit, val):
		self.val = val
		self.suit = suit

	def to_s(self):
		return self.val + ' of ' + self.suit
