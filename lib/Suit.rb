module Suit
  SPADES   = 0
  HEARTS   = 1
  DIAMONDS = 2
  CLUBS    = 3

  SPADE   = '♠'
  HEART   = '♥'
  DIAMOND = '♦'
  CLUB    = '♣'

  SUITS    = [SPADES, HEARTS, DIAMONDS, CLUBS]

  def self.valid? suit
    SUITS.include? suit
  end
end
