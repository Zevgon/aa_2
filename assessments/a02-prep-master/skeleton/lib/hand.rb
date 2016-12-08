class Hand
  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
    cards = deck.take(2)
    Hand.new(cards)
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    total = 0
    @cards.each do |card|
      if card.value == :ace
        total += 11
      else
        total += Card::BLACKJACK_VALUE[card.value]
      end
    end

    @cards.each do |card|
      if card.value == :ace && total > 21
        total -= 10
      end
    end
    total
  end

  def busted?
    points > 21
  end

  def hit(deck)
    raise 'already busted' if busted?
    @cards += deck.take(1)
  end

  def beats?(other_hand)
    return false if busted?
    return true if other_hand.busted?
    points > other_hand.points
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
