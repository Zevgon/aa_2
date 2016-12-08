class Player:
	def __init__(self, name, bank = 1000):
		self.name = name
		self.cards = []
		self.bank = bank

	def bet(self, amt):
		if amt > self.bank:
			return 'Cannot bet more than you have'
		else:
			self.bank -= amt

	def receive_winnings(self, pot):
		self.bank += pot
