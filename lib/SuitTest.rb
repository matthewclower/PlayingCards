require 'Suit'

class SuitTest < RubyUnit::TestCase
  def validSuitsData
    [
      [  Suit::SPADES],
      [  Suit::HEARTS],
      [Suit::DIAMONDS],
      [   Suit::CLUBS],
    ]
  end

  def invalidSuitsData
    [
      [ false],
      [   1.5],
      [  4242],
      ['text'],
    ]
  end

  def validSuitsTest suit
    assert Suit::valid?(suit), "#{suit} should be a valid Suit"
  end
  
  def invalidSuitsTest suit
    assertNot Suit::valid?(suit), "#{suit} should not be a valid Suit"
  end
end
