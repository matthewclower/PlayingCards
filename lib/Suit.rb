module Suit
  public

  SPADES   = 0
  HEARTS   = 1
  DIAMONDS = 2
  CLUBS    = 3

  SPADES_SYM   = '♠'
  HEARTS_SYM   = '♥'
  DIAMONDS_SYM = '♦'
  CLUBS_SYM    = '♣'

  SUITS    = [SPADES, HEARTS, DIAMONDS, CLUBS]

  def self.valid? suit
    SUITS.include? suit
  end
end
