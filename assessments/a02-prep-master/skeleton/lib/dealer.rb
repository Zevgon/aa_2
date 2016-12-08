require_relative 'player'

class Dealer < Player
  attr_reader :bets

  def initialize
    super("dealer", 0)

    @bets = {}
  end

  def place_bet(dealer, amt)
    raise 'Dealer doesn\'t bet'
  end

  def play_hand(deck)
    until @hand.points >= 17
      @hand.hit(deck)
    end
  end

  def take_bet(player, amt)
    @bets[player] ? @bets[player] += amt : @bets[player] = amt
  end

  def pay_bets
    @bets.keys.each do |player|
      if player.hand.beats?(@hand)
        player.pay_winnings(@bets[player] * 2)
      end
    end
  end
end
