module Suit
  CLUBS    = 0
  DIAMONDS = 1
  HEARTS   = 2
  SPADES   = 3

  SPADE   = '♠'
  HEART   = '♥'
  DIAMOND = '♦'
  CLUB    = '♣'

  SUITS    = [SPADES, HEARTS, DIAMONDS, CLUBS]

  def self.valid? suit
    SUITS.include? suit
  end
end
